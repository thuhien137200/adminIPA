import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:admin_ipa/screens/Quizzes/quizzes_screen.dart';
import 'package:admin_ipa/screens/login/login_screen.dart';
import 'package:admin_ipa/services/quizzes_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'model/data_quizzes.dart';
import 'model/data_side_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Error: ${snapshot.error.toString()}");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return const LoginScreen();
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool statusColorTheme = true;
  Color colorBody = ColorController().getColor().colorBody;
  Color colorBox = ColorController().getColor().colorBox;
  Color colorShadowBox = ColorController().getColor().colorShadowBox;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      appBar(context),
      body(context),
    ]);
    // return LoginScreen();
  }

  Container body(BuildContext context) {
    Size size = Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height - 60);
    return Container(
      height: size.height,
      width: size.width,
      color: colorBody,
      child: Row(
        children: [
          Flexible(flex: 2, child: sideBar(size.height, size.width * 2 / 12)),
          Flexible(
              flex: 10,
              child: DatabaseSideBar()
                  .getScreen(Size(size.width * 10 / 12, size.height))),
        ],
      ),
    );
  }

  Container sideBar(double height, double width) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: colorBox,
          boxShadow: [BoxShadow(color: colorShadowBox, blurRadius: 5)]),
      child: ListView.builder(
        itemCount: DatabaseSideBar().getData().length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: DatabaseSideBar().getCustomSideBarBox(index, width),
            onTap: () {
              setState(() {
                DatabaseSideBar.selectionIndex = index;
              });
            },
          );
        },
      ),
    );
  }

  Container appBar(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "IPA",
            style:
                TextStyle(color: Colors.white, decoration: TextDecoration.none),
          ),
        ),
        Container(
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: FlutterSwitch(
            width: 60.0,
            height: 30.0,
            borderRadius: 30.0,
            padding: 2.0,
            value: statusColorTheme,
            activeToggleColor: Color(0xFF6E40C9),
            inactiveToggleColor: Color(0xFF2F363D),
            activeColor: Color(0xFF271052),
            inactiveColor: Colors.white,
            activeIcon: Icon(
              Icons.nightlight_round,
              color: Color(0xFFF8E3A1),
            ),
            inactiveIcon: Icon(
              Icons.wb_sunny,
              color: Color(0xFFFFDF5D),
            ),
            onToggle: (val) {
              setState(() {
                statusColorTheme = val;
                ColorController().changeColor();
                changeColor(ColorController().getColor());
              });
            },
          ),
        ),
      ]),
    );
  }

  void changeColor(ColorTheme colorTheme) {
    colorBody = colorTheme.colorBody;
    colorBox = colorTheme.colorBox;
    colorShadowBox = colorTheme.colorShadowBox;
  }
}
