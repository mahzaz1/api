import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/UserModel.dart';

class Example3 extends StatelessWidget {
   Example3({Key? key}) : super(key: key);
  
  List<UserModel> userList =[];
  

  Future<List<UserModel>> getApi() async{

  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){

      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
    return userList;
    }
    else{
    return userList;

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example 3'),),
      body: FutureBuilder(
        future: getApi(),
        builder: (context,AsyncSnapshot<List<UserModel>> snapshot){

          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          else{

          return ListView.builder(
            itemCount: userList.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        ReuseableRow(
                          title: 'Name:',value: snapshot.data![index].name.toString(),),
                        ReuseableRow(
                          title: 'Email:',value: snapshot.data![index].email.toString(),),
                        ReuseableRow(
                          title: 'Username:',value: snapshot.data![index].username.toString(),),
                        ReuseableRow(
                          title: 'Address:',value: snapshot.data![index].address!.city.toString(),),
                        ReuseableRow(
                          title: 'Company:',value: snapshot.data![index].company!.name.toString(),),
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
      padding: const EdgeInsets.all(8.0),
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

