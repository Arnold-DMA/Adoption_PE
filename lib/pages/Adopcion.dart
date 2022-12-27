import 'package:adoption_pe/components/InfoAdoption.dart';
import 'package:flutter/material.dart';
import 'package:adoption_pe/pages/MyHomeListaPage.dart';


class Adopcion extends StatefulWidget {
  const Adopcion({ Key? key }) : super(key: key);

  @override
  _AdopcionState createState() => _AdopcionState();
}

class _AdopcionState extends State<Adopcion> {

  bool info = false;
  String _idPet = '';

  @override
  void initState() {
    super.initState();
    info = false;
  }

  void viewInfo({required String idPet}){
    setState(() {
      _idPet = idPet;
      info = !info;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (info) {
      return InfoAdoption(viewInfo: viewInfo, idPet: _idPet);
    }
    else {
      return MyHomeListaPage(viewInfo: viewInfo);
    }
  }
}