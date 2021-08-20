import 'package:flutter/material.dart';
import 'package:search_delegate/city_search.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CitySearch());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
