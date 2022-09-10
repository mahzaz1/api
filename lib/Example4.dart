import 'dart:convert';

// Without Model for urgent work but not a good way

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Example4 extends StatelessWidget {
   Example4({Key? key}) : super(key: key);

   var data;
   Future<void> getApi() async{

  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if(response.statusCode == 200){
    data = jsonDecode(response.body.toString());
  }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example 4'),),
      body:  FutureBuilder(
        future: getApi(),
        builder: (context, snapshot){

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else{

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(elevation: 10,
                      child: Column(
                        children: [

                          ReuseableRow(title: 'Name:',value: data[index]['name'].toString(),),
                          ReuseableRow(title: 'User Name:',value: data[index]['username'].toString(),),
                          ReuseableRow(title: 'Email:',value: data[index]['email'].toString(),),
                          ReuseableRow(title: 'Address:',value: data[index]['address']['city'].toString(),),
                          ReuseableRow(title: 'Company:',value: data[index]['company']['name'].toString(),)

                        ],
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


class ReuseableRow extends StatelessWidget {
  ReuseableRow({
    Key? key,
    required this.title,
    required this.value
  }) : super(key: key);

  String title,value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),

        ],
      ),
    );
  }
}