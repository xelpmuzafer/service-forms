import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:linear_step_indicator/linear_step_indicator.dart';
import 'dart:async';
import "package:collection/collection.dart";
import 'package:surveynow/config/appColors.dart';
import 'package:surveynow/config/textStyles.dart';
import 'package:surveynow/constants/appStrings.dart';
import 'package:surveynow/models/questionModel.dart';
import 'package:shared_preferences/shared_preferences.dart'; // rememeber to import shared_preferences: ^0.5.4+8
import 'package:surveynow/services/http_service.dart';
import 'package:surveynow/utils/dateFormatter.dart';
import 'package:surveynow/utils/inputDecorations.dart';
import 'package:surveynow/utils/validations.dart';
import 'package:surveynow/widgets/customButton.dart';

const int STEPS = 5;

class FormStepper extends StatefulWidget {
  final id;
  const FormStepper({Key? key, this.id}) : super(key: key);

  @override
  _FormStepperState createState() => _FormStepperState();
}

class _FormStepperState extends State<FormStepper> {
  Map<String, TextEditingController> _controllers = {};

  late SharedPreferences prefs;

  final pageController = PageController();
  int initialPage = 0;

  List<Object> child_options = [];

  List<dynamic> questions = [];

  var question_names = {};

  var alias = {};

  bool is_loaded = false;

  TextEditingController nameController = TextEditingController();

  var email;

  var loading = false;

  var userResponse = {};
  Map<String, dynamic> payloadData = {};

  preparePayload() {
    userResponse.forEach((k, v) {
      if (v != "") {
        for (var item in questions) {
          if (item.name == k) {
            payloadData[item.name!] = v;
          }
        }
      }
    });

    print("------------------Prepared payloadData-------");
    print(payloadData);
    print(userResponse);
  }

  saveReponse(dynamic ques, dynamic ans) {
    userResponse[ques.name] = ans;

    String encodedMap = json.encode(userResponse);

    prefs.setString('userResponse', encodedMap);

    preparePayload();
  }

  NextPage() {
    setState(() {
      initialPage += 1;
    });

    pageController.jumpToPage(initialPage);

    generatePages();
  }

  PrevPage() {
    setState(() {
      initialPage -= 1;
    });

    pageController.jumpToPage(initialPage);

    generatePages();
  }

  SubmitForm() {
    print(userResponse);
  }

