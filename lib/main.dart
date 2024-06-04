import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mft_final_project/Tabs/settings/settingprovider.dart';
import 'package:mft_final_project/Theme.dart';
import 'package:mft_final_project/homescreen.dart';
import 'package:mft_final_project/login.dart';
import 'package:mft_final_project/module/books.dart';
import 'package:mft_final_project/module/borrowed_book.dart';
import 'package:mft_final_project/module/member.dart';
import 'package:mft_final_project/module/user.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(BooksAdapter());
  Hive.registerAdapter(MemberAdapter());
  Hive.registerAdapter(BorrowedBookAdapter());
  // await ScreenUtil.ensureScreenSize();
  await Hive.openBox<User>('users');
  await Hive.openBox('members');
  await Hive.openBox('books');
  await Hive.openBox('borrowedBookBox');
  runApp(ChangeNotifierProvider(
      create: (context) {
        return settingsprovider();
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    settingsprovider settingsproviderr = Provider.of<settingsprovider>(context);
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(settingsproviderr.languagecode),
        themeMode: settingsproviderr.themeMode,
        theme: apptheme.lighttheme,
        darkTheme: apptheme.darktheme,
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
        },
      ),
    );
  }
}
