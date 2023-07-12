import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:wallpaperapplication/Widget/widget.dart';

class ImageView extends StatefulWidget {
  const ImageView({Key? key, required this.ImgURL}) : super(key: key);
  final String ImgURL;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  bool i = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BrandName(),
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () {
              i = false;
              _save(i);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: Icon(
                Icons.download,
                size: 44,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.ImgURL,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.ImgURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    PermissionStatus photos =
                        await Permission.storage.request();
                    if (photos == PermissionStatus.granted) {
                      _save(i);
                    } else if (photos == PermissionStatus.denied) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('This permission is recommended'),
                        ),
                      );
                    } else if (photos == PermissionStatus.permanentlyDenied) {
                      openAppSettings();
                    }
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Color(0xff1C1B1B).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      Container(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width / 2,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white54, width: 1.0),
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(colors: [
                              Color(0x36FFFFFF),
                              Color(0x0FFFFFFF),
                            ])),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Set Wallpaper',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white70),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'Image will be saved in gallery',
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _save(i) async {
    await _askPermission();
    var response = await Dio()
        .get(widget.ImgURL, options: Options(responseType: ResponseType.bytes));
    // final result =
    //     await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    Navigator.pop(context);
    if (i == true) {
      _setWalpaper(WallpaperManagerFlutter.HOME_SCREEN);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image Saved and wallpaper is being set'),
        ),
      );
    } else {
      SnackBar(
        content: Text('Image Saved'),
      );
    }
  }

  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */
      await Permission.photos.request();
      await Permission.photosAddOnly.request();
    } else {
      /* PermissionStatus permission = */
      await Permission.storage.status;
      await Permission.photosAddOnly.status;
    }
  }

  Future<void> _setWalpaper(location) async {
    var file = await DefaultCacheManager().getSingleFile(widget.ImgURL);
    try {
      WallpaperManagerFlutter().setwallpaperfromFile(file, location);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Wallpaper updated'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Setting Wallpaper'),
        ),
      );
      print(e);
    }
  }
}
