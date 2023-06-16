import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_db_practice/data/note_db_handler.dart';
import 'package:local_db_practice/models/note.dart';

import '../../models/topic.dart';
import '../widgets/top_bar_with_back.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {

  String noteHeading = "";
  String noteDescription = "";
  Topic? selectedTopic;

  bool isBtnEnable = true;

  List<Topic> topicList = [];


  @override
  void initState() {
    super.initState();
    NoteDBHandler.databaseHandler.getTopicList().then((value) =>
        setState(() {
          topicList = value;

          selectedTopic = value.firstWhere((element) => !element.isRemoveAble);
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopBarWithBack(title: "Add Note"),

                  Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      child: TextField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Note Heading',
                          ),
                          onChanged: (text){
                            noteHeading = text;
                          },
                        ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: TextField(
                      maxLines: 8,
                      minLines:1,
                      textAlign: TextAlign.justify,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Note Description',
                      ),
                      onChanged: (text){
                        setState(() {
                          noteDescription = text;
                        });
                      },
                    ),
                  ),

                  Padding(
                    padding:const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child : SizedBox(
                      width: double.infinity,
                      height: 75,
                      child: DropdownButton<Topic>(
                          value: selectedTopic,
                          iconSize: 0,
                          underline: const Divider(
                            color : Colors.black45
                          ),
                          items: topicList.map<DropdownMenuItem<Topic>>((Topic topic) {
                            return DropdownMenuItem<Topic>(
                              value: topic,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Color(topic.color),
                                        border: Border.all(
                                            color: Colors.black12
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(8))
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    topic.title,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black87
                                    ),
                                  ),
                                ],
                              )
                            );
                          }).toList(),
                          // Step 5.
                          onChanged: (Topic? newSelected) {
                            setState(() {
                              selectedTopic = newSelected;
                            });
                          },
                        ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      child :  InkWell(
                          onTap: !isBtnEnable ? null : (){
                            NoteDBHandler.databaseHandler.insertModel(
                                Note(heading: noteHeading, description: noteDescription)
                            ).then((value) =>
                                Fluttertoast.showToast(
                                    msg: "Note created successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    fontSize: 16.0
                                )
                            ).then((value) =>
                                Navigator.pop(context, true)
                            ).onError((error, stackTrace) =>
                                Fluttertoast.showToast(
                                    msg: "Some Error occurred",
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
                                  "Save Note",
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
