// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userFullNameController = TextEditingController();
  final _userPhoneController = TextEditingController();
  final _userIDController = TextEditingController();
  final _userPasswordVerificationController = TextEditingController();

  bool passwordsMatch() {
    final password = _userPasswordController.text.trim();
    final verification = _userPasswordVerificationController.text.trim();

    return password == verification && password.isNotEmpty;
  }

  void _registerUser()async{
      final password = _userPasswordController.text;
      final email = _userEmailController.text;
      final id = _userIDController.text;
      final name = _userFullNameController.text;
      final phone = _userPhoneController.text;
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  //     await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(id)
  //       .set({
  //       'email': email,
  //       'name': name,
  //       'phone': phone,
  //       'createdAt': Timestamp.now(),
  //     });
  //   print('Usuario registrado con ID: ${userCredential.user!.uid}');
  //   } on FirebaseAuthException catch (e) {
  //   print('Error de autenticación: ${e.code} - ${e.message}');
  // } catch (e) {
  //   print('Error general: $e');
  //   throw e;
  // }
  }

  void _SignUp() async {
    if (passwordsMatch() &&
        _userPasswordController.text.isNotEmpty &&
        _userEmailController.text.isNotEmpty &&
        _userFullNameController.text.isNotEmpty &&
        _userPhoneController.text.isNotEmpty) {
          _registerUser();
        Navigator.pushReplacementNamed(context, '/ ');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' Por favor , llene todos los datos ')),
      );
    }
  }

  Column customTextField({
    required TextEditingController controller,
    required String labelText,
    double spacing = 20.0,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        SizedBox(height: spacing),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' Registro ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //ID
            customTextField(controller: _userIDController, labelText: "ID"),
            //Full name
            customTextField(
              controller: _userFullNameController,
              labelText: "Nombre Completo",
            ),
            //Email
            customTextField(
              controller: _userEmailController,
              labelText: "Correo Electrónico",
            ),
            //Phone
            customTextField(
              controller: _userPhoneController,
              labelText: "Teléfono",
            ),
            //Password
            customTextField(
              controller: _userPasswordController,
              labelText: "Contraseña",
            ),
            //Password
            customTextField(
              controller: _userPasswordVerificationController,
              labelText: "Contraseña",
            ),
            //Loging button
            ElevatedButton(onPressed: _SignUp, child: Text(' Registrar ')),
          ],
        ),
      ),
    );
  }
}
