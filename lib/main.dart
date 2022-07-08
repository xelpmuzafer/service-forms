import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:surveynow/formScreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:surveynow/services/my_shared_preferrences.dart';
import 'package:http/http.dart' as http;
import 'package:surveynow/stepper_form.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  dynamic data = [];

Future<dynamic> getRequest() async {
    //replace your restFull API here.
    String url = "http://49.50.74.106:3001/services/data/getAllServices";
    final response = await http.get(Uri.parse(url));
  
    var responseData = json.decode(response.body);
  
    
    setState(() {
      data = responseData['data'];
      print(data);
    });
    return responseData;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

       getRequest();
      }
    
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Service Forms")),
      body: Container(child: ListView.builder(
        itemCount:  data.length,        
        itemBuilder: ((context, index) {
        return ListTile(title:  data[index]['name '],);
      })),));
  }
}
