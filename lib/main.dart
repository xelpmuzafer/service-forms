import 'package:flutter/material.dart';
import 'package:surveynow/formScreen.dart';
import 'package:surveynow/login.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:surveynow/services/my_shared_preferrences.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MySharedPreferences.instance.getStringValue("logged_in").then((value) {
      if (value == "true") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FormScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
