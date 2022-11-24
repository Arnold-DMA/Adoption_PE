import "package:flutter/material.dart";

class MyButtons extends StatelessWidget{
  const MyButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return myElevatedButton();
  }

  myElevatedButton(){
    return const Text("Hola");
    /*ElevatedButton.icon(
      icon: Icon(Icons.check,color: Colors.red,),
      label: Text("Guardar"),
      style: ElevatedButton.styleFrom(
        //primary: Colors.white,
        //onPrimary: Colors.black,
        shadowColor:Colors.yellow ,
        elevation:20 ,

      ),
        onLongPress: (){
          print("ElevatedButton onLongPress");
        },
        onPressed: (){
          print("ElevatedButton");
        },);*/
  }

}