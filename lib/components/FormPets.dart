import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FormPets extends StatefulWidget {

  final VoidCallback addPet;

  const FormPets({ Key? key, required this.addPet }) : super(key: key);

  @override
  _FormPetsState createState() => _FormPetsState();
}

class _FormPetsState extends State<FormPets> {
  final _formPetsKey = GlobalKey<FormState>();
  List<File> _images = [];
  List<String> _namesImages = [];
  List<String> _urlImages = [];
  int _currentPage = 0;
  FirebaseFirestore db = FirebaseFirestore.instance;

  final TextEditingController _cachorroVController = TextEditingController();
  Timestamp _cachorroTimestamp = Timestamp.fromDate(DateTime(2000));
  final TextEditingController _rabiaController = TextEditingController();
  Timestamp _rabiaTimestamp = Timestamp.fromDate(DateTime(2000));
  final TextEditingController _rabiaPolivalenteController = TextEditingController();
  Timestamp _rabiaPolivalenteTimestamp = Timestamp.fromDate(DateTime(2000));
  final TextEditingController _caninaController = TextEditingController();
  Timestamp _caninaTimestamp = Timestamp.fromDate(DateTime(2000));
  final TextEditingController _edadMesesController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _razaController = TextEditingController();
  final TextEditingController _edadAnosController = TextEditingController();

  FirebaseStorage storage = FirebaseStorage.instance;


  Future<XFile?> _pickImageCam() async {
    return await ImagePicker().pickImage(source: ImageSource.camera);
  }

  Future<XFile?> _pickImageGal() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  Future uploadFile({required String name, required String path}) async {
    final ruta = 'images/$name';
    final file = File(path);
    final ref = FirebaseStorage.instance.ref().child(ruta);
    ref.putFile(file);
  }

  Future<String> getUrlFile({required String name}) async {
    final ruta = 'images/$name';
    final ref = FirebaseStorage.instance.ref().child(ruta);
    return ref.getDownloadURL();
  }

  Future getAllUrl() async {
    List<String> _urls = [];
    _namesImages.forEach((element) async {
      _urlImages.add(await getUrlFile(name: element));
    });
  }

