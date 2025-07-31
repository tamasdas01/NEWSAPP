import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/pages/article_view.dart';
import 'package:newsapp/pages/category_news.dart';
import 'package:newsapp/services/data.dart';
import 'package:newsapp/services/news.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles=[];
  bool loading=true;

  @override
  void initState() {
    categories = getCategories();
    getNews();
    super.initState();
  }

  getNews() async{
    News newsclass = News();
    await newsclass.getNews();
    articles= newsclass.news;
    setState(() {
      loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 255, 255, 255),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Buzz",
                    style: TextStyle(
                      color: Color(0xff3280ef),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Line",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              Text(
                "Hottest News",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                height: MediaQuery.of(context).size.height / 2.91,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: articles.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: articles[index].url!)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 3.0, left: 5.0, right: 10.0),
                        child: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      articles[index].urlToImage!,
                                      width: MediaQuery.of(context).size.width/2,
                                      fit: BoxFit.cover,
                                      height: 150,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0,),
                                Container(
                                  width: MediaQuery.of(context).size.width / 1.8,
                                  child: Text(
                                    maxLines: 2,
                                    articles[index].title!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color.fromARGB(188, 0, 0, 0),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,),
                                  ),
                                ),
                                SizedBox(height: 5.0,),
                                Container(
                                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                                  width: MediaQuery.of(context).size.width / 1.8,
                                  child: Text(
                                    maxLines: 2,
                                    articles[index].desc!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: const Color.fromARGB(151, 0, 0, 0),
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Color(0xff3280ef),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20))),
                                    margin: EdgeInsets.only(left: 160),
                                    child: Icon(
                                        Icons.arrow_forward, color: Colors.white,
                                        size: 30.0)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } ),
              ),
        
              SizedBox(height: 10.0,),
              Text(
                "Explore",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,),
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                  return CategoryTile(
                    categoryname: categories[index].categoryName,
                    image: categories[index].image,);
                }),
              ),
        
              Text(
                "Trending News",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: articles[index].url!)));
                        },
                        child:Container(
                          margin: EdgeInsets.only(bottom: 20.0, right: 20.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          child: Row(children: [
                            ClipRRect(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                child: Image.network(
                                  articles[index].urlToImage!,
                                  height: 120, width: 120, fit: BoxFit.cover,)),
                            Column(children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 1.7,
                                child: Text(
                                  articles[index].title!,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: const Color.fromARGB(188, 0, 0, 0),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,),
                                ),
                              ),
                              SizedBox(height: 5.0,),
                              Container(
                                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                                width: MediaQuery.of(context).size.width / 1.8,
                                child: Text(
                                  articles[index].desc!,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: const Color.fromARGB(151, 0, 0, 0),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],)
                          ],
                          ),
                        ),
                      );
                    } ),
              ),
        
        
        
            ],
          ),
        ),
      ),
    );
  }
}
class CategoryTile extends StatelessWidget {
  final image, categoryname;
  CategoryTile({this.categoryname, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryNews(name: categoryname)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
                child: Image.asset(image, height: 120, width: 120, fit: BoxFit.cover)),
            Container(
              height: 120, width: 120,
              decoration: BoxDecoration(color: Colors.black26,
                borderRadius: BorderRadius.circular(60)),
            ),
            Container(
              height: 120, width: 120,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
              child: Center(child: Text(categoryname, style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),)),
            )
          ],
        ),
      ),
    );
  }
}



