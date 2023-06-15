import 'package:flutter/material.dart';
import 'package:local_db_practice/models/note.dart';
import 'package:local_db_practice/ui/screens/add_note.dart';
import 'package:local_db_practice/data/note_db_handler.dart';
import 'package:local_db_practice/ui/widgets/search_box.dart';
import 'package:local_db_practice/ui/widgets/topic_chip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Note> list = [];

  int selectedTopicIndex = 0;

  final topicList = [
    "All Notes",
    "Reminder",
    "Writings",
    "Medicine",
    "Other"
  ];

  @override
  void initState() {
    super.initState();
    NoteDBHandler.databaseHandler.getNoteList().then((value) =>
      setState(() {
        list = value;
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
             const Padding(
               padding: EdgeInsets.fromLTRB(15,20,15,10),
               child:   Text(
                 "NoteBook",
                 style: TextStyle(
                     fontSize: 22,
                     fontWeight: FontWeight.w600
                 ),
               ),
             ),
             SearchBox(keywordChanged: (keyword){

             }),

             Padding(
               padding: const EdgeInsets.fromLTRB(15,10,15,10),
               child: SizedBox(
                 height: 50,
                 width: double.infinity,
                 child: ListView.builder(
                     itemCount: topicList.length,
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context, index) {
                      return Padding(
                        padding: index == 0 ? const EdgeInsets.fromLTRB(0,0,5,0) : const EdgeInsets.fromLTRB(5,0,5,0),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              selectedTopicIndex = index;
                            });
                          },
                          child: TopicChip(
                              name: topicList[index],
                              selected: index == selectedTopicIndex,
                          ),
                        ),
                      );
                     }
                 )
               ),
             ),

             Expanded(
               child: ListView.builder(
                       itemCount: list.length,
                       itemBuilder: (context, index) {
                         final note = list[index];
                         return ListTile(
                           title: Text(
                             note.heading ?? "",
                             style: const TextStyle(
                                 color: Colors.black87,
                                 fontWeight: FontWeight.w600
                             ),
                           ),
                           subtitle: Text(
                             note.description ?? "",
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                             style: const TextStyle(
                                 color: Colors.black45,
                                 fontWeight: FontWeight.w400
                             ),
                           ),
                           trailing: const Icon(
                             Icons.delete_forever
                           ),
                         );
                       }
                     ),
             ),
           ],
         ),
       ),
       // floatingActionButton: FloatingActionButton(
       //    onPressed: (){
       //      Navigator.push(
       //          context,
       //          MaterialPageRoute(builder: (context) => const AddNoteScreen())
       //      );
       //    },
       //    tooltip: 'Add Note',
       //    child: const Icon(Icons.add),
       // ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButton: InkWell(
        onTap: (){
          Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => const AddNoteScreen())
          );
        },
        child: Container(
          height: 55,
          width: 150,
          decoration: BoxDecoration(
            color : Theme.of(context).colorScheme.primaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow : const [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0,
                  spreadRadius : 0.5,
                  blurStyle: BlurStyle.normal,
                  offset: Offset(1,1)
              ),
            ],
          ),
          child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Icon(Icons.add),
                 SizedBox(width: 5),
                 Text(
                    "Add Note",
                     style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                     )
                  ),
              ]
            ),
        ),
      ),
    );
  }
}


