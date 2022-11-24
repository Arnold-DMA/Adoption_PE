import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class PhotoUpload extends StatefulWidget{
  @override
  _PhotoUploadState createState() => _PhotoUploadState();

}
class _PhotoUploadState extends State<PhotoUpload>{
  String nuevo='';
   File? sampleImage;
   final formkey= GlobalKey<FormState>();
   String? _myvalue;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
        centerTitle: true,

      ),
      body: Center(
        child: sampleImage==null
            ? Text("Selecciona una imagen")
            : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Add Image",
        child: Icon(Icons.add_a_photo),
      )
    );
}
Future getImage() async{
    var tempImage=
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
        setState(() {
          sampleImage=tempImage as File?;
        });
}
Widget enableUpload(){
    return Container(
      child: Form(
        key: formkey,
        child: Column(
          children: <Widget>[
            Image.file(sampleImage!,height: 300.0,width: 600.0),
            SizedBox(height: 15.0,),
            TextFormField(
              decoration: InputDecoration(
                labelText:"Description"
              ),
              validator: (value){
                return value!.isEmpty ? "Descripcion requerida" : null;
              },

            ),
          ],
        ),
        
      ),
    );
}

}