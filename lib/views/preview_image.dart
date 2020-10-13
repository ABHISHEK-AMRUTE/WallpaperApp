import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallpaper/wallpaper.dart';

class PreviewInDetail extends StatefulWidget {
  int width, height, photographerId;
  String url,
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

  PreviewInDetail(
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
      this.tiny,
      this.urlPlacehoder});

  String urlPlacehoder;

  int valueDropDown = 6;

  @override
  _PreviewInDetailState createState() => _PreviewInDetailState();
}

class _PreviewInDetailState extends State<PreviewInDetail> {
  void setWallpaper() async {
    var progressString = Wallpaper.ImageDownloadProgress(widget.urlPlacehoder);
    progressString.listen((data) {
      print("DataReceived: " + data);
    }, onDone: () async {
      var width = MediaQuery.of(context).size.width;
      var height = MediaQuery.of(context).size.height;
      var home = await Wallpaper.homeScreen();

      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: [
        CachedNetworkImage(
            // fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            placeholder: (context, url) =>
                Image.asset("assets/images/sample.gif", height: 100),
            imageUrl: widget.urlPlacehoder),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                    value: widget.valueDropDown,
                    items: [
                      DropdownMenuItem(
                        child: Text("Original"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("Large 2x"),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text("Large"),
                        value: 3,
                      ),
                      DropdownMenuItem(
                        child: Text("Medium"),
                        value: 4,
                      ),
                      DropdownMenuItem(
                        child: Text("Small"),
                        value: 5,
                      ),
                      DropdownMenuItem(
                        child: Text("Portrait"),
                        value: 6,
                      ),
                      DropdownMenuItem(
                        child: Text("Landscape"),
                        value: 7,
                      ),
                      DropdownMenuItem(
                        child: Text("Tiny"),
                        value: 8,
                      ),
                    ],
                    onChanged: (value) {
                      widget.valueDropDown = value;
                      switch (value) {
                        case 1:
                          widget.urlPlacehoder = widget.original;
                          break;
                        case 2:
                          widget.urlPlacehoder = widget.large2x;
                          break;
                        case 3:
                          widget.urlPlacehoder = widget.large;
                          break;
                        case 4:
                          widget.urlPlacehoder = widget.medium;
                          break;
                        case 5:
                          widget.urlPlacehoder = widget.small;
                          break;
                        case 6:
                          widget.urlPlacehoder = widget.portrait;
                          break;
                        case 7:
                          widget.urlPlacehoder = widget.landscape;
                          break;
                        case 8:
                          widget.urlPlacehoder = widget.tiny;
                          break;
                        default:
                          widget.urlPlacehoder = widget.portrait;
                          break;
                      }
                      setState(() {});
                    }),
                IconButton(
                    icon: Icon(
                      Icons.file_download,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setWallpaper();
                    })
              ],
            ),
          ),
        )
      ]),
    );
  }
}
