import 'package:flutter/material.dart';
import 'package:local_db_practice/models/note.dart';
import 'package:local_db_practice/models/topic.dart';
import 'package:local_db_practice/ui/screens/add_note.dart';
import 'package:local_db_practice/data/note_db_handler.dart';
import 'package:local_db_practice/ui/screens/settings.dart';
import 'package:local_db_practice/ui/widgets/floating_button.dart';
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

  List<Topic> topicList = [];

  @override
  void initState() {
    super.initState();
    NoteDBHandler.databaseHandler.getNoteList().then((value) =>
      setState(() {
        list = value;
      })
    );

    NoteDBHandler.databaseHandler.getTopicList().then((value) =>
        setState(() {
          topicList = value;
          selectedTopicIndex = value.indexWhere((element) => !element.isRemoveAble);
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
             Padding(
               padding: const EdgeInsets.fromLTRB(15,20,15,10),
               child:  Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   const Text(
                     "NoteBook",
                      style: TextStyle(
                         fontSize: 22,
                         color: Color(0xFF0169B2),
                         fontWeight: FontWeight.w600
                     ),
                   ),


                   InkWell(
                     onTap: (){
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder : (context) => const SettingsScreen())
                       );
                     },
                     child: const Icon(
                       Icons.settings
                     ),
                   )
                 ],
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
                              topic: topicList[index],
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
                           leading: Container(
                             height: 40,
                             width: 40,
                             decoration: BoxDecoration(
                                 color: Colors.grey,
                                 border: Border.all(
                                     color: Colors.black12
                                 ),
                                 borderRadius: const BorderRadius.all(Radius.circular(8))
                             ),
                           ),
                           title: Text(
                             note.heading,
                             style: const TextStyle(
                                 color: Colors.black87,
                                 fontWeight: FontWeight.w600
                             ),
                           ),
                           subtitle: Text(
                             note.description,
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
      floatingActionButton: FloatingButton(
        text : "Add Note",
        onClick: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNoteScreen())
          );
        },
      ),
    );
  }
}


