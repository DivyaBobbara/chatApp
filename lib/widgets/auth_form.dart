import '../widgets/pickers/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(String email, String pswd, String userName, bool isLogin, BuildContext ctx,File selectedImg) saveCredentials;

  AuthForm(this.saveCredentials, this.isLoading);


  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _uname = '';
  String _pswd = '';
  var _isLogin = false;
  File? selectedImg;
  
  void _pickedImage(File img) {
    selectedImg = img;
  }


  void trySubmit() {
    final isValid = _formKey.currentState?.validate();
    // FocusScope.of(context).unfocus();
    
    if(selectedImg == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('pls pick an imd')));
      return;
    }



    if (isValid ?? false) {
      print('$_email emaillll \n $_uname unameee \n $_pswd pswddd');
      _formKey.currentState?.save();
      widget.saveCredentials(
          _email.trim(), _pswd.trim(), _uname.trim(), _isLogin, context,selectedImg ?? File(''));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                if(!_isLogin) UserImagePicker(_pickedImage),

                TextFormField(
                  key: ValueKey("email"),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email Address'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'pls enter valid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value ?? '';
                  },
                ),
                if(!_isLogin)
                  TextFormField(
                    key: ValueKey("uname"),
                    decoration: InputDecoration(labelText: 'user name'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'userName must be atleast 4';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _uname = value ?? '';
                    },
                  ),
                TextFormField(
                  key: ValueKey("pswd"),
                  decoration: InputDecoration(labelText: 'password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'pswd must be atleast 7';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _pswd = value ?? '';
                  },
                ),
                SizedBox(height: 20,),
                if(widget.isLoading) CircularProgressIndicator(),
                if(!widget.isLoading) ElevatedButton(onPressed: trySubmit,
                      child: Text(_isLogin ? 'Login' : 'sign up')),
                TextButton(onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                }, child: Text(_isLogin ? 'create account' : 'already login')),

              ],),

            ),
          ),
        ),
      ),
    );
  }
}
