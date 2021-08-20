import 'package:flutter/material.dart';
import 'package:search_delegate/api/api.dart';

class CitySearch extends SearchDelegate<String> {
  final cities = [
    'Berlin',
    'Bekasi',
    'Jakarta',
    'Bandung',
    'Surabaya',
  ];

  final recentCity = [
    'Berlin',
    'Bekasi',
    'Jakarta',
    'Bandung',
    'Surabaya',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isEmpty
          ? SizedBox()
          : IconButton(
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
              icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_city),
          Text(
            query,
            style: TextStyle(
              color: Colors.black,
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text('Start Searching'),
      );
    }
    return FutureBuilder(
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError || snapshot.data!.isEmpty) {
            return Center(child: Text("Error occur"));
          }

          final suggestions = query.isEmpty
              ? recentCity
              : snapshot.data!.where((city) {
                  final queryLowerCase = query.toLowerCase();
                  final cityLowerCase = city.toLowerCase();

                  return cityLowerCase.contains(queryLowerCase);
                }).toList();

          return ListView.builder(
            itemBuilder: (context, idx) {
              final suggestion = suggestions[idx];

              final samePart = suggestion.substring(0, query.length);
              final remainingText = suggestion.substring(query.length);

              return ListTile(
                onTap: () {
                  query = suggestion;
                  showResults(context);
                },
                // title: Text(suggestion),
                title: RichText(
                  text: TextSpan(
                    text: samePart,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    children: [
                      TextSpan(
                        text: remainingText,
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      )
                    ],
                  ),
                ),
                leading: Icon(Icons.history),
              );
            },
            itemCount: suggestions.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: Api.searchCities(query: query),
    );
  }
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   final suggestions = query.isEmpty
  //       ? recentCity
  //       : recentCity.where((city) {
  //           final queryLowerCase = query.toLowerCase();
  //           final cityLowerCase = city.toLowerCase();

  //           return cityLowerCase.startsWith(queryLowerCase);
  //         }).toList();

  //   return ListView.builder(
  //     itemBuilder: (context, idx) {
  //       final suggestion = suggestions[idx];

  //       final samePart = suggestion.substring(0, query.length);
  //       final remainingText = suggestion.substring(query.length);

  //       return ListTile(
  //         onTap: () {
  //           query = suggestion;
  //           showResults(context);
  //         },
  //         // title: Text(suggestion),
  //         title: RichText(
  //           text: TextSpan(
  //             text: samePart,
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //               fontSize: 18,
  //             ),
  //             children: [
  //               TextSpan(
  //                 text: remainingText,
  //                 style: TextStyle(color: Colors.grey, fontSize: 18),
  //               )
  //             ],
  //           ),
  //         ),
  //         leading: Icon(Icons.history),
  //       );
  //     },
  //     itemCount: suggestions.length,
  //   );
  // }
}
