import 'package:doofi/pages/generic_widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar("Lista de alimentos"),
      drawer: const GlobalDrawer(),
      body: SafeArea(
        child: Column(),
      ),
    );
  }
}
