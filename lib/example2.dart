import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Example2 extends StatelessWidget {
   Example2({Key? key}) : super(key: key);

  List<dynamic> list = [];

  Future getApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map i in data){
        Photos photos = Photos(title: i['title'],url: i['url']);
        list.add(photos);
      }
      return list;
    }else{
      return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Example 2'),),

      body: FutureBuilder(
        future: getApi(),
        builder: (context, snapshot){
          return ListView.builder(
            itemCount: list.length,
              itemBuilder: (context,index){
            return ListTile(

              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(list[index].url),),
              title: Text(list[index].title.toString()),
              trailing: Text('$index'),
            );
          });
        },
      ),
    );
  }
}


class Photos{
  String title,url;

  Photos({required this.title,required this.url});
}