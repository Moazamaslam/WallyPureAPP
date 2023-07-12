import 'package:flutter/material.dart';
import 'package:wallpaperapplication/Views/Categorie.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({Key? key, required this.ImgUrl, required this.title})
      : super(key: key);
  final String ImgUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categorie(
                      QueryName: title.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 8.0),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  ImgUrl,
                  height: 50.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              height: 50.0,
              width: 100.0,
              child: Text(
                title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
