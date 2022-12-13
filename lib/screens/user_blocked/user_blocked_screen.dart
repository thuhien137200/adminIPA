// import 'package:admin_ipa/model/data_comment_report.dart';
// import 'package:admin_ipa/screens/report_comment/report_comment_data.dart';
// import 'package:admin_ipa/screens/user_blocked/user_blocked_data.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../config/size_config.dart';
// import '../../controller/color_theme_controller.dart';
// import '../../model/data_topic.dart';
// import '../../model/data_user_blocked.dart';
// import '../../services/database_service.dart';
// import '../../style/style.dart';

// class UserBlockedScreen extends StatefulWidget {
//   const UserBlockedScreen({Key? key}) : super(key: key);

//   @override
//   State<UserBlockedScreen> createState() => _UserBlockedScreenState();
// }

// class _UserBlockedScreenState extends State<UserBlockedScreen> {
//   GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
//   late Future<List<UserBlocked>?> _dataFuture;

//   List<UserBlocked>? _userBlockedsFromQuerySnapshot(
//       QuerySnapshot<Map<String, dynamic>> querySnapshot) {
//     List<UserBlocked>? res = querySnapshot.docs
//         .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
//       if (documentSnapshot.exists) {
//         return UserBlocked.fromDocumentSnapshot(documentSnapshot);
//       }
//       return UserBlocked.test();
//     }).toList();
//     UserBlockedData.userBlockedData= res ?? [];
//     return res;
//   }

//   TextStyle textStyleTableHeader() => TextStyle(
//       fontStyle: FontStyle.italic,
//       color: ColorController().getColor().colorText,
//       fontFamily: "Manrope-ExtraBold",
//       fontSize: 20,
//       fontWeight: FontWeight.w100);
//   TextStyle textStyleTableContent() => TextStyle(
//       color: ColorController().getColor().colorText,
//       fontFamily: "Manrope",
//       fontSize: 16,
//       fontWeight: FontWeight.w100);

//   @override
//   void initState() {
//     FirebaseFirestore _db = FirebaseFirestore.instance;
//     _dataFuture = _db
//         .collection('userwasblocked')
//         .get()
//         .then(_userBlockedsFromQuerySnapshot);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       key: _drawerKey,
//       body: SafeArea(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               flex: 10,
//               child: SafeArea(
//                   child: Container(
//                 color: ColorController().getColor().colorBody,
//                 height: MediaQuery.of(context).size.height,
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       HeaderTopic(),
//                       SizedBox(
//                         height: SizeConfig.blockSizeVertical * 2.5,
//                       ),
//                       DataTableTopic(),
//                     ],
//                   ),
//                 ),
//               )),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Row HeaderTopic() {
//     return Row(mainAxisSize: MainAxisSize.min, children: [
//       SizedBox(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               PrimaryText(
//                 text: 'User Blocked',
//                 size: 30,
//                 fontWeight: FontWeight.w800,
//                 color: ColorController().getColor().colorText,
//               ),
//               PrimaryText(
//                 text: 'Manage All UserBlockeds',
//                 size: 16,
//                 fontWeight: FontWeight.w400,
//                 color: ColorController().getColor().colorText.withOpacity(0.5),
//               )
//             ]),
//       ),
//     ]);
//   }

//   DataRow RowEmpty() {
//     return DataRow(cells: [
//       DataCell(Text("")),
//       DataCell(Text("")),
//       DataCell(Text("")),
//     ]);
//   }

//   Widget DataTableTopic() {
//     return FutureBuilder(
//       future: _dataFuture,
//       builder:
//           (BuildContext context, AsyncSnapshot<List<UserBlocked>?> snapshot) {
//         return Container(
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//               color: ColorController().getColor().colorBox,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                     color: ColorController()
//                         .getColor()
//                         .colorShadowBox
//                         .withOpacity(0.5),
//                     blurRadius: 10)
//               ]),
//           child: DataTable(
//             columns: <DataColumn>[
//               DataColumn(
//                 label: Expanded(
//                   child: Text(
//                    'ID UserBlocked',
//                     style: textStyleTableHeader(),
//                   ),
//                 ),
//               ),
//               DataColumn(
//                 label: Expanded(
//                   child: Text(
//                     'Report Type',
//                     style: textStyleTableHeader(),
//                   ),
//                 ),
//               ),
//               DataColumn(
//                 label: Expanded(
//                   child: Text(
//                     'ID Author Comment',
//                     style: textStyleTableHeader(),
//                   ),
//                 ),
//               ),
//               DataColumn(
//                 label: Expanded(
//                   child: Text(
//                     'Comment Content',
//                     style: textStyleTableHeader(),
//                   ),
//                 ),
//               ),
//               const DataColumn(
//                 label: Expanded(
//                   child: Text(
//                     '',
//                   ),
//                 ),
//               ),
//             ],
//             rows: UserBlockedData.userBlockedData == null
//                 ? [RowEmpty()]
//                 : UserBlockedData.userBlockedData
//                     .map((userBlocked) => DataRow(cells: [
//                           DataCell(Text(
//                             userBlocked.id_user!,
//                             style: textStyleTableContent(),
//                           )),
//                           DataCell(Text(
//                             userBlocked.dateBan.toString(),
//                             style: textStyleTableContent(),
//                           )),
//                           DataCell(Text(
//                             userBlocked.id_author_comment!,
//                             style: textStyleTableContent(),
//                           )),
//                           DataCell(Text(
//                             reportComment.comment_content!,
//                             style: textStyleTableContent(),
//                           )),
//                           DataCell(IconButton(
//                               // Details function
//                               onPressed: () {
//                                 showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         scrollable: true,
//                                         title: Text(
//                                           'Details Report: ${reportComment.report_type ?? 'Error'}',
//                                           style: AppFonts.headStyle,
//                                         ),
//                                         content: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Form(
//                                             child: Center(
//                                               child: Flexible(
//                                                 child: Column(
//                                                   children: [
//                                                         Text(
//                                                      '${reportComment.comment_content ?? 'Error'}',                                                     
//                                                         ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         actions: [
//                                           TextButton(
//                                             child: const Text("Cancle"),
//                                             onPressed: () =>
//                                                 Navigator.pop(context),
//                                           ),
//                                           TextButton(
//                                             child: const Text("Delete Comment"),
//                                             onPressed: ()  {
                                             
//                                               DatabaseService().deleteCommentFromQuestion( reportComment.id_comment ??'error',reportComment.id_post??'error');
//                                               DatabaseService().deleteReportComment(reportComment.id_report_comment ?? 'error');
//                                               Navigator.pop(context);
//                                             }
                                                
//                                           ),
//                                           TextButton(
//                                             child: const Text("Block Candidate"),
//                                             onPressed: () {
//                                               UserBlocked user=UserBlocked(
//                                                 null,
//                                                 reportComment.id_author_comment,
//                                                 DateTime.now(),
//                                                 false,
//                                               );
//                                                DatabaseService().addUserBlocked(user);
//                                                Navigator.pop(context);
//                                             }
                                                
//                                           ),
//                                         ],
//                                       );
//                                     });
//                               },
//                               icon: Icon(
//                                 CupertinoIcons.pen,
//                                 color: ColorController().getColor().colorText,
//                               ))),
//                         ]))
//                     .toList(),
//           ),
//         );
//       },
//     );
//   }
// }
