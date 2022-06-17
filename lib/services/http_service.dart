import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveynow/formScreen.dart';
import 'package:surveynow/services/my_shared_preferrences.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class HttpService {
  Future<dynamic> getQuestion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    final url = Uri.parse("http://192.168.2.66:5000/v1/api/question/all");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token.toString()
    };

    var response = await get(url, headers: headers);
    int statusCode = response.statusCode;


    if (response.statusCode == 200) {
      String responseBody = response.body;

      var json = jsonDecode(responseBody);

      var data = {"questions": json, "status": "success"};
      return data;
    } else {
      var data = {"data": [], "status": "Something went wrong $statusCode"};
      return data;
    }
  }

  static login(id, password, context) async {
    if (id == "") {
      EasyLoading.showError("Please enter email");
      return null;
    } else if (password == "") {
      EasyLoading.showError("Please enter password");
      return null;
    }

    final _loginUrl = Uri.parse('http://192.168.2.66:5000/v1/api/auth/login');

    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {'email': id, 'password': password};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      _loginUrl,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;

    print("----------------------------");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(json);

      if (json["token"] != '') {
        await EasyLoading.showSuccess("Logged In successfuly");

        MySharedPreferences.instance.setStringValue("logged_in", "true");

        MySharedPreferences.instance.setStringValue("token", json["token"]);

        MySharedPreferences.instance.setStringValue("email", id);

        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormScreen()),
        );
      } else {
        EasyLoading.showError(json["status"]);
      }
    } else {
      //print("${response.statusCode.toString()}");
      await EasyLoading.showError("Something went wrong!");
    }
  }

  static submitSurvey(context, String name, String ans1, String ans2,
      audiofile1, audiofile2) async {
    if (name == "") {
      EasyLoading.showError("Please enter name");
      return null;
    } else if (audiofile1 == null) {
      EasyLoading.showError("Please add agent's audio recording");
      return null;
    } else if (audiofile2 == null) {
      EasyLoading.showError("Please add citizen's audio recording");
      return null;
    }

    const String baseUrl = "http://192.168.2.66:5000/v1/api/surveydata/upload";

    var url = baseUrl;

    MySharedPreferences.instance.getStringValue("email").then((id) async {
      MultipartRequest request = MultipartRequest('POST', Uri.parse(url));

      request.files.add(
        await MultipartFile.fromPath(
          'audio',
          audiofile1,
          contentType: MediaType('application', 'audio/m4a'),
        ),
      );
      request.files.add(
        await MultipartFile.fromPath(
          'audio',
          audiofile2,
          contentType: MediaType('application', 'jpeg'),
        ),
      );

      print(request.files);

      _determinePosition().then((value) {
        request.fields.addAll({
          "name": name,
          "question_one_answer": ans1,
          "question_two_answer": ans2,
          "location_coordinates": [value.latitude, value.longitude].toString()
        });

        MySharedPreferences.instance
            .getStringValue("token")
            .then((token) async {
          request.headers.addAll({'Authorization': token});
          print(token);

          StreamedResponse r = await request.send();

          print(r);

          if (r.statusCode == 200) {
            await EasyLoading.showSuccess("Submitted successfully");

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FormScreen()));
          } else {
            await EasyLoading.showError("Something went wrong!");
          }
        });
      });
    });
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
