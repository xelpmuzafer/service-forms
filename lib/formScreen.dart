// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:group_radio_button/group_radio_button.dart';

import 'package:just_audio/just_audio.dart' as ap;
import 'package:audioplayers/audioplayers.dart' as Aps;
import 'package:surveynow/appStyles.dart';
import 'package:surveynow/login.dart';
import 'package:surveynow/main.dart';
import 'package:surveynow/services/http_service.dart';
import 'package:surveynow/services/my_shared_preferrences.dart';
import 'package:surveynow/widgets/custom_button.dart';
import 'package:surveynow/widgets/custom_input.dart';

import 'widgets/audioPlayer.dart';
import 'widgets/audioRecorder.dart';

void logout(context) {
  MySharedPreferences.instance.setStringValue("logged_in", "");

  MySharedPreferences.instance.setStringValue("token", "");

  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MyHomePage()));
}

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  ap.AudioSource? audioSource;

  var filepath;

  var audioSources = {};

  var filePaths = {};

  var showPlayers = {};

  bool is_loaded = false;

  var questions = [];

  var question_names = {};

  var alias = {};

  bool showPlayer = false;

  bool showPlayer2 = false;

  TextEditingController nameController = TextEditingController();

  var email;

  var loading = false;

  var userResponse = {};
  Map<String, String> payloadData = {};

  preparePayload() {
    userResponse.forEach((k, v) {
      if (v != "") {
        for (var item in questions) {
          if (item['id'] == k) {
            payloadData[item['alias']] = v;
          }
        }
      }
    });

    print("------------------Prepared payloadData-------");
    print(payloadData);
  }

  saveReponse(dynamic ques, dynamic ans) {
    userResponse[ques['id']] = ans;
    preparePayload();
  }

  getWidget(ques) {
    switch (ques['answer_type']) {
      case "text":
        return Container(
            child: TextField(
          onChanged: (value) {
            saveReponse(ques, value);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter ${ques['question']}',
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
              hintText: 'Enter ${ques['question']}',
            ),
            autofocus: false,
            keyboardType: TextInputType.number,
          ),
        );

      case "multiple choice":
        return RadioGroup<String>.builder(
          groupValue: userResponse[ques['id']],
          onChanged: (value) => setState(() {
            saveReponse(ques, value.toString());
          }),
          items: [
            ques['option_one'].toString(),
            ques['option_two'].toString(),
            ques['option_three'].toString()
          ],
          itemBuilder: (item) => RadioButtonBuilder(
            item,
          ),
        );

      case "audio":
        return Center(
          child: showPlayers[ques["id"]]
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: AudioPlayer(
                    source: audioSources[ques["id"]],
                    onDelete: () {
                      setState(() {
                        showPlayers[ques["id"]] = false;
                        filePaths[ques["id"]] = "";
                        payloadData[ques['alias']] = "";
                      });
                    },
                  ),
                )
              : AudioRecorder(
                  onStop: (path) {
                    print("source ===============================");
                    print(path);
                    setState(() {
                      filepath = path;
                    });
                    setState(() {
                      audioSources[ques['id']] =
                          ap.AudioSource.uri(Uri.parse(path));
                      showPlayers[ques["id"]] = true;
                      filePaths[ques["id"]] = path;
                      payloadData[ques['alias']] = path;

                      print(payloadData);
                    });
                    setState(() {
                      showPlayers[ques["id"]] = true;
                    });
                  },
                ),
        );
    }
  }

  fetchData() async {
    print("called");
    var data = await HttpService().getQuestion();

    print(data['questions'][0]);

    setState(() {
      questions = data['questions'];

      for (var item in questions) {
        alias[item['id']] = item['alias'];
        question_names[item['id']] = item['question'];
        print("-----------------");
        print(item);
        if (item['answer_type'] == 'multiple choice') {
          userResponse[item['id']] = item['option_one'].toString();
        } else if (item['answer_type'] == 'audio') {
          ap.AudioSource? audioSource;
          audioSources[item['id']] = audioSource;

          filePaths[item['id']] = "";

          showPlayers[item['id']] = false;

          userResponse[item['id']] = "";
        } else {
          userResponse[item['id']] = "";
        }
      }

      print("===========AUDIO SOURCES=============");
      print(audioSources);
    });

    setState(() {
      is_loaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("=======================+APP started===================");

    fetchData();

    MySharedPreferences.instance.getStringValue("email").then((value) {
      setState(() {
        email = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var drawerHeader = UserAccountsDrawerHeader(
      accountEmail: Text(email.toString()),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: FlutterLogo(size: 42.0),
      ),
      otherAccountsPictures: <Widget>[],
      accountName: null,
    );

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: const Text('Logout'),
          onTap: () {
            logout(context);
          },
        ),
      ],
    );
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: drawerItems,
        ),
        appBar: AppBar(
          title: Text(
            "Survey",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          backgroundColor: Color.fromARGB(255, 39, 110, 176),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          color: Color.fromARGB(255, 39, 110, 176),
          child: Column(
            children: [
              //body
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(5, 5),
                          blurRadius: 10,
                          color: Color.fromARGB(185, 0, 0, 0),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: is_loaded == false
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  itemCount: questions.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${index + 1}. ${questions[index]['question']}",
                                              style: lableStyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: getWidget(
                                                    questions[index])),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            //button

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: loading == true
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : CustomButton(
                                      onclickFunction: () {
                                        bool err = false;
                                        filePaths.forEach((key, value) {
                                          if (value == "") {
                                            err = true;
                                            EasyLoading.showError(
                                                'Please add:  "${question_names[key]}"');

                                            return alias[key];
                                          }
                                        });

                                        if (!err) {
                                          setState(() {
                                            loading = true;
                                          });
                                          var response =
                                              HttpService.submitSurvey(context,
                                                  payloadData, filePaths);
                                        }
                                      },
                                      text: "Submit"),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
