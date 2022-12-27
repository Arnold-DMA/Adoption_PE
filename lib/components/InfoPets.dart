import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class InfoPets extends StatefulWidget {

  final Function({required String idPet}) viewInfo;
  final String idPet;
  
  const InfoPets({ Key? key, required this.viewInfo, required this.idPet }) : super(key: key);

  @override
  _InfoPetsState createState() => _InfoPetsState();
}

class _InfoPetsState extends State<InfoPets> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  int _currentPage = 0;
  List<dynamic> _images = [];

  Map<String, dynamic> _infoPet = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.idPet);
    final docref = db.collection('pet').doc(widget.idPet);
    docref.get().then(
      (DocumentSnapshot doc) {
        setState(() {
          _infoPet = doc.data() as Map<String, dynamic>;
          //_images = _infoPet['imagenes'].values.toList();
        });
      }
    );
  }

  String convertTimestampToDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }


  @override
  Widget build(BuildContext context) {

    if(_infoPet['nombre'] == null) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      );
    }
    else {
      setState(() {
        _images = _infoPet['imagenes'].values.toList();
      });
      return ListView(
        children: [
          Container(height: 8,),
          Center(child: Text(_infoPet['nombre'], style: TextStyle(fontSize: 35),)),
          Center(child: Container(
            width: 200,
            height: 150,
            color: Colors.black.withOpacity(0.1),
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children:
                List.generate(_images.length, (index) => 
                  AspectRatio(
                    aspectRatio: 1.0, 
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image.network(_images[index], fit: BoxFit.cover,),
                    )
                  )
                ),
            ),
          ),),
          Container(height: 12,),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width/3,
                padding: EdgeInsets.only(right: 8),
                alignment: Alignment.centerRight,
                child: Text(
                  'Raza:',
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text(_infoPet['raza'], style: TextStyle(fontSize: 20),)
            ],
          ),
          Container(height: 12,),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width/3,
                padding: EdgeInsets.only(right: 8),
                alignment: Alignment.centerRight,
                child: Text(
                  'Edad:',
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text('${_infoPet['edad']['años']} años y ${_infoPet['edad']['meses']} meses.', style: TextStyle(fontSize: 20))
            ],
          ),
          Container(height: 12,),
          Container(
            width: MediaQuery.of(context).size.width/3,
            alignment: Alignment.center,
            child: Text('Vacunas:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900
              ),
            ),
          ),
          Container(height: 8,),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width/3,
                padding: EdgeInsets.only(right: 8),
                alignment: Alignment.centerRight,
                child: Text(
                  'Cachorro:',
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text(convertTimestampToDate(_infoPet['vacunas']['especial cachorro']), style: TextStyle(fontSize: 18))
            ],
          ),
          Container(height: 12,),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width/3,
                padding: EdgeInsets.only(right: 8),
                alignment: Alignment.centerRight,
                child: Text(
                  'Rabia:',
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text(convertTimestampToDate(_infoPet['vacunas']['antirrabica']), style: TextStyle(fontSize: 18))
            ],
          ),
          Container(height: 12,),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width/3,
                padding: EdgeInsets.only(right: 8),
                alignment: Alignment.centerRight,
                child: Text(
                  'P. Rabia:',
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text(convertTimestampToDate(_infoPet['vacunas']['polivalente antirrabica']), style: TextStyle(fontSize: 18))
            ],
          ),
          Container(height: 12,),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width/3,
                padding: EdgeInsets.only(right: 8),
                alignment: Alignment.centerRight,
                child: Text(
                  'P. Canina:',
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text(convertTimestampToDate(_infoPet['vacunas']['polivalente canina']), style: TextStyle(fontSize: 18))
            ],
          ),
          Container(height: 10),
          Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width/4,
              left: MediaQuery.of(context).size.width/4,
            ),
            child: _infoPet['estado']=='propio'?
              ElevatedButton(
                onPressed: () async {
                  DocumentReference _newAdoption = await db.collection('adoption').add(<String, dynamic>{
                    'nombre': _infoPet['nombre'],
                    'imagen': _images[0],
                    'info': widget.idPet,
                    'propietario': _infoPet['propietario']['uid']
                  });
                  await db.collection('pet').doc(widget.idPet).update({'estado': 'adopcion'});
                  setState(() {
                    _infoPet['estado'] = 'adopcion';
                  });
                }, 
                child: Text('Poner en adopción')
              ):
              _infoPet['estado']=='adopcion'?
                ElevatedButton(
                  onPressed: () async {
                    QuerySnapshot snapshot = await db.collection('adoption').where('info', isEqualTo: widget.idPet).get();
                    snapshot.docs.forEach((doc) => doc.reference.delete());
                    await db.collection('pet').doc(widget.idPet).update({'estado': 'propio'});
                    setState(() {
                      _infoPet['estado'] = 'propio';
                    });
                  }, 
                  child: Text('Quitar de adopción')
                ):
                Container()
          ),
          Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width/4,
              left: MediaQuery.of(context).size.width/4,
            ),
            child: ElevatedButton(
              onPressed: () {
                widget.viewInfo(idPet: '0');
              }, 
              child: Text('Volver')
            ),
          ),
          
        ],
      );
    }
  }

}