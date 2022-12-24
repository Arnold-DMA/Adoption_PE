import 'package:flutter/material.dart';

typedef VoidCallbackParam(int index);

class MyBottomNavigationBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    
    return MyStatefulBottomNavigator();
  }

}

class MyStatefulBottomNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyStatefulBottomNavigator();

}

class _MyStatefulBottomNavigator extends State<MyStatefulBottomNavigator> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Principal',
          backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pets),
          label: 'Adoptar',
          backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.troubleshoot),
          label: 'Seguimiento',
          backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.volunteer_activism),
          label: 'Alerta',
          backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Alerta',
            backgroundColor: Colors.black
        ),
      ],
      selectedItemColor: Colors.amber[800],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

}