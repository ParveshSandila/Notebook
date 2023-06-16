import 'package:flutter/material.dart';

import '../../models/topic.dart';

class TopicChip extends StatefulWidget {
  const TopicChip({super.key,required this.selected, required this.topic});
  final Topic topic;
  final bool selected;
  @override
  State<TopicChip> createState() => _TopicChipState();
}

class _TopicChipState extends State<TopicChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(widget.topic.color),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: widget.selected ? Colors.black26 : Colors.transparent
        ),
        boxShadow: [
          BoxShadow(
              color: widget.selected ? Colors.black26 : Colors.transparent,
              blurRadius: 5.0,
              spreadRadius : 0.5,
              blurStyle: BlurStyle.normal,
              offset: const Offset(1,1)
          ),
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Center(
          child: Text(widget.topic.title),
        ),
      ),
    );
  }
}
