import 'package:adoption_pe/components/MyAppBar.dart';
import 'package:adoption_pe/components/SessionNavigator.dart';
import 'package:flutter/material.dart';

import '../components/MyBottomNavigationBar.dart';

class Session extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: MyAppBar(),
      bottomNavigationBar: SessionNavigator(),
    );
  }

}