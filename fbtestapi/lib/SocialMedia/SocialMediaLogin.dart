import 'package:flutter_facebook_login/flutter_facebook_login.dart';
class SocialMediaLogin{
  static String token='';
  Future<FacebookAccessToken> signInWithFB() async
  {
    FacebookLogin().logOut();
    FacebookLoginResult facebookLoginResult= await FacebookLogin().logIn(['email']);
    FacebookAccessToken token=facebookLoginResult.accessToken;
    print(facebookLoginResult.errorMessage);
    return token;
  }
}