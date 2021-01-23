import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fbtestapi/FaceBookHelper/FaceBookHelper.dart';
import 'package:fbtestapi/SocialMedia/SocialMediaLogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SlidePhotos.dart';
class AlbumsPhotos extends StatefulWidget {
  dynamic id;
  AlbumsPhotos(this.id);
  @override
  _AlbumsPhotosState createState() => _AlbumsPhotosState(id);
}
class _AlbumsPhotosState extends State<AlbumsPhotos>{
  dynamic id;
  dynamic _photos;
  dynamic listphotosPass;
  _AlbumsPhotosState(this.id);
  getPhotos()async
  {
    dynamic photos=await FaceBookHelper().getInfo(id, SocialMediaLogin.token,'photos{picture}');
    _photos=json.decode(photos.toString());
    _photos=_photos['photos'];
    listphotosPass=photos;
    return _photos;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: buildPhotosAlbum(),
    );
  }
  Widget buildGridViewItem(BuildContext context,int index){
    return InkWell(
      onTap: (){Get.to(SlidePhotos(listphotosPass,index));},
      child: CachedNetworkImage(
        imageUrl: _photos['data'][index]['picture'],
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            Container(color: Colors.black45,),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
  Widget buildPhotosAlbum()
  {
    return FutureBuilder(
        future: getPhotos(),
        builder:(buildcontext,snapshot)
            {
              print(snapshot.hasData);
              if(!snapshot.hasData)
                return Center(child: CircularProgressIndicator(),);
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: buildGridViewItem
              );
            }
    );
  }
}
