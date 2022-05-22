import 'package:flutter/material.dart';

import 'package:doofi/api_accessor.dart';
import 'package:doofi/user_data.dart';

import 'package:doofi/pages/home_screen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.person), labelText: "Email: "),
                onSaved: (data) {
                  _email = data!;
                },
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return "Email não pode ser vazio.";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.add), labelText: "Senha"),
                onSaved: (data) {
                  _password = data!;
                },
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return "Senha não pode ser vazia.";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Future<String> res =
                        ApiAccessor.verifyLogin(_email, _password);
                    res.then(
                      (value) {
                        if (value == "Success") {
                          pushHomeScreen(context);
                        } else {
                          showError(context);
                        }
                      },
                    );
                  }
                },
                child: const Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void pushHomeScreen(BuildContext context) {
  Navigator.pop(context);
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => HomeScreen()));
}

void showError(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: const Text("Wrong credentials, try again."),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
