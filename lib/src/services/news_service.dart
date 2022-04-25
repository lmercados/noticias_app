import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/news_models.dart';



const String _baseUrl = 'newsapi.org';
const String _apiKey   = '6afdcb6fd0b4435996e2821ea64e7c91';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  bool _isLoading = true;

  List<Category> categories = [
    Category( FontAwesomeIcons.building, 'business'  ),
    Category( FontAwesomeIcons.tv, 'entertainment'  ),
    Category( FontAwesomeIcons.addressCard, 'general'  ),
    Category( FontAwesomeIcons.headSideVirus, 'health'  ),
    Category( FontAwesomeIcons.vials, 'science'  ),
    Category( FontAwesomeIcons.volleyball, 'sports'  ),
    Category( FontAwesomeIcons.memory, 'technology'  ),
  ];

  Map<String, List<Article>> categoryArticles = {};


      
  NewsService() {
    getTopHeadlines();

   /* for (var item in categories) {
      categoryArticles[item.name] =item.name as List<Article>;
    }

    getArticlesByCategory(_selectedCategory );*/
  }

  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;
  set selectedCategory( String valor ) {
    _selectedCategory = valor;

    _isLoading = true;
    getArticlesByCategory( valor );
    notifyListeners();
  }
  
   List<Article>? get getArticulosCategoriaSeleccionada =>categoryArticles[selectedCategory ];




  getTopHeadlines() async {
    

      
      var url = Uri.https(_baseUrl, '/v2/top-headlines', {
        'country': 'us',
        'apiKey': _apiKey,

       });
    
       final response = await http.get(url);
       final newsResponse = NewsResponse.fromJson( response.body );
      //print(newsResponse);
       headlines.addAll( newsResponse.articles );
       notifyListeners();
  }

  getArticlesByCategory( String category ) async {

      if (categoryArticles[category]!.isNotEmpty ) {
        _isLoading = false;
        notifyListeners();
        return categoryArticles[category];
      }

      final url ='$_baseUrl/top-headlines?apiKey=$_apiKey&country=ca&category=$category' as Uri;
      final resp = await http.get(url);

      final newsResponse = NewsResponse.fromJson(resp.body );

      categoryArticles[category]!.addAll( newsResponse.articles );

      _isLoading = false;
      notifyListeners();

  }


}




