import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Homepage(),
  ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState){
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if(user?.emailVerified ?? false){
                print('You are a Verified user');
              }else{
                print('you need to verify your email first');
              }
              return const Text('done');
            default: 
              return const Text('Loading...');
            }
        }
    ));
  
  }
}