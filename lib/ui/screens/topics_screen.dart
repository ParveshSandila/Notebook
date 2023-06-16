import 'package:flutter/material.dart';
import 'package:local_db_practice/ui/widgets/top_bar_with_back.dart';

import '../../data/note_db_handler.dart';
import '../../models/topic.dart';
import '../widgets/floating_button.dart';
import 'add_topic.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {

  List<Topic> topicList = [];

  @override
  void initState() {
    super.initState();
    NoteDBHandler.databaseHandler.getTopicList().then((value) =>
        setState(() {
          topicList = value;
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
                   const TopBarWithBack(title: "Topics"),

                   Expanded(
                       child:  ListView.builder(
                            itemCount: topicList.length,
                            itemBuilder: (context, index) {
                              final topic = topicList[index];
                              return ListTile(
                                leading: Container(
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
                                title: Text(
                                  topic.title,
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                subtitle: Text(
                                  topic.description,
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
                       )
                   )
                ]
            )
        ),
        floatingActionButton: FloatingButton(
          text : "Add Note",
          onClick: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTopicScreen())
            );
          },
        ),
    );
  }
}
