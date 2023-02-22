

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _email;
  late final TextEditingController _password;
  //although i didn't give a value for it i promise i will give it a value before it is used

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Register')),
      body:Column(
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                hintText: "Enter your email here",
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress, //@sign 
              decoration: const InputDecoration(
                hintText: "Enter your Password here",
              ),
            ),
            TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    final userCredentials = await FirebaseAuth.instance.
                    createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    // print(userCredentials);
                  } on FirebaseAuthException catch (e) {
                    if(e.code == 'weak-password'){
                      print("Weak Password");
                    } else if(e.code == "email-already-in-use"){
                      print("Email Already In Use.");
                    } else if(e.code == 'invalid-email') {
                      print('Invalid email entered');
                    }
                  }
                },
                child: const Text('Register')
                ),
                TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login/', 
                      (route) => false);
                },
                child: const Text("Not registered yet? Login here!"))
          ],
        ),
    );
  }
}