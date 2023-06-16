import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_db_practice/models/topic.dart';

import '../../data/note_db_handler.dart';
import '../widgets/top_bar_with_back.dart';

class AddTopicScreen extends StatefulWidget {
  const AddTopicScreen({super.key});

  @override
  State<AddTopicScreen> createState() => _AddTopicScreenState();
}

class _AddTopicScreenState extends State<AddTopicScreen> {

  String topicTitle = "";
  String topicDescription = "";

  bool isBtnEnable = true;

  List<Color> colors = [
    const Color(0xFFC8E6C9),
    const Color(0xFFF8BBD0),
    const Color(0xFFE1BEE7),
    const Color(0xFFD1C4E9),
    const Color(0xFFC5CAE9),
    const Color(0xFFBBDEFB),
    const Color(0xFFB3E5FC),
    const Color(0xFFB2EBF2),
    const Color(0xFFB2DFDB),
    const Color(0xFFDCEDC8),
    const Color(0xFFF0F4C3),
    const Color(0xFFFFFF00),
    const Color(0xFFFFF59D),
    const Color(0xFFFFE082),
    const Color(0xFFFFCC80),
    const Color(0xFFBCAAA4),
    const Color(0xFFEEEEEE),
    const Color(0xFFCFD8DC),
    const Color(0xFFFF5252),
    const Color(0xFFFF4081),
    const Color(0xFFF50057),
    const Color(0xFFD500F9),
    const Color(0xFF651FFF),
    const Color(0xFF2979FF),
    const Color(0xFF00B0FF),
    const Color(0xFF00E5FF),
    const Color(0xFF1DE9B6),
    const Color(0xFF00E676),
    const Color(0xFF76FF03),
    const Color(0xFFC6FF00),
    const Color(0xFFFFEA00),
    const Color(0xFFFFC400),
    const Color(0xFFFF9100),
    const Color(0xFFFF3D00),
    const Color(0xFF795548),
    const Color(0xFF9E9E9E),
    const Color(0xFF607D8B),
    const Color(0x1A000000),
  ];

  // create some values
  late Color pickerColor = colors.first;
  late Color currentColor = colors.first;

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   isBtnEnable = noteHeading.isNotEmpty && noteDescription.isNotEmpty;
    // });
  }

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopBarWithBack(title: "Add Topic"),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Topic Name',
                      ),
                      onChanged: (text){
                        topicTitle = text;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: TextField(
                      maxLines: 8,
                      minLines:1,
                      textAlign: TextAlign.justify,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Topic Description',
                      ),
                      onChanged: (text){
                        setState(() {
                          topicDescription = text;
                        });
                      },
                    ),
                  ),


                  Padding(
                      padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap:(){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Pick a color!'),
                                      content: SingleChildScrollView(
                                        child: BlockPicker(
                                            pickerColor: currentColor,
                                            onColorChanged: changeColor,
                                            availableColors: colors
                                        ),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text('Got it'),
                                          onPressed: () {
                                            setState(() => currentColor = pickerColor);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: currentColor,
                                  border: Border.all(
                                    color: Colors.black12
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(8))
                                ),
                              ),
                            ),

                            const SizedBox(width: 10,),

                            const Text(
                              "Choose Color",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Colors.black87
                              ),
                            ),
                          ],
                        ),
                  ),

                  Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      child :  InkWell(
                        onTap: !isBtnEnable ? null : (){
                          NoteDBHandler.databaseHandler.insertTopic(
                              Topic(
                                  title: topicTitle,
                                  description: topicDescription,
                                  color: currentColor.value,
                              )
                          ).then((value) =>
                              Fluttertoast.showToast(
                                  msg: "Topic created successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0
                              )
                          ).then((value) =>
                              Navigator.pop(context, true)
                          ).onError((error, stackTrace) =>
                              Fluttertoast.showToast(
                                  msg: "Some Error occurred $error $stackTrace",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0
                              )
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color : isBtnEnable ? Theme.of(context).colorScheme.primaryContainer : Colors.white12,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow : [
                              BoxShadow(
                                  color: isBtnEnable ? Colors.black26 : Colors.transparent,
                                  blurRadius: 5.0,
                                  spreadRadius : 0.5,
                                  blurStyle: BlurStyle.normal,
                                  offset: const Offset(1,1)
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                "Save Topic",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                  )
                ]
            )
        )
    );
  }
}
