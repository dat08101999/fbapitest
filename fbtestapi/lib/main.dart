import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fbtestapi/SocialMedia/SocialMediaLogin.dart';
import 'package:flutter/material.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';
import 'LoginView.dart';
import 'FaceBookHelper/FaceBookHelper.dart';
import 'AlbumsView.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginView(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  dynamic user;
  MyHomePage({this.user});
  @override
  _MyHomePageState createState() => _MyHomePageState(user: user);
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic user;
  dynamic _friends;
  int count=0;
  getFriends() async
  {
    dynamic friends=await FaceBookHelper().getInfo(
        FaceBookHelper.replace(user['id']),
        SocialMediaLogin.token,
        'friends{picture,name}');
    _friends=json.decode(friends);
    return _friends;
  }
  _MyHomePageState({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
    );
  }

  buildBody()
  {
    return FutureBuilder(
        future: getFriends(),
        builder:(context,snapshot){
          if(!snapshot.hasData)
            return Center(child: CircularProgressIndicator(),);
          return ListView.builder(
             itemCount: _friends['friends']['data'].length,
             itemBuilder:builListInfo
          );
        });
  }
 Widget builListInfo(BuildContext build,int index)
  {
    print(FaceBookHelper.replace('img'+_friends["friends"]["data"][index]["picture"]["data"]["url"]));
     return InkWell(
       onTap: (){Get.to(AlbumsView(_friends["friends"]["data"][index]['id']));},
       child: ListTile(
         title: Text(
             FaceBookHelper.replace(_friends['friends']['data'][index]['name']),
             style: TextStyle(
               fontSize: 18
             ),
         ),
         leading: AspectRatio(
           aspectRatio: 6/6,
           child: CachedNetworkImage(
             imageUrl: FaceBookHelper.replace(_friends["friends"]["data"][index]["picture"]["data"]["url"]),
             placeholder: (context, url) => Container(
               color: Colors.black45,
             ),
             errorWidget: (context, url, error) => Icon(Icons.error),
           ),
         ),
       ),
     );
  }
  buildAppbar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        user['name'].toString().replaceAll('"', ''),
      ),
      actions: [
        Image.network(user['picture']['data']['url'].toString().replaceAll('"', ''))
      ],
    );
  }
}
