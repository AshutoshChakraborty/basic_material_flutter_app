import 'dart:convert';

import 'package:basic_material_flutter_app/response/Response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page One"),
      ),
      body: Center(
        child: FutureBuilder<CollectionResponse>(
          future: getCollectionResponse(),
          builder: (context, snapShot) {
            if(snapShot.hasData) {
              return Text(snapShot.data.shareUrl);
            }else if (snapShot.hasError) {
              return Text("${snapShot.data}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<CollectionResponse> getCollectionResponse() async {
  String url =
      "https://developers.zomato.com/api/v2.1/collections?city_id=2&count=3";
  final response = await http
      .post(url, headers: {"user-key": "8a13280873a0f21dffaee2b028dee19a"});
  if (response.statusCode == 200) {
    return CollectionResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}
