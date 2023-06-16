import 'package:flutter/material.dart';

class TopBarWithBack extends StatelessWidget {
  const TopBarWithBack({super.key,required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(15,20,15,10),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(
                Icons.arrow_back
            ),
          ),

          const SizedBox(width: 10),

          Text(
            title,
            style: const TextStyle(
                fontSize: 22,
                color: Color(0xFF0169B2),
                fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
    );
  }
}
