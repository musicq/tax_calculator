import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  final bool showAppBar;
  final Widget body;

  MainContainer({this.body, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    final appBar = showAppBar
        ? AppBar(
            title: const Text(
              '报税通',
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black87),
          )
        : null;

    return Scaffold(
      appBar: appBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(color: Colors.transparent, child: body),
      ),
    );
  }
}
