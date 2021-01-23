import 'dart:convert';
import 'AlbumsPhotosView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'FaceBookHelper/FaceBookHelper.dart';
import 'SocialMedia/SocialMediaLogin.dart';
class AlbumsView extends StatefulWidget {
  var userID;
  AlbumsView(this.userID);
  @override
  _AlbumsViewState createState() => _AlbumsViewState(userID);
}

class _AlbumsViewState extends State<AlbumsView> {
  var userID;
  dynamic user;
  _AlbumsViewState(this.userID);
  getUserAlbums() async{
    user=await FaceBookHelper().getInfo(userID, SocialMediaLogin.token,'id,name,albums');
    user=json.decode(user);
   return user;
  }
  void printt() async
  {
    await getUserAlbums();
    print(user['name']);
  }
  @override
  Widget build(BuildContext context) {
    printt();
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getUserAlbums(),
        builder: (context,snapshot){
          if(!snapshot.hasData)
            return Center(child: CircularProgressIndicator(),);
          return buildGridviewAlbums();
        },
      ),
    );
  }
  Widget buildGridItem(BuildContext builContext,int index){
    return InkWell(
      onTap: (){Get.to(AlbumsPhotos(user['albums']['data'][index]['id']));},
      child: Container(
        color: Colors.black45,
        child: Center(child: Text(
            user['albums']['data'][index]['name']
        ),),
      ),
    );
  }
  buildGridviewAlbums()
  {
    return GridView.builder(
       itemCount: user['albums']['data'].length,
        itemBuilder: buildGridItem,
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing:10,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
        )
    );
  }
}
