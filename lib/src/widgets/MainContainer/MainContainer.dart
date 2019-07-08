import 'package:flutter/material.dart';

class MainContainer extends StatefulWidget {
  final bool showAppBar;
  final Widget body;

  MainContainer({this.body, this.showAppBar = true});

  @override
  State<StatefulWidget> createState() {
    return _MainContainerState();
  }
}

class _MainContainerState extends State<MainContainer> {
  @override
  Widget build(BuildContext context) {
    final appBar = widget.showAppBar
        ? AppBar(
            title: const Text(
              '报税通',
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.white,
          )
        : null;

    return Scaffold(
      appBar: appBar,
      body: widget.body,
    );
  }
}
