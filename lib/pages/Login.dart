import 'package:adoption_pe/pages/SignUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }

}

class LoginState extends State<Login> {

  final _loginKey = GlobalKey<FormState>();

  String _name = '';
  String _lastname = '';

  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
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
    FirebaseFirestore db = FirebaseFirestore.instance;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _loginKey,
          child: ListView(
            padding: const EdgeInsets.only(
              right: 15,
              left: 15,
              top: 15
            ),
            children: <Widget>[
              const Image(
                image: AssetImage('assets/img/login.png'),
                height: 200,
              ),
              const Text(
                "Inicio de Sesión",
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
                      color: Colors.greenAccent
                    )
                  )
                ),
              ),
              Container(height: 15),
              TextFormField(
                validator: validatorText,
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  hintText: 'Por favor, ingrese su contraseña',
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.greenAccent
                    )
                  )
                ),
              ),
              Container(height: 15),
              ElevatedButton(
                onPressed: () async {
                  if (_loginKey.currentState!.validate()) {
                    User? user = await loginUsingEmailPassword(
                      email: _emailController.text, 
                      password: _passwordController.text, 
                      context: context
                    );
                    print(user);
                    if (user != null) {
                      //Nada de momento
                    }
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
                child: const Text('INICIAR'),
              ),
              Container(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: (){

                    }, 
                    icon: Image.asset('assets/img/google_icon_64.png')
                  ),
                  IconButton(
                    onPressed: (){

                    }, 
                    icon: Image.asset('assets/img/facebook_icon_64.png')
                  ),
                ],
              ),
              Container(height: 15),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Si no tiene cuenta, puede ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.normal
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'registrarse',
                      style: DefaultTextStyle.of(context).style.copyWith(color: Colors.blue, fontSize: 14),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                      }
                    )
                  ]
                ),
              )
            ],
          ),
        )
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
