import 'package:adoption_pe/components/MyAppBar.dart';
import 'package:flutter/material.dart';

import '../components/MyBottomNavigationBar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }

}