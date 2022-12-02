import 'package:flutter/material.dart';

import '../../config/responsive.dart';
import '../../style/style.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                      text: 'Dashboard',
                      size: 30,
                      fontWeight: FontWeight.w800),
                  PrimaryText(
                    text: 'Interview Preparation App',
                    size: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffa6a6a6),
                  )
                ]),
          ),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: Responsive.isDesktop(context) ? 1 : 3,
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  EdgeInsets.only(left: 40.0, right: 5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Color(0xffa6a6a6), fontSize: 14)
              ),
            ),
          ),
        ]);
  }
}
