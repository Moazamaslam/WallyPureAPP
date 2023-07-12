import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapplication/Widget/widget.dart';
import 'package:wallpaperapplication/data/Data.dart';
import 'package:wallpaperapplication/model/walpaper_model.dart';

class Search extends StatefulWidget {
  Search({Key? key, required this.searchQuery}) : super(key: key);
  final String searchQuery;
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = new TextEditingController();
  List<Wallpapermodel> wallpapers = [];
  getSearchWallpapers(String query) async {
    var response = await http.get(
      Uri.parse(
          "https://api.pexels.com/v1/search?query=$query&per_page=45&page=1   "),
      headers: {"Authorization": apiKey},
    );
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
    getSearchWallpapers(widget.searchQuery);
    // TODO: implement initState
    super.initState();
    searchController.text = widget.searchQuery;
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
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: 'search wallpapers',
                            border: InputBorder.none),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          getSearchWallpapers(searchController.text);
                        },
                        child: const Icon(Icons.search)),
                  ],
                ),
              ),
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
