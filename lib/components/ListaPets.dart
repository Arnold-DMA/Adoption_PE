import 'package:adoption_pe/pages/Pets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListaPets extends StatefulWidget {

  final VoidCallback addPet;
  
  const ListaPets({ Key? key, required this.addPet }) : super(key: key);

  @override
  _ListaPetsState createState() => _ListaPetsState();
}

class _ListaPetsState extends State<ListaPets> {

  List<DocumentSnapshot> _myPets = [];


  CollectionReference _myPetsCollection = FirebaseFirestore.instance.collection('myPet');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myPetsCollection = FirebaseFirestore.instance.collection('myPet');
    Query query = _myPetsCollection.where('propietario', isEqualTo: '5yLhwHQpKjfoXcn08xU9fgOsTGL2');
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

                  }, 
                  child: Text(pet['nombre'])
                )
              ]
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.addPet();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
