// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:group_radio_button/group_radio_button.dart';
// import 'package:flutter_dropdown/flutter_dropdown.dart';
// import 'package:just_audio/just_audio.dart' as ap;
// import 'package:audioplayers/audioplayers.dart' as Aps;
// import 'package:surveynow/appStyles.dart';
// import 'package:surveynow/main.dart';
// import 'package:surveynow/services/http_service.dart';
// import 'package:surveynow/services/my_shared_preferrences.dart';
// import 'package:surveynow/widgets/custom_button.dart';
// import 'package:surveynow/widgets/custom_input.dart';
// import 'package:status_change/status_change.dart';
// import 'widgets/audioPlayer.dart';
// import 'widgets/audioRecorder.dart';

// void logout(context) {
//   MySharedPreferences.instance.setStringValue("logged_in", "");

//   MySharedPreferences.instance.setStringValue("token", "");

//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => MyHomePage()));
// }

// class FormScreen extends StatefulWidget {
//   final id;
//   const FormScreen({Key? key, this.id}) : super(key: key);

//   @override
//   _FormScreenState createState() => _FormScreenState();
// }

// class _FormScreenState extends State<FormScreen> {
//   ap.AudioSource? audioSource;

//   List<Object> child_options = [];

//   var questions = [];

//   var question_names = {};

//   var alias = {};

//   bool is_loaded = false;

//   TextEditingController nameController = TextEditingController();

//   var email;

//   var loading = false;

//   var userResponse = {};
//   Map<String, dynamic> payloadData = {};

//   preparePayload() {
//     userResponse.forEach((k, v) {
//       if (v != "") {
//         for (var item in questions) {
//           if (item['name'] == k) {
//             payloadData[item['name']] = v;
//           }
//         }
//       }
//     });

//     print("------------------Prepared payloadData-------");
//     print(payloadData);
//     print(userResponse);
//   }

//   saveReponse(dynamic ques, dynamic ans) {
//     userResponse[ques['name']] = ans;
//     preparePayload();
//   }

//   getWidget(ques) {
//     switch (ques['type']) {
//       case "heading":
//         return Center(
//             child: Text(
//           ques['name'],
//           style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(230, 26, 24, 24), fontSize: 18),
//         ));
//       case "subheading":
//         return Container(
//             child: Text(
//           ques['name'],
//           style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
//         ));

//       case "p":
//         return Container(
//             child: Text(
//           ques['name'],
//           style: TextStyle(fontWeight: FontWeight.w400),
//         ));
//       case "text":
//         return Container(
//             child: TextField(
//           onChanged: (value) {
//             saveReponse(ques, value);
//           },
//           decoration:  InputDecoration(
//             border: OutlineInputBorder(),
//             labelText: '${ques['name']}',
//             hintText: 'Enter ${ques['name']}',
//           ),
//           autofocus: false,
//         ));

//       case "number":
//         return Container(
//           child: TextField(
//             onChanged: (value) {
//               saveReponse(ques, value);
//             },
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'Enter ${ques['question']}',
//             ),
//             autofocus: false,
//             keyboardType: TextInputType.number,
//           ),
//         );

//       case "dropdown":
//         return ques['options'] == null? null : Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(ques['name']),
//             DropDown(
//                 isExpanded: true,
//                 items: ques['options'],
//                 hint: Text(ques['options'].length > 0 ? ques['options'][0].toString() : ""),
//                 icon: Icon(
//                   Icons.expand_more,
//                   color: Colors.blue,
//                 ),
//                 onChanged: (newValue) {
//                   setState(() {
//                     userResponse[ques['name']] = newValue!;
//                     saveReponse(ques, newValue);
//                   });
//                 }),
//           ],
//         );

//       case "sub-dropdown-options1":
//         return RadioGroup<String>.builder(
//           groupValue: userResponse[ques['id']],
//           onChanged: (value) => setState(() {
//             saveReponse(ques, value.toString());
//           }),
//           items: ques['options'],
//           itemBuilder: (item) => RadioButtonBuilder(
//             item,
//           ),
//         );

//       case "sub-dropdown-value":
//         return child_options.length == 0 ? null : Column(

//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(ques['name']),
//             DropDown(
//                 isExpanded: true,
//                 items: child_options,
//                 hint: Text(userResponse[ques['name']]),
//                 icon: Icon(
//                   Icons.expand_more,
//                   color: Colors.blue,
//                 ),
//                 onChanged: (newValue) {
//                   setState(() {
//                     userResponse[ques['name']] = newValue!;
//                     saveReponse(ques, newValue);
//                   });
//                 }),
//           ],
//         );

//       case "sub-dropdown-parent":
//         userResponse[ques['name']] = ques['options'][0];


//         // for(var x in questions){
//         //   if(x['type'] == 'subdropdown-options' && x['name'] == ques['options'][0]){
//         //         setState(() {
//         //           child_options = x['options'];
//         //         });
//         //   }
//         // }

