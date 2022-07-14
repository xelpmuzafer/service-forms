import 'package:flutter/material.dart';
import 'package:surveynow/config/appColors.dart';
import 'package:surveynow/models/chatMessage.dart';
import 'package:surveynow/widgets/chatBubble.dart';
import 'package:surveynow/widgets/customButton.dart';

class ChatBot extends StatefulWidget {
  ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  Color chatBotBgcolor = const Color(0x00000029);

final ScrollController _controller = ScrollController();

  TextEditingController textControlled = TextEditingController();

  List<Widget> messages = [];




  sendMessage(StateSetter updateState) {
     
     if(textControlled.text.toString() != ""){
updateState(() {
      messages.add(SentMessage(ChatMessage(
          id: messages.length + 1, parentId: 0, message: textControlled.text)));
          textControlled.clear();


          messages.add(ReceivedMessage(ChatMessage(
          id: messages.length + 1, parentId: 0, message: "Hello")));
          textControlled.clear();
    });
    _controller.jumpTo(_controller.position.maxScrollExtent);


     }
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Container(
            color: AppColors.kPrimaryColor,
          ),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return StatefulBuilder(builder: (context, state) {
                    return FractionallySizedBox(
                      heightFactor: 0.97,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(132, 158, 158, 158),
                              borderRadius: BorderRadius.circular(40)),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: SingleChildScrollView(
                                  controller: _controller,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                        children: List.generate(
                                                messages.length,
                                                (index) =>
                                                    messages[index])
                                            .toList()),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 6,
                                            child: SizedBox(
                                              height: 40,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: TextFormField(
                                                  controller: textControlled,
                                                  decoration:
                                                      new InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.blue,
                                                          width: 1.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1.0),
                                                    ),
                                                    hintText: 'Enter Message',
                                                  ),
                                                ),
                                              ),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: SizedBox(
                                              height: 40,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 0),
                                                ),
                                                onPressed: sendMessage(state),
                                                child: Text("Send",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: AppColors
                                                            .kPrimaryColor,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                });
          }),
    ));
  }

  Container ReceivedMessage(ChatMessage messageObject) {
    return Container(
                margin: EdgeInsets.only(bottom: 25),

      child: Align(
        alignment: Alignment.topLeft,
        child: CustomPaint(
          painter: ChatBubble(color: Colors.white, alignment: Alignment.topLeft),
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Stack(
              children: <Widget>[
                Text(messageObject.message!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container SentMessage(ChatMessage messageObject) {
    return Container(
margin: EdgeInsets.only(bottom: 25),
      child: Align(
        alignment: Alignment
            .topRight, //Change this to Alignment.topRight or Alignment.topLeft
        child: CustomPaint(
          painter: ChatBubble(
              color: AppColors.kPrimaryColor, alignment: Alignment.topRight),
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Stack(
              children: <Widget>[
                Text(
                  messageObject.message!,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
