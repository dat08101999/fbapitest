import 'package:fbtestapi/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';
import 'SocialMedia/SocialMediaLogin.dart';
import 'FaceBookHelper/FaceBookHelper.dart';
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
              child: SignInButton(
                Buttons.FacebookNew,
                onPressed: ()async{
                  FacebookAccessToken token=await SocialMediaLogin().signInWithFB();
                  SocialMediaLogin.token=token.token;
                 dynamic user= await FaceBookHelper().getInfo(token.userId, token.token,'id,name,picture');
                 user=JSON.parse(user);
                  print(user['name']);
                  if(token!=null)
                    {
                      Get.off(MyHomePage(user: user,));
                    }
                },
              ))
        ],
      ),
    );
  }
}
