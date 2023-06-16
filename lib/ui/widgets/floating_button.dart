import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key, required this.text, required this.onClick});

  final String text;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onClick();
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
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.add),
              const SizedBox(width: 5),
              Text(
                  text,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  )
              ),
            ]
        ),
      ),
    );
  }
}
