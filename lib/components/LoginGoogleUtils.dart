import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Login"),),
        body: LoginGoogleUtils(),
      ),
    );
  }
}

class LoginGoogleUtils extends StatefulWidget {
  const LoginGoogleUtils({Key? key}) : super(key: key);

  @override
  _LoginGoogleUtilsState createState() => _LoginGoogleUtilsState();
}

class _LoginGoogleUtilsState extends State<LoginGoogleUtils> {

  String welcome = "Login with Google";

  final GoogleSignIn googleSignIn = GoogleSignIn();

  GoogleSignInAccount? googleUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account){
      setState(() {
        googleUser = account;
      });

      if(googleUser!= null){
        // Perform your action
      }
      googleSignIn.signInSilently();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(welcome,style: const TextStyle(fontSize: 30.0),),
          ),

          TextButton(onPressed: (){
            signIn();
          }, child: const Text("Login",style: const TextStyle(fontSize: 20.0),)),
          TextButton(onPressed: (){
            signOut();
          }, child: const Text("Logout",style: const TextStyle(fontSize: 20.0),)),


        ],
      ),
    );
  }

  Future<UserCredential> signIn() async {

    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    setState(() {
      welcome = googleUser!.email;
    });

    final GoogleSignInAuthentication? googleAuth =  await googleUser!.authentication;

    final credential =  GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    print("signed in " );
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }

  Future<void> signOut() async {
    googleSignIn.disconnect();
    setState(() {
      welcome = "Logged out";
    });

  }

}