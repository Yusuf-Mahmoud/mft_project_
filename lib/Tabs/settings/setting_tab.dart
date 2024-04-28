import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mft_final_project/Tabs/settings/settingprovider.dart';
import 'package:mft_final_project/Theme.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<settingsprovider>(context);

    return Consumer<settingsprovider>(
      builder: (BuildContext context, value, Widget? child) => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              ElevatedButton(onPressed: (){
                if(settingsProvider.themeMode == ThemeMode.light){
                  settingsProvider.changetheme(ThemeMode.dark);
                }else{
                  settingsProvider.changetheme(ThemeMode.light);
                }
              }, child: child),

              ElevatedButton(
                onPressed: () {
                  if (settingsProvider.languagecode == 'ar') {
                    settingsProvider.changelanguage('en');
                  } else {
                    settingsProvider.changelanguage('ar');
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Icon(
                  Icons.language,
                  size: 40,
                ),
              ),
              // SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     if (settingsProvider.themeMode == ThemeMode.light) {
              //       settingsProvider.changetheme(ThemeMode.dark);
              //     } else {
              //       settingsProvider.changetheme(ThemeMode.light);
              //     }
              //   },
              //   style: ElevatedButton.styleFrom(
              //     foregroundColor: Colors.white,
              //     backgroundColor: Colors.blue,
              //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //   ),
              //   child: Icon(
              //     Icons.lightbulb,
              //     size: 40,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
