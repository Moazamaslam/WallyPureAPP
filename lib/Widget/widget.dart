import 'package:flutter/material.dart';
import 'package:wallpaperapplication/Views/Image_View.dart';
import 'package:wallpaperapplication/model/walpaper_model.dart';

Widget BrandName() {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      children: const <TextSpan>[
        TextSpan(
            text: 'Wallpaper',
            style: TextStyle(color: Colors.black87, fontSize: 22)),
        TextSpan(text: ' Hub', style: TextStyle(color: Colors.white)),
      ],
    ),
  );
}

Widget WallpapersList({List<Wallpapermodel>? wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers!.map((wallpaper) {
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImageView(
                          ImgURL: wallpaper.src.portrait,
                        )));
          },
          child: Hero(
            tag: wallpaper.src.portrait,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  wallpaper.src.portrait,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ));
      }).toList(),
    ),
  );
}
