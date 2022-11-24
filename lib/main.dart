import 'package:adoption_pe/components/HomeNavigator.dart';
import 'package:adoption_pe/components/SessionNavigator.dart';
import 'package:adoption_pe/pages/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MainDiv(),
    );
  }

}

class MainDiv extends StatefulWidget {
  const MainDiv({super.key});

  @override
  State<MainDiv> createState() => _MainDivState();
}

class _MainDivState extends State<MainDiv> {

  int _selectedWidget = 0;
  

  static final List<Widget> _widgetOptions = <Widget>[
    HomeNavigator(),
    SessionNavigator()
  ];

  
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance
    .authStateChanges()
    .listen((User? user) {
      if (user == null) {
        setState(() {
          _selectedWidget = 1;
        });
      } else {
        setState(() {
          _selectedWidget = 0;
        });
      }
    });
    return _widgetOptions.elementAt(_selectedWidget);
  }
}