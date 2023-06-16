import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key, required this.keywordChanged});

  final void Function(String) keywordChanged;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Container(
          decoration: const BoxDecoration(
            color : Color(0xDEE5E5E5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search,
                  size : 22,
                  color: Colors.black87
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search anything',
                        iconColor: Colors.black87,
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                          fontWeight: FontWeight.normal,
                        ),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.normal
                    ),
                    onChanged : (keyword){
                      widget.keywordChanged(keyword);
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
