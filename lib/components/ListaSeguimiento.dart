import 'package:adoption_pe/components/HomeNavigator.dart';
import 'package:adoption_pe/pages/Pets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListaSeguimiento extends StatefulWidget {

  
  const ListaSeguimiento({ Key? key}) : super(key: key);

  @override
  _ListaSeguimientoState createState() => _ListaSeguimientoState();
}

class _ListaSeguimientoState extends State<ListaSeguimiento> {

  List<DocumentSnapshot> _myPets = [];


  CollectionReference _myPetsCollection = FirebaseFirestore.instance.collection('myPet');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myPetsCollection = FirebaseFirestore.instance.collection('adopted');
    Query query = _myPetsCollection.where('anterior dueño', isEqualTo: '${FirebaseAuth.instance.currentUser?.uid}');
    query.get().then((querySnapshot) {
      setState(() {
        _myPets = querySnapshot.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        primary: false,
        padding: const EdgeInsets.all(20),
        itemCount: _myPets.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10
        ),
        itemBuilder: (context,  index) {
          final pet = _myPets[index].data() as Map<String, dynamic>;
          return InkWell(
            onTap: () {
              //widget.viewInfo(idPet: pet['info']);
            },
            highlightColor: Colors.black.withOpacity(0.5),
            child: Column(
              children:[
                SizedBox(
                  width: 181,
                  height: 130,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image.network(pet['imagen']),
                    )
                  )
                  
                ),
                ElevatedButton(
                  onPressed: () {
                    //widget.viewInfo(idPet: pet['info']);
                  }, 
                  child: Text(pet['nombre'])
                )
              ]
            ),
          );
        }
      ),
    );
  }
}
