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

  bool showPlayer = false;

  bool showPlayer2 = false;

  TextEditingController nameController = TextEditingController();

  var email;

  var loading = false;

  var userResponse = {};
  var payload = {};

  preparePayload() {
    userResponse.forEach((k, v) {
      if (v != "") {
        for (var item in questions) {
          if (item['id'] == k) {
            payload[item['alias']] = v;
          }
        }
      }
    });

    print("------------------Prepared payload-------");
    print(payload);
  }

  saveReponse(dynamic ques, dynamic ans) {
    userResponse[ques['id']] = ans;
    preparePayload();
  }

  getWidget(ques) {
    switch (ques['answer_type']) {
      case "text":
        return TextField(
          onChanged: (value) {
            saveReponse(ques, value);
          },
          decoration: new InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            hintText: ques['question'],
          ),
        );

      case "number":
        return TextField(
          onChanged: (value) {
            saveReponse(ques, value);
            print(userResponse);
          },
          decoration: new InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            hintText: ques['question'],
          ),
          keyboardType: TextInputType.number,
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
                        payload[ques['alias']] = "";
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
                      payload[ques['alias']] = path;

                      print(payload);
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
          title: Text("Survey"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    logout(context);
                  },
                  icon: Icon(Icons.logout)),
            )
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                elevation: 4,
                child: is_loaded == false
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: ListView.builder(
                              itemCount: questions.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        questions[index]['question'],
                                        style: lableStyle,
                                      ),
                                      Container(
                                          child: getWidget(questions[index]))
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