  @override
  Widget build(BuildContext context) {

    
    return Form(
      key: _formPetsKey,
      child: ListView(
        children: [
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
                      child: Image.file(_images[index], fit: BoxFit.cover,),
                    )
                  )
                ),
            ),
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final image = await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image != null) {
                    final file = File.fromUri(Uri.parse(image.path));
                    setState(() {
                      _images.add(file);
                      _namesImages.add("${DateTime.now().millisecondsSinceEpoch}.jpg");
                      print(_namesImages);
                    });
                    
                    await uploadFile(name: _namesImages.last, path: image.path);
                  }
                  
                },
                child: Text('Foto desde cámara'),
              ),
              Container(width: 12,),
              ElevatedButton(
                onPressed: () async {
                  //final result = await FilePicker
                  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    final file = File.fromUri(Uri.parse(image.path));
                    setState(() {
                      _images.add(file);
                      _namesImages.add("${DateTime.now().millisecondsSinceEpoch}.jpg");
                      print(_namesImages);
                    });
                    
                    await uploadFile(name: _namesImages.last, path: image.path);
                    //final urlImage = getUrlFile(name: _namesImages.last);
                    //_urlImages.add(urlImage);
                  }
                },
                child: Text('Foto desde galería'),
              ),
            ],
          ),
          Container(height: 15),
          Column(
            children: [
              Container(width:MediaQuery.of(context).size.width - 20, child: TextFormField(
                validator: validatorText,
                controller: _nombreController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.pets),
                  hintText: 'Ingrese el nombre de su mascota.',
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.greenAccent
                    )
                  )
                ),
              ),),
              Container(height: 15),
              Container(width:MediaQuery.of(context).size.width - 20, child: TextFormField(
                validator: validatorText,
                controller: _razaController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.pets),
                  hintText: 'Ingrese la raza de su mascota.',
                  labelText: 'Raza',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.greenAccent
                    )
                  )
                ),
              ),),
              Container(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width:MediaQuery.of(context).size.width/2 - 16, child: TextFormField(
                    validator: validatorText,
                    controller: _edadAnosController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.punch_clock),
                      hintText: 'Años',
                      labelText: 'Edad (años)',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: Colors.greenAccent
                        )
                      )
                    ),
                  ),),
                  Container(width: 15),
                  Container(width:MediaQuery.of(context).size.width/2 - 16, child: TextFormField(
                    validator: validatorText,
                    controller: _edadMesesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.punch_clock),
                      hintText: 'Meses',
                      labelText: 'Edad (meses)',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: Colors.greenAccent
                        )
                      )
                    ),
                  ),),
                ],
              ),
              Container(height: 15),
              Container(width:MediaQuery.of(context).size.width - 20, child: TextFormField(
                validator: validatorText,
                controller: _cachorroVController,
                readOnly: true,
                focusNode: null,
                onTap: () async {
                  DateTime? _picked = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(2000), 
                    lastDate: DateTime.now()
                  );

                  if (_picked != null) {
                    _cachorroVController.text = DateFormat.yMd().format(_picked);
                    _cachorroTimestamp = Timestamp.fromDate(_picked);
                  }
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.date_range),
                  hintText: 'Vacuna especial cachorro',
                  labelText: 'Vacuna especial cachorro',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.greenAccent
                    )
                  )
                ),
              ),),
              Container(height: 15),
              Container(width:MediaQuery.of(context).size.width - 20, child: TextFormField(
                validator: validatorText,
                controller: _rabiaController,
                readOnly: true,
                focusNode: null,
                onTap: () async {
                  DateTime? _picked = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(2000), 
                    lastDate: DateTime.now()
                  );

                  if (_picked != null) {
                    _rabiaController.text = DateFormat.yMd().format(_picked);
                    _rabiaTimestamp = Timestamp.fromDate(_picked);
                  }
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.date_range),
                  hintText: 'Vacuna antirrábica',
                  labelText: 'Vacuna antirrábica',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.greenAccent
                    )
                  )
                ),
              ),),
              Container(height: 15),
              Container(width:MediaQuery.of(context).size.width - 20, child: TextFormField(
                validator: validatorText,
                controller: _rabiaPolivalenteController,
                readOnly: true,
                focusNode: null,
                onTap: () async {
                  DateTime? _picked = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(2000), 
                    lastDate: DateTime.now()
                  );

                  if (_picked != null) {
                    _rabiaPolivalenteController.text = DateFormat.yMd().format(_picked);
                    _rabiaPolivalenteTimestamp = Timestamp.fromDate(_picked);
                  }
                  await getAllUrl(); //OJO
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.date_range),
                  hintText: 'Vacuna antirrábica polivalente',
                  labelText: 'Vacuna antirrábica polivalente',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.greenAccent
                    )
                  )
                ),
              ),),
              Container(height: 15),
              Container(width:MediaQuery.of(context).size.width - 20, child: TextFormField(
                validator: validatorText,
                controller: _caninaController,
                readOnly: true,
                focusNode: null,
                onTap: () async {
                  DateTime? _picked = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(2000), 
                    lastDate: DateTime.now()
                  );

                  if (_picked != null) {
                    _caninaController.text = DateFormat.yMd().format(_picked);
                    _caninaTimestamp = Timestamp.fromDate(_picked);
                  }
                  
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.date_range),
                  hintText: 'Vacuna canina polivalente',
                  labelText: 'Vacuna canina polivalente',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.greenAccent
                    )
                  )
                ),
              ),),
            ],
          ),
          Container(height: 15),
          ElevatedButton(
            onPressed: () async {
              if (_formPetsKey.currentState!.validate()) {

                

                Map<String, String> misUrls = Map.fromIterable(_urlImages, key:(e) => '${_urlImages.indexOf(e)}', value: (e) => e);
                print(_urlImages);
                print(misUrls);
                //{ for (var e in _urlImages) '${_urlImages.indexOf(e)}' : e };

                DocumentReference _newPet = await db.collection('pet').add(<String, dynamic>{
                  'nombre': _nombreController.text,
                  'raza': _razaController.text,
                  'edad': <String, dynamic> {
                    'años': int.parse(_edadAnosController.text),
                    'meses': int.parse(_edadMesesController.text)
                  },
                  'vacunas': <String, dynamic>{
                    'antirrabica': _rabiaTimestamp,
                    'especial cachorro': _cachorroTimestamp,
                    'polivalente antirrabica': _rabiaPolivalenteTimestamp,
                    'polivalente canina': _caninaTimestamp
                  },
                  'propietario': <String, dynamic> {
                    'uid': '${FirebaseAuth.instance.currentUser?.uid}'
                  },
                  'imagenes': misUrls,
                  'estado': 'propio'
                }).catchError((error){
                  print(error);
                });

                await db.collection('myPet').doc().set(<String, dynamic> {
                  'imagen': _urlImages.first,
                  'info': _newPet.id,
                  'nombre': _nombreController.text,
                  'propietario': '${FirebaseAuth.instance.currentUser?.uid}'
                }).onError((e, _) => print('Error al registrar a la mascota'));
                print(_urlImages);
                print(misUrls);
                widget.addPet();
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)){
                    return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                  }
                  return Colors.greenAccent;
                }
              )
            ),
            child: const Text('REGISTRAR MASCOTA'),
          ),
          Container(height: 15),
        ]
      )
    );
    

    /*return Scaffold(
      body: Center(
        child: FutureBuilder<XFile?>(
          future: _pickImageCam(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.data != null){
              return Image.file(File(snapshot.data!.path));
            }
            else {
              return Text('Pick an image');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _pickImageCam, child: Icon(Icons.add),),
    );*/
  }

  String? validatorText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }
}