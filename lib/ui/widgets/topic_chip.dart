import 'package:flutter/material.dart';

class TopicChip extends StatefulWidget {
  const TopicChip({super.key,required this.selected, required this.name});
  final String name;
  final bool selected;
  @override
  State<TopicChip> createState() => _TopicChipState();
}

class _TopicChipState extends State<TopicChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
   //   color: const Color(0xFFF3C7FC),
      decoration: BoxDecoration(
        color: widget.selected ? const Color(0xFFF3C7FC) : const Color(0xDEE5E5E5),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Center(
          child: Text(widget.name),
        ),
      ),
    );
  }
}
