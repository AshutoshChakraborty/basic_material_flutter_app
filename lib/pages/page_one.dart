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
            if (snapShot.hasData) {
              List<Collections> list = snapShot.data.collections;
              return myListView(list);
            } else if (snapShot.hasError) {
              return Text("${snapShot.data}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 90.0,
                      width: 90.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "https://www.travelogyindia.com/images/kolkata/victoria-memorial-kolkata.jpg"))),
                    ),
                  ),
                Align(alignment: Alignment.topCenter,child: Padding(
                  padding: const EdgeInsets.only(top: 35,left: 16),
                  child: Text("User Profile",textScaleFactor: 1.5,style: TextStyle(
                   color: Colors.white 
                  ),),
                ))
                ],
              ),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            ListTile(
              title: Text("Option 1"),
              leading: Icon(Icons.person),
            ),
            Divider(
              height: 1,
              color:Colors.grey,
            ),
             ListTile(
              title: Text("Option 2"),
              leading: Icon(Icons.person_pin),
            ),
             Divider(
              height: 1,
              color:Colors.grey,
            ),
             ListTile(
              title: Text("Option 3"),
              leading: Icon(Icons.pets),
            )
          ],
        ),
      ),
    );
  }

  Widget myListView(List<Collections> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
          child: myCard(list, index),
        );
      },
    );
  }

  Card myCard(List<Collections> list, int index) {
    return Card(
      child: Stack(
        children: <Widget>[
          Align(
            child: Image.network(list[index].collection.imageUrl),
            alignment: AlignmentDirectional.center,
          ),
          Align(
            child: Stack(
              children: <Widget>[
                Align(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          color: Colors.black,
                          height: 45,
                          child: Text(""),
                        ),
                      )),
                    ],
                  ),
                  alignment: AlignmentDirectional.bottomStart,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      list[index].collection.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            alignment: AlignmentDirectional.bottomStart,
          )
        ],
      ),
    );
  }
}

Future<CollectionResponse> getCollectionResponse() async {
  String url =
      "https://developers.zomato.com/api/v2.1/collections?city_id=2&count=30";
  final response = await http
      .post(url, headers: {"user-key": "8a13280873a0f21dffaee2b028dee19a"});
  if (response.statusCode == 200) {
    return CollectionResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}
