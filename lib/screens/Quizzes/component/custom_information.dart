import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:flutter/material.dart';

class CustomTable extends StatefulWidget {
  const CustomTable({Key? key}) : super(key: key);

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Job",
              style: TextStyle(
                  color: ColorController().getColor().colorText,
                  fontFamily: "Manrope-ExtraBold",
                  decoration: TextDecoration.none,
                  fontSize: 24,
                  fontWeight: FontWeight.w100),
            ),
            Icon(
              Icons.add,
              color: ColorController().getColor().colorText,
              size: 32,
            )
          ],
        ),
        DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'Name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Age',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Role',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: const <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Sarah')),
                DataCell(Text('19')),
                DataCell(Text('Student')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Janine')),
                DataCell(Text('43')),
                DataCell(Text('Professor')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('William')),
                DataCell(Text('27')),
                DataCell(Text('Associate Professor')),
              ],
            ),
          ],
        )
      ],
    );
  }
}
