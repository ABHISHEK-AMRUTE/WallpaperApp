import 'dart:convert';

import 'package:wall_paper_app/model/fetch_model.dart';
import 'package:http/http.dart' as http;
import 'package:wall_paper_app/keys/key.dart';

class FetchFile {
  List<ListClass> results = new List<ListClass>();

  Future<void> getImageByUrl(String fetchUrl) async {
    Keys keyObj = Keys();
    String key = keyObj.getKey();
    Map<String, String> headers = {
      "Authorization": "$key",
    };
    var response = await http.get(fetchUrl, headers: headers);
    var jsonData = jsonDecode(response.body);
    print(jsonData["photos"].length);
    if (jsonData["photos"].length != 0) {
      jsonData["photos"].forEach((element) {
        ListClass itemObject = ListClass();
        itemObject.height = element["height"];
        itemObject.width = element["width"];
        itemObject.photographerId = element["photographer_id"];
        itemObject.photographerName = element["photographer"];
        itemObject.photographerUrl = element["photographer_url"];
        itemObject.url = element["url"];
        itemObject.original = element["src"]["original"];
        itemObject.large2x = element["src"]["large2x"];
        itemObject.large = element["src"]["large"];
        itemObject.medium = element["src"]["medium"];
        itemObject.small = element["src"]["small"];
        itemObject.tiny = element["src"]["tiny"];
        itemObject.portrait = element["src"]["portrait"];
        itemObject.landscape = element["src"]["landscape"];

        results.add(itemObject);
       
      });
    }
  }
}
