import 'package:newsapp/models/show_category.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ShowCategoryNews {
  List<ShowCategoryModel> categories = [];

  Future<void> getCategoryNews(String category) async {
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=85b04e2db1f044a180a0d9c0001fe31c";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ShowCategoryModel showCategoryModel = ShowCategoryModel(
            urlToImage: element["urlToImage"],
            desc: element["description"],
            title: element["title"],
            url: element["url"],
          );
          categories.add(showCategoryModel);
        }
      });
    }
  }
}