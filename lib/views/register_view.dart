import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/firebase_options.dart';




class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

 @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
              return Column(
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your Email here'
                ),
                maxLength: 200,
        
                ),
              TextField(
                controller: _password,
                decoration: const InputDecoration(
                  hintText: 'Enter your password here'
                ),
                maxLength: 10,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              TextButton(
              onPressed: () async {
                
        
                final email = _email.text;
                final password = _password.text;
                try{
                final userCredential =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email, 
                  password: password);
                print(userCredential);
                }on FirebaseAuthException catch (e) {
                  if (e.code== 'weak-password'){
                    print('weak password');
                  }else if(e.code =='email-already-in-use'){
                    print('Email is already in use');
                  }else{
                    print(e.code);
                  }
                }
              }, 
              child: Text('Register')),
          ]);
          default: 
            return const Text('Loading...');
            }
        }
    ));
  
  }
}

