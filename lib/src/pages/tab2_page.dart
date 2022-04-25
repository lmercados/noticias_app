import 'package:flutter/material.dart';
import 'package:noticias_app/src/theme/theme.dart';

import 'package:provider/provider.dart';

import '../models/category_model.dart';
import '../services/news_service.dart';
import '../widgets/lista_noticias.dart';


class Tab2Page extends StatelessWidget {
  const Tab2Page({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            
            _ListaCategorias(),

            if ( !newsService.isLoading )
              Expanded(
                child: ListaNoticias( newsService.getArticulosCategoriaSeleccionada! )
              ),

            if ( newsService.isLoading )
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              )
            )



          ],
        )
   ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {

          final cName = categories[index].name;

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              _CategoryButton( categories[index] ),
              const SizedBox( height: 5),
              Text( '${ cName[0].toUpperCase() }${ cName.substring(1) }' )
            ],
          ),
        );
       },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  
  final Category categoria;

  const _CategoryButton( this.categoria );

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: (){
        // print('${ categoria.name }');
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric( horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == categoria.name  )
                ? Colors.red
                : Colors.black54,
        ),
      ),
    );
  }
}