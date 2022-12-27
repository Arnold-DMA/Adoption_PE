import 'package:flutter/material.dart';

class Confirmacion extends StatefulWidget {
  const Confirmacion({ Key? key }) : super(key: key);

  @override
  _ConfirmacionState createState() => _ConfirmacionState();

  static Future<dynamic> showConfirmacion(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('¿Confirma que desea adoptar esta mascota?'),
          content: Text('Al adoptarlo, podrá visualizarlo en el apartado de mascotas.'),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.pop(context, false);
              }, 
              child: Text('No'),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context, true);
              }, 
              child: Text('Sí'),
            ),
          ],
        );
      }
    );
  }
}

class _ConfirmacionState extends State<Confirmacion> {

  Future<bool?> _showConfirmacion() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('¿Está seguro de eliminar el registro seleccionado?'),
          content: Text('Esta acción es irreversible.'),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.pop(context, false);
              }, 
              child: Text('No'),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context, true);
              }, 
              child: Text('Sí'),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}