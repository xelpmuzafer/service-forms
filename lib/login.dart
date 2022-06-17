// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:surveynow/services/http_service.dart';
import 'package:surveynow/services/my_shared_preferrences.dart';

import 'package:surveynow/widgets/custom_button.dart';
import 'package:surveynow/widgets/custom_input.dart';
import 'dart:ui';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var cin = "";
  late final String email;

  var _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;

    MySharedPreferences.instance.getStringValue("cin").then((value) {
      if (value != "") {
        setState(() {
          cin = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // IO.Socket socket = IO.io('http://localhost:5000', <String, dynamic>{
    //   'transports': ['websocket'],
    //   'extraHeaders': {'foo': 'bar'} // optional
    // });

    // socket.onConnect((_) {
    //   socket.emit('msg', 'test');
    // });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: Color.fromARGB(5, 151, 181, 189),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 150, right: 20, left: 20),
                    child: SizedBox(
                        width: 400,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 18.0, right: 18.0),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Calistoga',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10.0, sigmaY: 10.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(25),
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromARGB(59, 14, 18, 77)
                                                      .withOpacity(0.3)),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 15, bottom: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 8.0),
                                                      child: Text(
                                                        "Enter email",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    CustomInput(
                                                      validator: (value) {
                                                        if (value == "") {
                                                          return "Please enter email address";
                                                        }
                                                      },
                                                      controller: _idController,
                                                      suffix: null,
                                                      showText: true,
                                                      hint:
                                                          'Enter email address',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 8.0),
                                                    child: Text(
                                                      "Password",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  CustomInput(
                                                    validator: (value) {
                                                      if (value == "") {
                                                        return "Please Enter Password";
                                                      }
                                                    },
                                                    controller:
                                                        _passwordController,
                                                    suffix: IconButton(
                                                      icon: Icon(
                                                        // Based on passwordVisible state choose the icon
                                                        _passwordVisible
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off,
                                                        color: Theme.of(context)
                                                            .primaryColorDark,
                                                      ),
                                                      onPressed: () {
                                                        // Update the state i.e. toogle the state of passwordVisible variable

                                                        setState(() {
                                                          _passwordVisible =
                                                              !_passwordVisible;
                                                        });
                                                      },
                                                    ),
                                                    showText: _passwordVisible,
                                                    hint: 'Enter Password',
                                                  ),
                                                  const SizedBox(
                                                    height: 40,
                                                  ),

                                                  //custom button

                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                    child: CustomButton(
                                                        text: "Continue",
                                                        onclickFunction: () => {
                                                              HttpService.login(
                                                                  _idController
                                                                      .text,
                                                                  _passwordController
                                                                      .text,
                                                                  context)
                                                            }),
                                                  ),

                                                  const SizedBox(height: 50),
                                                  Visibility(
                                                    visible: cin != ""
                                                        ? true
                                                        : false,
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: TextButton(
                                                        onPressed: () {},
                                                        style: TextButton
                                                            .styleFrom(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          backgroundColor:
                                                              const Color
                                                                      .fromARGB(
                                                                  0,
                                                                  33,
                                                                  149,
                                                                  243),
                                                          shadowColor:
                                                              const Color(
                                                                  0xFF323247),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CustomPaint(
                                                              foregroundPainter:
                                                                  BorderPainter(),
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .fingerprint,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 70,
                                                                ),
                                                              ),
                                                            ),
                                                            const Text(
                                                              '',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                wordSpacing:
                                                                    1.2,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )))
                            ])),
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

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = sh * 0.1; // desirable value for corners side

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..quadraticBezierTo(0, 0, 0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..quadraticBezierTo(0, sh, cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..quadraticBezierTo(sw, 0, sw - cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}
