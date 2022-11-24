import 'package:adoption_pe/components/SessionNavigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{

  


  @override
  Widget build(BuildContext context) {
    

    return AppPreferences();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}

class AppPreferences extends StatefulWidget {
  const AppPreferences({super.key});

  @override
  State<AppPreferences> createState() => _AppPreferencesState();
}

class _AppPreferencesState extends State<AppPreferences> {

  String _title = 'Inicio';
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    _getPrefs();
  }

  Future<void> _getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted){
      return;
    }


      User? user = auth.currentUser;
      final docref = db.collection('users').doc(user?.uid);
      docref.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          setState(() {
            _title = '${data['name']} ${data['lastname']}';
          });
          
          print("hola ${data['name']}");
        },
        onError: (e) => print('No se pudo obtener data.')
      );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_title),
      backgroundColor: Colors.pinkAccent,
      elevation: 30,
      shadowColor: Colors.white,
      //toolbarOpacity: 0.5,
      centerTitle: true,
      leading:  Icon(Icons.arrow_back,color: Colors.white,),
      actions: [
        Container(
          width: 35,
          child: RawMaterialButton(
            onPressed: () {
              /*FirebaseAuth.instance
              .authStateChanges()
              .listen((User? user) {
                if (user == null) {
                  print('User is currently signed out!');
                } else {
                  print('User is signed in!');
                }
              });*/
            },
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          width: 35,
          child: RawMaterialButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('name');
              await prefs.remove('lastname');
              await _signOut();
              //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SessionNavigator()));
            },
            child: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ),
      ],
      toolbarHeight: 100,
    );
  }
}