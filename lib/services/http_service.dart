import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveynow/formScreen.dart';
import 'package:surveynow/models/chatMessage.dart';
import 'package:surveynow/models/questionModel.dart';
import 'package:surveynow/services/my_shared_preferrences.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:surveynow/stepper_form.dart';

class HttpService {
  Future getForm(String id) async {
    var token =
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjMzNzYwMzE0LThiNjQtNGZjMC1iMWIxLTA3ZjliMzIxYzMwYSIsInV1aWQiOiIzYjcyOWMyYy0yNDgyLTRkZjgtOWNkNC0xNDgxMWJiMDA3YTQiLCJleHAiOjE2NTkwODczNDcsInR5cGUiOiJhY2Nlc3MiLCJpYXQiOjE2NTc3OTEzNDd9.uzmJAeAZolz5KI0h0AS9hh4BKxhSFwHRs8HuJXR-_ic";

    final url = Uri.parse("http://49.50.74.106:3001/forms/get-forms/${id}");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token.toString()
    };

    var response = await get(url, headers: headers);
    int statusCode = response.statusCode;

    if (response.statusCode == 200) {
      String responseBody = response.body;

      var _jsondata = jsonDecode(responseBody);

      final List parsedList = _jsondata['data'];
      var t = json.decode(_jsondata["data"][0]["document"]);
      print(t['data'][0]);
      var questions_list = t['data'];

      List<dynamic> list =
          questions_list.map((val) => DynamicFormField.fromJson(val)).toList();
      return list;
    } else {
      var data = {"data": [], "status": "Something went wrong $statusCode"};
      return data;
    }
  }

  static submitSurvey(context, dynamic payload, filepaths) async {
    const String baseUrl =
        "https://giant-shrimps-count-157-119-109-107.loca.lt/v1/api/surveydata/upload";

    MySharedPreferences.instance.getStringValue("email").then((id) async {
      MultipartRequest request = MultipartRequest('POST', Uri.parse(baseUrl));
      filepaths.forEach((k, v) async {
        if (v != "") {
          request.files.add(
            await MultipartFile.fromPath(
              'audio',
              v,
              contentType: MediaType('application', 'audio/m4a'),
            ),
          );
        }
      });

      print(request.files);
      _determinePosition().then((value) {
        payload["location_coordinates"] =
            [value.latitude, value.longitude].toString();

        request.fields.addAll(payload);

        MySharedPreferences.instance
            .getStringValue("token")
            .then((token) async {
          request.headers.addAll({'Authorization': token});
          print(token);

          StreamedResponse r = await request.send();

          print(r);

          print(r.statusCode);

          if (r.statusCode == 200) {
            await EasyLoading.showSuccess("Submitted successfully");

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FormStepper()));
          } else {
            await EasyLoading.showError("Something went wrong!");
          }
        });
      });
    });
  }

  Future<List<dynamic>> getReply(int id) async {
    final url = Uri.parse("http://192.168.2.201:3000/chat/${id}");

    final headers = {
      'Content-Type': 'application/json',
      //    'Authorization': token.toString()
    };

    var response = await get(url, headers: headers);
    int statusCode = response.statusCode;

    print(response.statusCode);

    if (response.statusCode == 200) {
      String responseBody = response.body;

      List<dynamic> _jsondata = jsonDecode(responseBody);

      return _jsondata;
    } else {
      return [];
    }
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
