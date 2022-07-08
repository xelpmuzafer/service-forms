import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:linear_step_indicator/linear_step_indicator.dart';
import 'dart:async';
import "package:collection/collection.dart";
import 'package:surveynow/models/questionModel.dart';

import 'package:surveynow/services/http_service.dart';

const int STEPS = 5;

class FormStepper extends StatefulWidget {
  final id;
  const FormStepper({Key? key, this.id}) : super(key: key);

  @override
  _FormStepperState createState() => _FormStepperState();
}

class _FormStepperState extends State<FormStepper> {
  final pageController = PageController();
  int initialPage = 0;

  List<Object> child_options = [];

  List<Datum> questions = [];

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
    preparePayload();
  }

  getWidget(Datum ques) {
    switch (ques.type) {
      case "heading":
        return Center(
            child: Text(
          ques.name!,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(230, 26, 24, 24),
              fontSize: 18),
        ));
      case "subheading":
        return Container(
            child: Text(
          ques.name!,
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
        ));

      case "p":
        return Container(
            child: Text(
          ques.name!,
          style: TextStyle(fontWeight: FontWeight.w400),
        ));
      case "text":
        return Container(
            child: TextFormField(
              initialValue : userResponse[ques.name]  ?? null,
          onChanged: (value) {
            saveReponse(ques, value);
          },
          
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '${ques.name}',
            hintText: 'Enter ${ques.name}',
          ),
          autofocus: false,
        ));

      case "date":
        return Container(
            child: TextField(
          onChanged: (value) {
            saveReponse(ques, value);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '${ques.name}',
            hintText: 'Enter ${ques.name}',
          ),
          autofocus: false,
        ));

      case "number":
        return Container(
          child: TextField(
            onChanged: (value) {
              saveReponse(ques, value);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter ${ques.name}',
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
                  Text(ques.name!),
                  DropDown(
                      isExpanded: true,
                      items: ques.options!,
                      hint: Text(ques.options!.length > 0
                          ? ques.options![0].toString()
                          : ""),
                      icon: Icon(
                        Icons.expand_more,
                        color: Colors.blue,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          userResponse[ques.name] = newValue!;
                          saveReponse(ques, newValue);
                        });
                      }),
                ],
              );

      case "subdropdown-options1":
        return DropDown(
            isExpanded: true,
            items: ques.options!,
            hint: Text(ques.options![0]),
            icon: Icon(
              Icons.expand_more,
              color: Colors.blue,
            ),
            onChanged: (newValue) {
              setState(() {
                userResponse[ques.name] = newValue!;
                saveReponse(ques, newValue);
              });
            });

      case "sub-dropdown-value":
        return  Column(
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
                          userResponse[ques.name] = newValue!;
                          saveReponse(ques, newValue);
                        });
                      }),
                ],
              );

      case "sub-dropdown-parent":
        userResponse[ques.name] = ques.options![0];

        // for(var x in questions){
        //   if(x['type'] == 'subdropdown-options' && x['name'] == ques['options'][0]){
        //         setState(() {
        //           child_options = x['options'];
        //         });
        //   }
        // }

        dynamic p_options = ques.options!;

        p_options.insert(0, "");

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
                  isExpanded: true,
                  items: p_options,
                  hint: Text(ques.options![0]),
                  icon: Icon(
                    Icons.expand_more,
                    color: Colors.blue,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      userResponse[ques.name] = newValue!;
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

                    for (Datum item in questions) {
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

  late Map pages1;
  List<Widget> pages_All = [];
  fetchData() async {
    print("called");
    QuestionsModel json = await HttpService().getForm("test");

    setState(() {
      questions = json.document!.data!;

      pages1 = groupBy(questions, (Datum obj) => obj.page);

      print("-----------------res-----------------------");
      print(pages1);

      pages1.values.forEach((element) {
        List<Widget> widgets = [];
        element.forEach((Datum ques) {
          print(ques.type);
          try {
            var w = getWidget(ques);

            widgets.add(Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: w!,
            ));
          } catch (e) {
            print(
                "---------------------------------------ERROE-------------------------OCCORED----------------");
            print(ques.name);
            print(e);
          }
        });
        pages_All.add(ListView(
          children: widgets,
        ));
      });

      print(
          "==============================GENERATED PAGES========================");
      print(pages_All);

      // for (var item in questions) {

      //   if (!["heading", "subheading", "subdropdown-options"]
      //       .contains(item['type']) && item['name'] != null) {
      //     alias[item['alias']] = item['alias'];
      //     question_names[item['alias']] = item['question'];
      //     print("-----------------");
      //     print(item);

      //     userResponse[item['name']] = "";
      //   }
      // }
    });

    setState(() {
      is_loaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();

    // pageController.jumpToPage(initialPage);

    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) {
    //     Timer.periodic(
    //       const Duration(milliseconds: 1500),
    //       (_) {

    //         print("========================$timeStamp==============================");
    //         if (mounted) {
    //           initialPage += 1;
    //           if (initialPage == STEPS - 1) {
    //           } else {
    //             print("-------------JUMP-----------------");
    //           }
    //         }
    //       },
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                initialPage = initialPage - 1;
                                pageController.jumpToPage(initialPage);
                              });

                              print(pageController.page);
                            },
                            child: Text("Back")),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                initialPage += 1;
                                pageController.jumpToPage(initialPage);
                              });

                              print(child_options);

                              print(pageController.page);
                            },
                            child: Text("Next"))
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
}
