import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/news_service.dart';
import '../widgets/lista_noticias.dart';


class Tab1Page extends StatefulWidget {
  const Tab1Page({Key? key}) : super(key: key);


  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {

    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
      body: headlines.isEmpty 
          ? const Center(child: CircularProgressIndicator() )
          : ListaNoticias( headlines )
   );
  }

  @override
  bool get wantKeepAlive => true;
}