import 'package:adoption_pe/components/FormPets.dart';
import 'package:adoption_pe/components/ListaPets.dart';
import 'package:flutter/material.dart';


final GlobalKey<_PetsState> petsKey = GlobalKey<_PetsState>();

class Pets extends StatefulWidget {
  const Pets({ Key? petsKesy }) : super(key: petsKesy);

  @override
  _PetsState createState() => _PetsState();
}

class _PetsState extends State<Pets> {

  bool add = false;

  @override
  void initState() {
    super.initState();
    add = false;
  }

  void addPet(){
    setState(() {
      add = !add;
    });
    print('Se cambió');
  }

  @override
  Widget build(BuildContext context) {

    if (add){
      return FormPets();
    }
    else {
      return ListaPets(addPet: addPet,);
    }

    
  }
}