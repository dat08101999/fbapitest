import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fbtestapi/FaceBookHelper/FaceBookHelper.dart';
import 'package:fbtestapi/SocialMedia/SocialMediaLogin.dart';
import 'package:flutter/material.dart';
import 'package:g_json/g_json.dart';

class SlidePhotos extends StatefulWidget {
  dynamic photos;
  int index;

  SlidePhotos(this.photos, this.index);

  @override
  _SlidePhotosState createState() => _SlidePhotosState(photos, index);
}
class _SlidePhotosState extends State<SlidePhotos> {
  dynamic photos;
  int index;
  PageController _controller=PageController();
  _SlidePhotosState(this.photos,this.index);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    photos=json.decode(photos.toString());
    photos=photos['photos'];
  }
  Future jumpToIndexPage()async
  {
    _controller.animateToPage(this.index,duration: Duration(milliseconds: 10),curve: Curves.easeIn);
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      jumpToIndexPage();
      // executes after build
    });
    return Scaffold(
     body: PageView.builder(
       onPageChanged: (index){},
       controller: _controller,
       itemCount: photos['data'].length,
       itemBuilder: (buildContext,index){
         return CachedNetworkImage(
           imageUrl: FaceBookHelper.replace(photos['data'][index]['picture'].toString()),
           progressIndicatorBuilder: (context, url, downloadProgress) =>
               Container(color: Colors.black45,),
           errorWidget: (context, url, error) => Icon(Icons.error),
         );
       },
     ),
    );
  }
}
