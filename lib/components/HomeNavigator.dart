import 'package:adoption_pe/components/MyAppBar.dart';
import 'package:adoption_pe/pages/homePage.dart';
import 'package:adoption_pe/pages/photoUpload.dart';
import 'package:flutter/material.dart';
import 'package:adoption_pe/pages/Lista.dart';

typedef VoidCallbackParam(int index);

class HomeNavigator extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    
    return HomeNavigatorState();
  }

}

class HomeNavigatorState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeNavigatorState();

}

class _HomeNavigatorState extends State<HomeNavigatorState> {

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text('Adoptados'),
    Text('Seguimiento'),
    PhotoUpload(),
    Lista(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Principal',
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Mascotas',
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
              label: 'Google',
              backgroundColor: Colors.black
          ),
        ],
        selectedItemColor: Colors.amber[800],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      )
    );
    
  }
}