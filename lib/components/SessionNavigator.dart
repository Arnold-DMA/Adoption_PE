import 'package:adoption_pe/pages/Login.dart';
import 'package:flutter/material.dart';

import '../pages/SignUp.dart';

typedef VoidCallbackParam(int index);

class SessionNavigator extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    
    return SessionNavigatorState();
  }

}

class SessionNavigatorState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SessionNavigatorState();

}

class _SessionNavigatorState extends State<SessionNavigatorState> {

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    Login(),
    SignUp()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
            backgroundColor: Colors.greenAccent
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Registro',
            backgroundColor: Colors.blueAccent
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Color.fromARGB(255, 80, 71, 71),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      )
    );
    
  }

}