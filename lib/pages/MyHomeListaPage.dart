import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


/*Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Lista ());
}*/

/*class Lista extends StatelessWidget {

  final Function({required String idPet}) viewInfo;
  const Lista ({Key? key, required this.viewInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyHomeListaPage(),
      ),
    );
  }
}*/

class MyHomeListaPage extends StatefulWidget {

  final Function({required String idPet}) viewInfo;
  const MyHomeListaPage({Key? key, required this.viewInfo}) : super(key: key);

  @override
  _MyHomeListaPagesState createState() => _MyHomeListaPagesState();
}

class _MyHomeListaPagesState extends State<MyHomeListaPage> {

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('adoption').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery
                  .of(context)
                  .size
                  .height * 0.04,
              horizontal: MediaQuery
                  .of(context)
                  .size
                  .width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Inserte caracteristica de la mascota',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.

                },
                decoration: const InputDecoration(
                  hintText: 'Inserte raza.',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                ),
              ),

              StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    FixedExtentScrollController fixedExtentScrollController =
                    new FixedExtentScrollController();

                    return ListView(

                      shrinkWrap: true,

                      children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.all(6.0),
                                child: Image.network(
                                    data["imagen"]),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  color: Theme
                                      .of(context)
                                      .buttonColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    widget.viewInfo(idPet: data['info']);
                                  },
                                  child: Text(data['nombre']),
                                ),
                                
                              ),
                            ),
                          ],


                        );
                      }

                      ).toList(),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}