import 'package:flutter/material.dart';

class DrawerCard extends StatefulWidget {
  const DrawerCard({super.key});

  @override
  State<DrawerCard> createState() => _DrawerCardState();
}

class _DrawerCardState extends State<DrawerCard> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.teal,
      child: ListView(children: <Widget>[Column(children: [])]),
    );
  }
}
