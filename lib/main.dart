import 'package:flutter/material.dart';
import 'package:notes/services/sharedPref.dart';
import 'screens/home.dart';
import 'data/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData theme = appThemeLight;
  @override
  void initState() {
    super.initState();
    updateThemeFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ملاحظاتي',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: MyHomePage(title: 'Home', changeTheme: setTheme),
      builder: (BuildContext context, Widget child) {
      return new Directionality(
        textDirection: TextDirection.rtl,
        child: new Builder(
          builder: (BuildContext context) {
            return new MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
              ),
              child: child,
            );
          },
        ),
      );
    },
    );
  }

  setTheme(Brightness brightness) {
    if (brightness == Brightness.dark) {
      setState(() {
        theme = appThemeDark;
      });
    } else {
      setState(() {
        theme = appThemeLight;
      });
    }
  }

  void updateThemeFromSharedPref() async {
    String themeText = await getThemeFromSharedPref();
    if (themeText == 'dark') {
      setTheme(Brightness.dark);
    } else {
      setTheme(Brightness.light);
    }
  }
}