//         dynamic p_options = ques['options'];

//         p_options.insert(0, "");



//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               ques['name'],
//               style: TextStyle(fontWeight: FontWeight.w600),
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: DropDown(
//                   isExpanded: true,
//                   items: p_options,
//                   hint: Text(ques['options'][0]),
//                   icon: Icon(
//                     Icons.expand_more,
//                     color: Colors.blue,
//                   ),
//                   onChanged: (newValue) {
//                     setState(() {
//                       userResponse[ques['name']] = newValue!;
//                       child_options.clear();
//                     });

//                     print("----------------changed-----------------------");

//                     late dynamic selected_parent_value;
//                     for (var item in questions) {
//                       if (item['type'] == "sub-dropdown-parent") {
//                         selected_parent_value = userResponse[ques['name']];
//                       }
//                     }

//                     print(
//                         "---------------------------------------------------USER SELECTED------------------");
//                     print(selected_parent_value.toString());
                    
//                     for (var item in questions) {
//                       if (item['type'] == "subdropdown-options" &&
//                           item['name'] == selected_parent_value) {
//                         print(item['type']);
//                         print(item);

//                         List<Object> temp = [];


//                         print(item['options'].runtimeType);
//                         for (var x in item['options']) {
//                           print(x);
//                           temp.add(x.toString());
//                         }
//                         setState(() {
//                           child_options = temp;
//                         });
//                       }
//                     }

//                     print("============================OPTIONS==============");

//                     print(child_options);
//                   }),
//             ),
//           ],
//         );
//     }
//   }

//   fetchData() async {
//     print("called");
//     var data = await HttpService().getForm(widget.id);

//     print(data);

//     setState(() {
//       questions = data['data'];

//       for (var item in questions) {

//         print(item);

//         if (!["heading", "subheading", "subdropdown-options"]
//             .contains(item['type']) && item['name'] != null) {
//           alias[item['alias']] = item['alias'];
//           question_names[item['alias']] = item['question'];
//           print("-----------------");
//           print(item);

//           userResponse[item['name']] = "";
//         }
//       }
//     });

//     setState(() {
//       is_loaded = true;
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     print("=======================+APP started===================");

//     fetchData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var drawerHeader = UserAccountsDrawerHeader(
//       accountEmail: Text(email.toString()),
//       currentAccountPicture: CircleAvatar(
//         backgroundColor: Colors.white,
//         child: FlutterLogo(size: 42.0),
//       ),
//       otherAccountsPictures: <Widget>[],
//       accountName: null,
//     );

//     final drawerItems = ListView(
//       children: <Widget>[
//         drawerHeader,
//         ListTile(
//           title: const Text('Logout'),
//           onTap: () {
//             logout(context);
//           },
//         ),
//       ],
//     );
//     return SafeArea(
//       child: Scaffold(
//         drawer: Drawer(
//           child: drawerItems,
//         ),
//         appBar: AppBar(
//           title: Text(
//             "Form",
//             style: TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
//           ),
//           backgroundColor: Color.fromARGB(255, 39, 110, 176),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: Container(
//           color: Color.fromARGB(255, 39, 110, 176),
//           child: Column(
//             children: [
              
//               //body
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(
//                     vertical: 20,
//                   ),
//                   decoration: BoxDecoration(
//                       // ignore: prefer_const_literals_to_create_immutables
//                       boxShadow: [
//                         BoxShadow(
//                           offset: Offset(5, 5),
//                           blurRadius: 10,
//                           color: Color.fromARGB(185, 0, 0, 0),
//                         )
//                       ],
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(50),
//                           topRight: Radius.circular(50))),
//                   child: is_loaded == false
//                       ? Center(
//                           child: CircularProgressIndicator(),
//                         )
//                       : Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: ListView.builder(
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 20, horizontal: 20),
//                                   itemCount: questions.length,
//                                   itemBuilder: (context, index) {
//                                     return Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "",
//                                           style: lableStyle,
//                                         ),
//                                         Container(
//                                             child: getWidget(questions[index]))
//                                       ],
//                                     );
//                                   }),
//                             ),
//                             //button

//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 30),
//                               child: loading == true
//                                   ? const Center(
//                                       child: CircularProgressIndicator())
//                                   : CustomButton(
//                                       onclickFunction: () {
//                                         bool err = false;

//                                         print(userResponse);

//                                         print("-----------------------");

//                                         print(payloadData);

                                      
//                                         userResponse.forEach((key, value) {
//                                           if (value == "") {
//                                             err = true;
//                                             EasyLoading.showError(
//                                                 'Please add:  "${key}"');

//                                             return alias[key];
//                                           }
//                                         });

//                                         // if (!err) {
//                                         //   setState(() {
//                                         //     loading = true;
//                                         //   });
//                                         //   var response =
//                                         //       HttpService.submitSurvey(context,
//                                         //           payloadData, filePaths);
//                                         // }
//                                       },
//                                       text: "Submit"),
//                             ),
//                           ],
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
