import 'package:flutter/material.dart';
import 'package:local_db_practice/ui/widgets/top_bar_with_back.dart';

import '../widgets/settings_list_item.dart';
import 'topics_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopBarWithBack(title: "Settings"),

                SettingsListItem(
                    title: 'Topics',
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TopicsScreen())
                      );
                    }
                ),

                SettingsListItem(
                    title: 'Theme',
                    onClick: () {}
                ),

                SettingsListItem(
                  title: 'About App',
                  onClick: () {},
                ),
              ],
          )
      ),
    );
  }
}



