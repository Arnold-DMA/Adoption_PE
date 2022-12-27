import 'package:adoption_pe/components/FormPets.dart';
import 'package:adoption_pe/components/InfoPets.dart';
import 'package:adoption_pe/components/ListaPets.dart';
import 'package:adoption_pe/pages/infoPet.dart';
import 'package:flutter/material.dart';


final GlobalKey<_PetsState> petsKey = GlobalKey<_PetsState>();

class Pets extends StatefulWidget {
  const Pets({ Key? petsKesy }) : super(key: petsKesy);

  @override
  _PetsState createState() => _PetsState();
}

class _PetsState extends State<Pets> {

  bool add = false;
  bool info = false;
  String _idPet = '';

  @override
  void initState() {
    super.initState();
    add = false;
    info = false;
    _idPet = '';
  }

  void addPet(){
    setState(() {
      add = !add;
      info = false;
    });
    //print('Se cambió');
  }

  void viewInfo({required String idPet}){
    setState(() {
      _idPet = idPet;
      info = !info;
      add = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (add && !info){
      return FormPets(addPet: addPet,);
    }
    else if (info && !add) {
      return InfoPets(viewInfo: viewInfo, idPet: _idPet);
    }
    else {
      return ListaPets(addPet: addPet, viewInfo: viewInfo,);
    }

    
  }
}