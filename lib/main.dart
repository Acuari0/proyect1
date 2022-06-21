//Johan Guillen
//Biomagana Pro
// Pago 300$



import 'package:biomagnapro/LoginWidget/LoginScreen.dart';
import 'package:biomagnapro/Splash/SplashScreen.dart';
import 'package:biomagnapro/itsok.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class  Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return (Splash());
  }
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return ItsOk();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return LoginScreen();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Load();
      },
    );
  }
}



