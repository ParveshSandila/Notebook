import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_db_practice/data/note_db_handler.dart';
import 'package:local_db_practice/models/note.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {

  String noteHeading = "";
  String noteDescription = "";

  bool isBtnEnable = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   isBtnEnable = noteHeading.isNotEmpty && noteDescription.isNotEmpty;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Note Heading',
                ),
                onChanged: (text){
                  noteHeading = text;
                },
              ),

              const SizedBox(height: 10),

              TextField(
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

              const SizedBox(height: 25),

              InkWell(
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
            ],
        ),
      ),
    );
  }
}
