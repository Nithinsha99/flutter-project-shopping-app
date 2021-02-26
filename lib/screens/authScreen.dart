
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/provider/auth.dart';
enum AuthMode{
  Signup,
  loginUp
}
class AuthScreen extends StatelessWidget {
  static const routerName="/auth screen";

  @override
  Widget build(BuildContext context) {
    final deviceSize=MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green,
                  Colors.greenAccent,
                  Colors.blue[200]
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              )
          ),


          ),
          SingleChildScrollView(
            child: Container(
              width: deviceSize.width,
              height: deviceSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(child: Container(

                    margin: EdgeInsets.only(bottom: 30),
                    //padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0.4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white70,
                            blurRadius: 1,
                            spreadRadius: 1
                        )
                      ],
                      color: Colors.black,
                    ),
                    transform:  Matrix4.rotationZ(-8 * pi / 180)
                      ..translate(-10.0),


                    child: Text("the shop app",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50,
                    ),),


                  ),
                  ),
                  Flexible(flex:deviceSize.width>600?2:1,child: AuthData())
                ],
              ),
            ),

          )
        ],

      ),
    );
  }
}

class AuthData extends StatefulWidget {
  const AuthData({
    Key key,
  }) : super(key: key);

  @override
  _AuthDataState createState() => _AuthDataState();
}

class _AuthDataState extends State<AuthData> {
  final GlobalKey<FormState> _formKey=GlobalKey();
  AuthMode authMode=AuthMode.loginUp;
  Map<String,String> _mapData={
    "email": '',
    "password": '',
  };
  var isLoading=false;
  final passwordController=TextEditingController();
  Future<void>save() async{
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();
    setState(() {
      isLoading=true;

    });
    if(authMode==AuthMode.loginUp){
      print("heloo");

      ///
    }else{
      print("else");
      print(_mapData["password"].length);
      print(_mapData["email"]);
      await Provider.of<Auth>(context,listen: false).signUp(_mapData["password"], _mapData["email"]);

      ///
    }
    setState(() {
      isLoading=false;
    });
  }
  void changeState(){
    if(authMode==AuthMode.loginUp){
      setState(() {
        authMode=AuthMode.Signup;
      });
    }else{
      setState(() {
        authMode=AuthMode.loginUp;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final deviceLength=MediaQuery.of(context).size;
    return Card(
      elevation: 10,
      child: Container(
        margin: EdgeInsets.all(30),
        height: authMode==AuthMode.Signup?400:300,
        child: Form(key:_formKey,child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter the email",
                ),
                keyboardType:TextInputType.emailAddress,
                validator: (value){
                  if(value.isEmpty || !value.contains("@")){
                    print(value);
                    return "the email is invalid";


                  }
                },
                onSaved: (value){
                  _mapData["email"]=value;
                  print(_mapData["email"]);

                },


              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter the text",
                ),
                keyboardType:TextInputType.visiblePassword,
                validator: (value){
                  if(value.isEmpty || value.length<5){
                    return "plzz enter the strong Password";

                  }
                },
                controller: passwordController,
                onSaved: (value){
                  _mapData["password"]=value;
                  print(_mapData["password"]);


                },
              ),
              if(AuthMode.Signup==authMode)
                TextFormField(
                  decoration: InputDecoration(labelText: "Conform Password"),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator: authMode==AuthMode.Signup?(value){
                    if(value!=passwordController.text){
                      return "enter the same value";

                    }}:null,
                ),
              SizedBox(
                height: 20,
              ),
              if (isLoading)
                CircularProgressIndicator()
              else
                RaisedButton(
                  child:
                  Text(authMode == AuthMode.loginUp? 'LOGIN' : 'SIGN UP'),
                  onPressed: save,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryTextTheme.button.color,
                ),
              FlatButton(
                child: Text(
                    '${authMode == AuthMode.loginUp ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                onPressed: changeState,
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textColor: Theme.of(context).primaryColor,
              ),





              /* FlatButton(onPressed: (){
                if(authMode==AuthMode.Signup){
                  setState(() {
                    authMode=AuthMode.loginUp;
                  });
                }else{
                  setState(() {
                    authMode=AuthMode.Signup;
                  });
                }
              }, child: Text("the button",style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),))*/

            ],
          ),
        )),
      ),
    );
  }
}
