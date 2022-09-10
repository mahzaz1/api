import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/PostModel.dart';
import 'dart:convert';

class Example1 extends StatelessWidget {
   Example1({Key? key}) : super(key: key);

  List<PostModel> list = [];

  Future<List<PostModel>> getPostModel () async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      list.clear();

      for(Map i in data){
        list.add(PostModel.fromJson(i));
      }
      return list;
    }else{
      return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example 1'),),
      body: FutureBuilder(
        future: getPostModel(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }else {
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      color: Colors.grey.shade200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Title:',style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(list[index].title.toString()),

                            SizedBox(height: 20,),
                            Text('Description:',style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(list[index].body.toString()),

                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          }
        },
      ),
    );
  }
}
