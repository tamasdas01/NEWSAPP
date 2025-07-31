import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news=[];

  Future<void> getNews() async{
    String url= "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=85b04e2db1f044a180a0d9c0001fe31c";
    var response= await http.get(Uri.parse(url));

    var jsonData= jsonDecode(response.body);

    if(jsonData['status']=='ok') {
      jsonData["articles"].forEach((element){
       if(element["urlToImage"]!=null && element["description"]!=null){
         ArticleModel articleModel= ArticleModel(
           urlToImage: element["urlToImage"],
           desc: element["description"],
           title: element["title"],
           url: element["url"],
         );
         news.add(articleModel);
       }
      });
    }

  }
}