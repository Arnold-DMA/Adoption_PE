import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }

}

class SignUpState extends State<SignUp> {

  final _signupKey = GlobalKey<FormState>();

  String _name = '';
  String _lastname = '';

  static Future<User?> signUpUsingEmailPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _lastnameController = TextEditingController();
    FirebaseFirestore db = FirebaseFirestore.instance;

    final elevatedButtonStyle = ButtonStyle(
      
    );

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _signupKey,
          child: Center(child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(
              right: 15,
              left: 15,
              top: 15
            ),
            children: <Widget>[
              const Text(
                "Registro de Usuario",
                style: TextStyle(
                  fontSize: 35.0,
                  color: Color.fromARGB(255, 28, 28, 28),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Container(height: 15),
              TextFormField(
                validator: validatorText,
                controller: _nameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Por favor, ingrese su nombre',
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.blueAccent
                    )
                  )
                ),
              ),
              Container(height: 15),
              TextFormField(
                validator: validatorText,
                controller: _lastnameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Por favor, ingrese su apellido',
                  labelText: 'Apellido',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.blueAccent
                    )
                  )
                ),
              ),
              Container(height: 15),
              TextFormField(
                validator: validatorText,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  hintText: 'Por favor, ingrese su email',
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.blueAccent
                    )
                  )
                ),
              ),
              Container(height: 15),
              TextFormField(
                validator: validatorText,
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  hintText: 'Por favor, ingrese su contraseña',
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.blueAccent
                    )
                  )
                ),
              ),
              Container(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      if (_signupKey.currentState!.validate()) {
                        User? user = await signUpUsingEmailPassword(
                          email: _emailController.text, 
                          password: _passwordController.text, 
                          context: context
                        );
                        print(user);
                        if (user != null) {
                          db.collection('users').doc(user.uid).set(<String, String>{
                            'name': _nameController.text,
                            'lastname': _lastnameController.text,
                            'email': _emailController.text
                          }).onError((e, _) => print('Error al registrar los datos del usuario'));
                        }
                      }
                    },
                    
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)){
                            return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                          }
                          return Colors.blueAccent;
                        }
                      ),
                    ),
                    child: const Text('REGISTRARSE'),
                  ),
                  IconButton(
                    onPressed: (){

                    }, 
                    icon: Image.asset('assets/img/google_icon_64.png')
                  )
                ],
              ),
              
              Container(height: 15),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Si ya tiene una cuenta, puede ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.normal
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'iniciar sesión',
                      style: DefaultTextStyle.of(context).style.copyWith(color: Colors.blue, fontSize: 14),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.pop(context);
                      }
                    )
                  ]
                ),
              )
            ],
          )),
        ),
      ),
    );
    
  }

  String? validatorText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }

}