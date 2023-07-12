import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapplication/Views/Search.dart';
import 'package:wallpaperapplication/Widget/Categorie_Tile.dart';
import 'package:wallpaperapplication/Widget/widget.dart';
import 'package:wallpaperapplication/data/Data.dart';
import 'package:wallpaperapplication/model/Categories_model.dart';
import 'package:wallpaperapplication/model/walpaper_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchcontroller = new TextEditingController();
  List<CategoriesModel> categories = [];
  List<Wallpapermodel> wallpapers = [];
  getTrendingWallpapers() async {
    var response = await http.get(
      Uri.parse("https://api.pexels.com/v1/curated?per_page=145&page=1"),
      headers: {"Authorization": apiKey},
    );
    // print(response.body.toString());
    Map<String, dynamic> jsondata = jsonDecode(response.body);
    jsondata["photos"].forEach(
      (element) {
        // Wallpapermodel wallpapermodel = Wallpapermodel();
        Wallpapermodel wallpapermodel = Wallpapermodel.fromMap(element);
        wallpapers.add(wallpapermodel);
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: BrandName()),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchcontroller,
                        decoration: InputDecoration(
                            hintText: 'search wallpapers',
                            border: InputBorder.none),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Search(
                                searchQuery: searchcontroller.text,
                              ),
                            ),
                          );
                        },
                        child: const Icon(Icons.search)),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        title: categories[index].categorieName,
                        ImgUrl: categories[index].ImageURL,
                      );
                    }),
              ),
              WallpapersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
