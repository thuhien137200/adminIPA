import 'package:flutter/material.dart';

import '../../../controller/color_theme_controller.dart';
import '../style/style.dart';

class AccountSecuritySettings extends StatelessWidget {
  AccountSecuritySettings({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Account Security",
          style: Style().styleTextHeader(),
        ),
        Divider(
          color: Color.fromRGBO(124, 116, 228, 1),
        ),
        Body()
      ],
    );
  }

  Widget Body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recovery mail",
          style: Style().styleTextHeader1(),
        ),
        Text(
          "       We use your recovery email to contact you in the event we detect unusual activity in your account or you accidentally lose access to your account.",
          style: Style().textStyleContent(),
        ),
        Container(
          margin: EdgeInsets.all(30),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color.fromRGBO(124, 116, 228, 0.5),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your recovery mail",
                style: Style().styleTextHeader3(),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 60),
                child: TextField(
                    controller: emailController,
                    style: TextStyle(
                        color: ColorController().getColor().colorText),
                    decoration: Style().inputDecoration(
                        'email137@domain.com',
                        'Recovery Email',
                        Icon(Icons.alternate_email_rounded,
                            color: ColorController()
                                .getColor()
                                .colorText
                                .withOpacity(0.8)))),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: Style().boxDecorationButton(),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Edit",
                    style: Style().textStyleContent(),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
