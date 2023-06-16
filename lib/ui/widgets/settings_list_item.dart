import 'package:flutter/material.dart';

class SettingsListItem extends StatelessWidget {
  const SettingsListItem({super.key, required this.title, required this.onClick});

  final String title;
  
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15,15,15,0),
      child: InkWell(
        onTap: onClick,
        child: Column(
            children:[
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12
                    )
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8,10,8,10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87
                        ),
                      ),

                      const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size : 16
                      )
                    ],
                  ),
                ),
              )
            ]
        ),
      ),
    );
  }
}