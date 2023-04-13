import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? authResult;
  var _isLoading = false;

  void _saveUserCrendentials(String email, String pswd, String userName, bool isLogin, BuildContext ctx,File selectedImage) async {
    print("saved  $email");
    auth.setLanguageCode("en");
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await auth.signInWithEmailAndPassword(email: email, password: pswd);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(email: email, password: pswd);
       final ref =  FirebaseStorage.instance.ref().child('image-store').child((authResult?.user?.uid).toString() + '.jpg');
       await ref.putFile(selectedImage);
       final url = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('users').doc(authResult?.user?.uid).set({
          'userName' : userName,
          'email' : email,
          'image_url' : url,
        });
      }
    } on PlatformException catch(err) {
      var msg = "error occured check your credentials";
      if(err.message != null) {
        msg = err.message ?? '';
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg,style: TextStyle(color: Colors.blue)),backgroundColor: Colors.white,));
    }
    catch(error) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(error.toString(),style: TextStyle(color: Colors.blue),),backgroundColor: Colors.white,));
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_saveUserCrendentials,_isLoading),
    );
  }
}
