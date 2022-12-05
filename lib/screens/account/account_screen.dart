import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../controller/color_theme_controller.dart';
import '../../style/style.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  Row HeaderAccount() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                text: 'Account',
                size: 30,
                fontWeight: FontWeight.w800,
                color: ColorController().getColor().colorText,
              ),
              PrimaryText(
                text: 'Manage All Account',
                size: 16,
                fontWeight: FontWeight.w400,
                color: ColorController().getColor().colorText.withOpacity(0.5),
              )
            ]),
      ),
      Spacer(
        flex: 1,
      ),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add,
            color: ColorController().getColor().colorText,
          ))
    ]);
  }

  void removeAccount() {
    //dosomething
  }

  TextStyle textStyleTableHeader() => TextStyle(
      fontStyle: FontStyle.italic,
      color: ColorController().getColor().colorText,
      fontFamily: "Manrope-ExtraBold",
      fontSize: 20,
      fontWeight: FontWeight.w100);
  TextStyle textStyleTableContent() => TextStyle(
      color: ColorController().getColor().colorText,
      fontFamily: "Manrope",
      fontSize: 16,
      fontWeight: FontWeight.w100);

  Container DataTableAccount() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ColorController().getColor().colorBox,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: ColorController()
                    .getColor()
                    .colorShadowBox
                    .withOpacity(0.5),
                blurRadius: 10)
          ]),
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'ID',
                style: textStyleTableHeader(),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Username',
                style: textStyleTableHeader(),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Password',
                style: textStyleTableHeader(),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                '',
              ),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                '1',
                style: textStyleTableContent(),
              )),
              DataCell(Text(
                'iamndnt',
                style: textStyleTableContent(),
              )),
              DataCell(Text(
                '123456789dt',
                style: textStyleTableContent(),
              )),
              DataCell(IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: ColorController().getColor().colorText,
                  ))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                '2',
                style: textStyleTableContent(),
              )),
              DataCell(Text(
                'tronghuyishere',
                style: textStyleTableContent(),
              )),
              DataCell(Text(
                'huylovebo123',
                style: textStyleTableContent(),
              )),
              DataCell(IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: ColorController().getColor().colorText,
                  ))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                '3',
                style: textStyleTableContent(),
              )),
              DataCell(Text(
                'hoangvybet188',
                style: textStyleTableContent(),
              )),
              DataCell(Text(
                'vyvebotv',
                style: textStyleTableContent(),
              )),
              DataCell(IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: ColorController().getColor().colorText,
                  ))),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 10,
                child: SafeArea(
                    child: Container(
                  color: ColorController().getColor().colorBody,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderAccount(),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2.5,
                        ),
                        DataTableAccount()
                      ],
                    ),
                  ),
                ))),
          ],
        ),
      ),
    );
  }
}
