import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class InfoPet extends StatefulWidget{
  @override
  _InfoPetloadState createState() => _InfoPetloadState();

}
class _InfoPetloadState extends State<InfoPet> {
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text ("Informacion"),
          centerTitle: true,
        ),
        body:
        ListView(
        children: <Widget>[

        Container(
        padding: EdgeInsets.all(20.0),
        child: Image.network("https://www.hogarmania.com/archivos/202004/chequeo-veterinario-en-gatos-recogidos-de-la-calle-668x400x80xX-1.jpg"),
        ),
          Center(
            child: SelectionArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children:  <Widget>[

                  Padding(padding: EdgeInsets.all(16.0),
                    child: Text('Hola mi nombre es Kitty'),),

                  Padding(padding: EdgeInsets.all(16.0),
                    child: Text('INFORMACION'),),
                  Padding(padding: EdgeInsets.all(16.0),
                    child: Text('UBICACION : Av. Venice , Calle 453'),),
                  Padding(padding: EdgeInsets.all(16.0),
                    child: Text('Raza: ----'),),
                  Padding(padding: EdgeInsets.all(16.0),
                    child: Text('Edad : 2 años'),),
                  Padding(padding: EdgeInsets.all(16.0),
                    child: Text('Genero : Hembra'),),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFF0D47A1),
                                  Color(0xFF1976D2),
                                  Color(0xFF42A5F5),
                                ],
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(16.0),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {},
                          child: const Text('ADOPTAR'),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ]

        )

      );
    }
}