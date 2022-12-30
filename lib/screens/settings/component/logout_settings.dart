import 'package:admin_ipa/main.dart';
import 'package:admin_ipa/screens/login/component/login_component.dart';
import 'package:admin_ipa/screens/login/controller/login_controller.dart';
import 'package:flutter/material.dart';

import '../style/style.dart';

class LogoutSettings extends StatelessWidget {
  const LogoutSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Logout",
          style: Style().styleTextHeader(),
        ),
        SizedBox(height: 10, width: 1),
        Text("        See you next time.", style: Style().textStyleContent()),
        Text("        Bye bye.", style: Style().textStyleContent()),
        SizedBox(height: 30, width: 1),
        Align(
          child: GestureDetector(
            onTap: () {
              LoginController.idUser = null;
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            child: Container(
              decoration: Style().boxDecorationButton(),
              padding: EdgeInsets.all(10),
              child: Text(
                "Logout",
                style: Style().textStyleContent(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
