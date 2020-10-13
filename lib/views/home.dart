import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wall_paper_app/model/fetch_model.dart';
import 'package:wall_paper_app/util/fetch_file.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wall_paper_app/model/choice_file.dart';
import 'package:wall_paper_app/util/choice_list.dart';
import 'package:wall_paper_app/views/preview_image.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ListClass> curated = new List<ListClass>();
  List<Choices> choices = new List<Choices>();
  var searchBar = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchBar.dispose();
    super.dispose();
  }

  bool _loading = true, searchBarVisibility = false;
  @override
  void initState() {
    super.initState();
    getChoices();
    getCuratedImages("nature");
  }

  void getChoices() {
    GetChoices obj = new GetChoices();
    choices = obj.getList();
    setState(() {});
  }

  void getCuratedImages(String keyWord) async {
    FetchFile obj = new FetchFile();
    await obj.getImageByUrl(
        "https://api.pexels.com/v1/search?query=$keyWord&per_page=15");
    curated = obj.results;
    setState(() {
      _loading = false;
      searchBarVisibility = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                      onTap: () {
                        searchBarVisibility = true;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.blue,
                      )))
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Wall",
                  style: TextStyle(color: Colors.black),
                ),
                Text("Paper", style: TextStyle(color: Colors.blue))
              ],
            ),
            backgroundColor: Colors.white,
          ),
          body: _loading
              ? Center(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: 56,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              splashColor: Colors.blue,
                              onTap: () {
                                getCuratedImages(choices[index].key);
                              },
                              child: ChoiceTiles(
                                  url: choices[index].imageUrl,
                                  keyString: choices[index].key),
                            );
                          },
                          itemCount: choices.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: searchBarVisibility
                            ? Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: searchBar,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      String st = searchBar.text;
                                      if (st != null || st != "")
                                        getCuratedImages(st);
                                    },
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.blue,
                                    ),
                                  )
                                ],
                              )
                            : SizedBox(),
                      ),
                      Expanded(
                          child: Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return ImageTiles(
                                width: curated[index].width,
                                height: curated[index].height,
                                photographerId: curated[index].photographerId,
                                url: curated[index].url,
                                photographerName:
                                    curated[index].photographerName,
                                photographerUrl: curated[index].photographerUrl,
                                original: curated[index].original,
                                large2x: curated[index].large2x,
                                large: curated[index].large2x,
                                medium: curated[index].medium,
                                small: curated[index].small,
                                portrait: curated[index].portrait,
                                landscape: curated[index].landscape,
                                tiny: curated[index].tiny);
                          },
                          itemCount: curated.length,
                        ),
                      ))
                    ],
                  ),
                )),
    );
  }
}

//////////////////image reslt tiles//////////////////////
class ImageTiles extends StatelessWidget {
  ImageTiles(
      {this.width,
      this.height,
      this.photographerId,
      this.url,
      this.photographerName,
      this.photographerUrl,
      this.original,
      this.large2x,
      this.large,
      this.medium,
      this.small,
      this.portrait,
      this.landscape,
      this.tiny});

  int width, height, photographerId;
  final url,
      photographerName,
      photographerUrl,
      original,
      large2x,
      large,
      medium,
      small,
      portrait,
      landscape,
      tiny;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: InkWell(
        highlightColor: Colors.blueAccent,
        focusColor: Colors.blueGrey,
        splashColor: Colors.lightBlue,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PreviewInDetail( width:width,
                                height:height,
                                photographerId: photographerId,
                                url:url,
                                photographerName: photographerName,
                                photographerUrl: photographerUrl,
                                original: original,
                                large2x: large2x,
                                large:large2x,
                                medium: medium,
                                small: small,
                                portrait: portrait,
                                landscape: landscape,
                                tiny:tiny,
                                urlPlacehoder: portrait)));
        },
        child: Card(
          elevation: 2,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: 250,
                    placeholder: (context, url) =>
                        Image.asset("assets/images/sample.gif", height: 100),
                    imageUrl: landscape),
              ),
              // Text(name),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////choice tiles////////////////////

class ChoiceTiles extends StatelessWidget {
  ChoiceTiles({this.url, this.keyString});
  final keyString, url;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Card(
        color: Colors.blue,
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              keyString,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
