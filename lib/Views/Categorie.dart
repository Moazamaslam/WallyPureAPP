import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapplication/Widget/widget.dart';
import 'package:wallpaperapplication/data/Data.dart';
import 'package:wallpaperapplication/model/walpaper_model.dart';

class Categorie extends StatefulWidget {
  const Categorie({Key? key, required this.QueryName}) : super(key: key);
  final String QueryName;

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<Wallpapermodel> wallpapers = [];
  getCatogorieWallpapers(String query) async {
    var response = await http.get(
      Uri.parse(
          "https://api.pexels.com/v1/search?query=$query&per_page=145&page=1   "),
      headers: {"Authorization": apiKey},
    );
    // print(response.body.toString());
    Map<String, dynamic> jsondata = jsonDecode(response.body);
    jsondata["photos"].forEach(
      (element) {
        Wallpapermodel wallpapermodel = Wallpapermodel.fromMap(element);
        wallpapers.add(wallpapermodel);
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    getCatogorieWallpapers(widget.QueryName);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16.0,
              ),
              WallpapersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
