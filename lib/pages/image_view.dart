import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  ImageView({@required this.imgUrl});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: widget.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 30),
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _save();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(colors: [
                          Color(0x90FFFFFF),
                          Color(0x6FFFFFFF),
                        ])),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Save Wallpaper',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text('This picture will save into your gallary')
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  _save() async {
    if (Platform.isAndroid) {
      PermissionStatus permissionStorage = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permissionStorage != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissionStatus =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.storage]);
        permissionStorage = permissionStatus[PermissionGroup.storage] ??
            PermissionStatus.unknown;

        if (permissionStorage != PermissionStatus.granted) {
          // print("❌----------has no Permission");
          return;
        }
      }
    }
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }
}
