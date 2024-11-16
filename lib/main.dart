import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Data_Firebase.dart';
import 'Login_Page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,           ///remove debug sign
      title: 'DDRUG',
      initialRoute: 'Start',
      routes: {
        'Start': (context) =>const Login_Page(),
        '/main': (context) =>const Drug_Data(),
        // '/page2': (context) => SignUp_Page(),
        // '/page3': (context) => const Drug_Data(),
      },
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DDRUG'),
      ),

    );
  }
}