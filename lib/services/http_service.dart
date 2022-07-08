import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveynow/formScreen.dart';
import 'package:surveynow/models/questionModel.dart';
import 'package:surveynow/services/my_shared_preferrences.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:surveynow/stepper_form.dart';

class HttpService {
  Future getForm(String id) async {

//     return 
//     QuestionsModel.fromJson( {"name": "CertificateName","serviceMasterId" : "da6s4d6asd0","document": {"data" : [
  
//   {
//     "page" : 1,
//     "alias": "1",
//     "name": "Application Form(Part 1)",
//     "type": "subheading",
//     "is_mandatory": null,
//     "options": null
//   },
//   {
//     "page" : 1,
//     "alias": "2",
//     "name": "Name of Applicant",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 1,
//     "alias": "3",
//     "name": "Name of Beneficiary",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 1,
//     "alias": "4",
//     "name": "Date of Application",
//     "type": "date",
//     "is_mandatory": "0",
//     "options": null
//   },
//   {
//     "page" : 1,
//     "alias": "5",
//     "name": "Address of Applicant",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 1,
//     "alias": "6",
//     "name": "Mobile No",
//     "type": "number",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 1,
//     "alias": "7",
//     "name": "E-mail",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 1,
//     "alias": "8",
//     "name": "Aadhar Card No",
//     "type": "number",
//     "is_mandatory": "0",
//     "options": null
//   },
//   {
//     "page" : 2,
//     "alias": "9",
//     "name": "Place Of Event",
//     "type": "subheading",
//     "is_mandatory": null,
//     "options": null
//   },
//   {
//     "page" : 2,
//     "alias": "10",
//     "name": "District",
//     "type": "sub-dropdown-parent",
//     "is_mandatory": "1",
//     "options": [
//       "Bastar",
//       "Bilaspur",
//       "Dhamtari",
//       "Durg",
//       "Korba",
//       "Korea",
//       "Raigarh",
//       "Raipur",
//       "Rajnandgaon",
//       "Sarguja"
//     ]
//   },
//   {
//     "page" : 2,
//     "alias": "11",
//     "name": "Office Type",
//     "type": "dropdown",
//     "is_mandatory": "1",
//     "options": ["Corporation"]
//   },
//   {
//     "page" : 2,
//     "alias": "12",
//     "name": "If Office Type is Corporation",
//     "type": "sub-dropdown-value",
//     "is_mandatory": "0",
//     "options": null
//   },
//   {
//     "page" : 3,
//     "alias": "28",
//     "name": "Application Form(Part 2)",
//     "type": "heading",
//     "is_mandatory": null,
//     "options": null
//   },
//   {
//     "page" : 3,
//     "alias": "29",
//     "name": "Marriage Details",
//     "type": "subheading",
//     "is_mandatory": null,
//     "options": null
//   },
//   {
//     "page" : 3,
//     "alias": "30",
//     "name": "Date of Marriage",
//     "type": "date",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 3,
//     "alias": "31",
//     "name": "Place of Marriage",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 3,
//     "alias": "32",
//     "name": "Type of Marriage",
//     "type": "dropdown",
//     "is_mandatory": "1",
//     "options": [
//       "Hindu",
//       "Muslim",
//       "Christian",
//       "Aarya Samaj Gandharw",
//       "Other"
//     ]
//   },
//   {
//     "page" : 3,
//     "alias": "33",
//     "name": "Is Marriage Registered",
//     "type": "dropdown",
//     "is_mandatory": "1",
//     "options": [
//       "Yes",
//       "No"
//     ]
//   },
//   {
//     "page" : 3,
//     "alias": "34",
//     "name": "Registration No",
//     "type": "text",
//     "is_mandatory": "0",
//     "options": null
//   },
//   {
//     "page" : 3,
//     "alias": "35",
//     "name": "Other Details",
//     "type": "text",
//     "is_mandatory": "0",
//     "options": null
//   },
//   {
//     "page" : 4,
//     "alias": "36",
//     "name": "Groom Details",
//     "type": "subheading",
//     "is_mandatory": null,
//     "options": null
//   },
//   {
//     "page" : 4,
//     "alias": "37",
//     "name": "Name of Groom in Local Language",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 4,
//     "alias": "38",
//     "name": "Name of Groom in English",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 4,
//     "alias": "39",
//     "name": "Date of Birth of Groom",
//     "type": "date",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 4,
//     "alias": "40",
//     "name": "Age at the time of Marriage",
//     "type": "number",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 4,
//     "alias": "41",
//     "name": "Fathers Name in Local Language",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 4,
//     "alias": "42",
//     "name": "Fathers Name in English",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 4,
//     "alias": "43",
//     "name": "Marital Status or Groom",
//     "type": "dropdown",
//     "is_mandatory": "1",
//     "options": [
//       "Un-Married",
//       "Currently Married",
//       "Widower",
//       "Divorced",
//       "Separated"
//     ]
//   },
//   {
//     "page" : 5,
//     "alias": "44",
//     "name": "Address of the Groom",
//     "type": "subheading",
//     "is_mandatory": null,
//     "options": null
//   },
//   {
//     "page" : 5,
//     "alias": "45",
//     "name": "Present Address of Groom in Local Language",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 5,
//     "alias": "46",
//     "name": "Present Address of Groom in English",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 5,
//     "alias": "47",
//     "name": "Permanent Address of Groom in Local Language",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 5,
//     "alias": "48",
//     "name": "Permanent Address Or Groom in English",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 6,
//     "alias": "49",
//     "name": "Witness Details of Groom Side",
//     "type": "subheading",
//     "is_mandatory": null,
//     "options": null
//   },
//   {
//     "page" : 6,
//     "alias": "50",
//     "name": "Witness Name",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 6,
//     "alias": "51",
//     "name": "Witness Address",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 6,
//     "alias": "52",
//     "name": "Witness Relation to Groom",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
  
//   {
//     "page" : 7,
//     "alias": "54",
//     "name": "Bride Details",
//     "type": "subheading",
//     "is_mandatory": null,
//     "options": null
//   },
//   {
//     "page" : 7,
//     "alias": "55",
//     "name": "Name of Bride in Local Language",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 7,
//     "alias": "56",
//     "name": "Name of Bride in English",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 7,
//     "alias": "57",
//     "name": "Date of Birth of Bride",
//     "type": "date",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 7,
//     "alias": "58",
//     "name": "Age at the time of Marriage",
//     "type": "number",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 7,
//     "alias": "59",
//     "name": "Fathers Name in Local Language",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 7,
//     "alias": "60",
//     "name": "Fathers Name In English",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 7,
//     "alias": "61",
//     "name": "Marital Status of Bride",
//     "type": "dropdown",
//     "is_mandatory": "1",
//     "options": [
//       "Un-Married",
//       "Currently Married",
//       "Widower",
//       "Divorced",
//       "Separated"
//     ]
//   },
//   {
//     "page" : 8,
//     "alias": "62",
//     "name": "Address of the Bride",
//     "type": "subheading",
//     "is_mandatory": null,
//     "options": null
//   },
//   {
//     "page" : 8,
//     "alias": "63",
//     "name": "Present Address of Bride in Local Language",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 8,
//     "alias": "64",
//     "name": "Present Address of Bride in English",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 8,
//     "alias": "65",
//     "name": "Permanent Address of Bride in Local Language",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 8,
//     "alias": "66",
//     "name": "Permanent Address of Bride in English",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 9,
//     "alias": "67",
//     "name": "Witness Details of Bride Side",
//     "type": "subheading",
//     "is_mandatory": null,
//     "options": null
//   },
//   {
//     "page" : 9,
//     "alias": "68",
//     "name": "Witness Name",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 9,
//     "alias": "69",
//     "name": "Witness Address",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
//   {
//     "page" : 9,
//     "alias": "70",
//     "name": "Witness Relation to Bride",
//     "type": "text",
//     "is_mandatory": "1",
//     "options": null
//   },
  
//   {
//     "page" : 9,
//     "alias": "72",
//     "name": "Bastar",
//     "type": "subdropdown-options",
//     "is_mandatory": "1",
//     "options": [
//       "Jagdalpur Municipal Corporation"
//     ]
//   },
//   {
//     "page" : 9,
//     "alias": "73",
//     "name": "Bilaspur",
//     "type": "subdropdown-options",
//     "is_mandatory": "1",
//     "options": [
//       "Bilaspur Municipal Corporation"
//     ]
//   },
//   {
//     "page" : 9,
//     "alias": "74",
//     "name": "Dhamtari",
//     "type": "subdropdown-options",
//     "is_mandatory": "1",
//     "options": [
//       "Dhamtari Municipal Corporation"
//     ]
//   },
//   {
//     "page" : 9,
//     "alias": "75",
//     "name": "Durg",
//     "type": "subdropdown-options",
//     "is_mandatory": "1",
//     "options": [
//       "Durg Municipal Corporation",
//       "Municipal Corporation Bhilai-Charoda",
//       "Bhilai Municipal Corporation",
//       "Risali Municipal Corporation"
//     ]
//   },
//   {
//     "page" : 9,
//     "alias": "76",
//     "name": "Korba",
//     "type": "subdropdown-options",
//     "is_mandatory": "1",
//     "options": [
//       "Korba Municipal Corporation"
//     ]
//   },
  // {
  //   "page" : 9,
  //   "alias": "77",
  //   "name": "Korea",
  //   "type": "subdropdown-options",
  //   "is_mandatory": "1",
  //   "options": [
  //     "Chirimiri Municipal Corporation"
  //   ]
  // },
//   {
//     "page" : 9,
//     "alias": "78",
//     "name": "Raigarh",
//     "type": "subdropdown-options",
//     "is_mandatory": "1",
//     "options": [
//       "Raigarh Municipal Corporation"
//     ]
//   },
//   {
//     "page" : 9,
//     "alias": "79",
//     "name": "Raipur",
//     "type": "subdropdown-options",
//     "is_mandatory": "1",
//     "options": [
//       "Municipal Corporation Birgaon",
//       "Raipur Municipal Corporation",
//       ""
//     ]
//   },
//   {
//     "page" : 9,
//     "alias": "80",
//     "name": "Rajnandgaon",
//     "type": "subdropdown-options",
//     "is_mandatory": "1",
//     "options": [
//       "Rajnandgaon Municipal Corporation"
//     ]
//   },
//   {
//     "page" : 9,
//     "alias": "81",
//     "name": "Sarguja",
//     "type": "subdropdown-options",
//     "is_mandatory": "1",
//     "options": [
//       "Ambikapur Municipal Corporation"
//     ]
//   }
// ]}});
      //  var token = prefs.getString("token");

    final url = Uri.parse(
        "http://49.50.74.106:3005/forms/get-forms/${id}");

    final headers = {
      'Content-Type': 'application/json',
  //    'Authorization': token.toString()
    };

    var response = await get(url, headers: headers);
    int statusCode = response.statusCode;

    print(response.statusCode);

    

    if (response.statusCode == 200) {
      String responseBody = response.body;

      var _jsondata = jsonDecode(responseBody);

      // List<Map<String, dynamic>> output = (json.decode(_jsondata) as List).cast();
print("decoding");

      //  Map<String, dynamic>  json_data = ;
      // print(_jsondata['data'][0]);

      final List parsedList = _jsondata['data'];
var t = json.decode(_jsondata["data"][0]["document"]);
      print(t['data'][0]);
      var questions_list =  t['data'];

List<dynamic> list = questions_list.map(( val)=>
  
   DynamicFormField.fromJson(val)
   
).toList(); 

      print(list.length);
      print("--------done------------");
      return list;
      
    } else {
      var data = {"data": [], "status": "Something went wrong $statusCode"};
      return data;
    }
  }
  
  static submitSurvey(context, dynamic payload, filepaths) async {
    const String baseUrl =
        "https://giant-shrimps-count-157-119-109-107.loca.lt/v1/api/surveydata/upload";

    print("-----------***********-----------------data---------------------");
    print(baseUrl);
    print(payload);

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

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FormStepper()));
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