  getWidget(DynamicFormField ques) {
    switch (ques.type) {
      case "heading":
        return Center(
          child: Text(ques.name!, style: h2PrimaryBold),
        );
      case "subheading":
        return Container(
            child: Text(
          ques.name!,
          style: h1PrimaryBold,
        ));

      case "p":
        return Container(
            child: Text(
          ques.name!,
          style: TextStyle(fontWeight: FontWeight.w400),
        ));
      case "text":
        return SizedBox(
          height: 40,
          child: TextFormField(
              onChanged: (value) {
                saveReponse(ques, value);
              },
              keyboardType: TextInputType.multiline,
              minLines: 1, //Normal textInputField will be displayed
              maxLines: 5, // when user presses enter it will adapt to it
              initialValue: userResponse[ques.name],
              textInputAction: TextInputAction.done,
              maxLength: 6,
              style: h4BlackSemiBold,
              cursorColor: AppColors.kPrimaryColor,
              decoration: InputDecoration(
                counterText: "",
                labelText: '${ques.name}',
                hintText: 'Enter ${ques.name}',
                labelStyle: h6Black.copyWith(
                    fontSize: 8, color: AppColors.textBlackThin),
                fillColor: AppColors.white,
                hintStyle: h5BlackLight.copyWith(color: AppColors.lightGrey),
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              )),
        );

      case "date":
        return Container(
          // height: 40,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: IgnorePointer(
                  child: TextFormField(
                    
                    controller: _controllers[ques.name],
                    inputFormatters: [DateTextFormatter()],
                    style: h4BlackSemiBold,
                    cursorColor: AppColors.kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: ques.name,
                      labelStyle: h6Black.copyWith(
                          fontSize: 8, color: AppColors.textBlackThin),
                      fillColor: AppColors.white,
                      hintStyle:
                          h5BlackLight.copyWith(color: AppColors.lightGrey),
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    ),
                    validator: (val) => Validations.commonValidate(
                        value: val, title: ques.name),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  selectDate(context, ques);
                },
                child: Icon(Icons.calendar_month),
              ),
            ],
          ),
        );

      case "number":
        return Container(
          child: TextFormField(
            initialValue: userResponse[ques.name],
            onChanged: (value) {
              saveReponse(ques, value);
            },
            decoration: InputDecoration(
              hintText: 'Enter ${ques.name}',
              labelStyle:
                  h6Black.copyWith(fontSize: 8, color: AppColors.textBlackThin),
              fillColor: AppColors.white,
              hintStyle: h5BlackLight.copyWith(color: AppColors.lightGrey),
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            ),
            autofocus: false,
            keyboardType: TextInputType.number,
          ),
        );

      case "dropdown":
        return ques.options == null
            ? null
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ques.name!,
                    style:
                        TextStyle(fontSize: 8, color: AppColors.textBlackThin),
                  ),
                  DropDown(
                      initialValue: userResponse[ques.name],
                      isExpanded: true,
                      items: ques.options!,
                      hint: Text(
                        ques.options!.length > 0
                            ? ques.options![0].toString()
                            : "",
                        style: TextStyle(
                            fontSize: 8, color: AppColors.textBlackThin),
                      ),
                      icon: Icon(
                        Icons.expand_more,
                        color: Colors.blue,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          saveReponse(ques, newValue);
                        });
                      }),
                ],
              );

           case "sub-dropdown-value":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ques.name!),
            DropDown(
                isExpanded: true,
                items: child_options,
                hint: Text(ques.name!),
                icon: Icon(
                  Icons.expand_more,
                  color: Colors.blue,
                ),
                onChanged: (newValue) {
                  setState(() {
                    // userResponse[ques.name] = newValue!;
                    saveReponse(ques, newValue);
                  });
                }),
          ],
        );

      case "sub-dropdown-parent":
               return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              ques.name!,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: double.infinity,
              child: DropDown(
                  initialValue: userResponse[ques.name],
                  isExpanded: true,
                  items: ques.options!,
                  hint: Text(ques.options![0]),
                  icon: Icon(
                    Icons.expand_more,
                    color: Colors.blue,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      saveReponse(ques, newValue);

                      child_options.clear();
                    });

                    print("----------------changed-----------------------");

                    late dynamic selected_parent_value;
                    for (var item in questions) {
                      if (item.type == "sub-dropdown-parent") {
                        selected_parent_value = userResponse[ques.name];
                      }
                    }

                    print(
                        "---------------------------------------------------USER SELECTED------------------");
                    print(selected_parent_value.toString());

                    for (DynamicFormField item in questions) {
                      if (item.type == "subdropdown-options" &&
                          item.name == selected_parent_value) {
                        List<Object> temp = [];

                        for (var x in item.options!) {
                          temp.add(x.toString());
                        }
                        setState(() {
                          child_options = temp;
                        });
                      }
                    }

                    print(child_options);
                  }),
            ),
          ],
        );
    }
  }

  late Map page_list;
  List<Widget> pages_All = [];
  fetchData() async {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        prefs = value;
      });

      print("decoding");

      var filledResponses = prefs.getString("userResponse");
      if (filledResponses != "" && filledResponses != null) {
        Map<String, dynamic> decodedMap = json.decode(filledResponses);

        print(decodedMap);

        setState(() {
          userResponse = decodedMap;
        });
      }
    });
    List<dynamic> jsondata = await HttpService().getForm(widget.id.toString());

    setState(() {
      questions = jsondata;
      page_list = groupBy(questions, (dynamic obj) => obj.page);
      generatePages();
    });

    setState(() {
      is_loaded = true;
    });
  }

  generatePages() async {
    pages_All = [];
    for (var key in page_list.keys.toList()) {
      List<Widget> widgets = [];

      var element = page_list[key];
      element.forEach((ques) {
        
        try {
          if (["text", "date", "number"].contains(ques.type)) {
            _controllers[ques.name!] = TextEditingController();
            if(ques.type == "date"){

              if(userResponse.keys.contains(ques.name!)){
                _controllers[ques.name!]!.text = userResponse[ques.name];
              }
                 
            }
          }

          var w = getWidget(ques);

          widgets.add(Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: w!,
          ));
        } catch (e) {
          print(e);
        }
      });
      pages_All.add(ListView(
        children: widgets,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Service Forms"),
          actions: [
            IconButton(
                onPressed: () {
                  prefs.setString("userResponse", "");
                  fetchData();
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        body: Container(
          color: Colors.white,
          child: pages_All.length == 0
              ? null
              : Column(
                  children: [
                    StepperWidget(),
                    Expanded(
                      child: pages_All.length == 0
                          ? SizedBox()
                          : PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: pageController,
                              children: List.generate(pages_All.length,
                                  (index) => pages_All[index])),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ElevatedButton(
                                onPressed: initialPage == 0 ? null : PrevPage,
                                child: Text("Back")),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: initialPage == page_list.keys.length
                                      ? Colors.green
                                      : Colors.blue,
                                ),
                                onPressed: initialPage == page_list.keys.length
                                    ? SubmitForm
                                    : NextPage,
                                child: Text(initialPage == page_list.keys.length
                                    ? "Submit"
                                    : "Next")),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
        ),
      ),
    );
  }

  FullLinearStepIndicator StepperWidget() {
    return FullLinearStepIndicator(
      steps: pages_All.length,
      activeBorderColor: Colors.green,
      lineHeight: 12,
      completedIcon: Icons.check,
      activeNodeColor: Color.fromARGB(117, 27, 212, 33),
      inActiveNodeColor: const Color(0xffd1d5d8),
      activeLineColor: Color.fromARGB(117, 76, 175, 79),
      inActiveLineColor: const Color(0xffd1d5d8),
      nodeSize: 4,
      controller: pageController,
      complete: () {
        //typically, you'd want to put logic that returns true when all the steps
        //are completed here
        return Future.value(true);
      },
    );
  }

  Future<dynamic> selectDate(BuildContext context, ques) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      
      initialDate: DateTime.now().subtract(Duration(days: 1)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(Duration(days: 1)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.kPrimaryColor, // <-- SEE HERE
              onPrimary: AppColors.white, // <-- SEE HERE
              onSurface: AppColors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.kPrimaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        var selectedDate = DateFormat("dd-MM-yyyy").format(picked);
        _controllers[ques.name!]!.text = selectedDate;
        saveReponse(ques, selectedDate);
      });
    }
  }
}
