import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/ProductModel.dart';

class Example5 extends StatefulWidget {
  const Example5({Key? key}) : super(key: key);

  @override
  State<Example5> createState() => _Example5State();
}

class _Example5State extends State<Example5> {

  Future<ProductsModel> getApi () async {

    final response = await http.get(Uri.parse('https://webhook.site/1bbba077-c22f-41ac-bd17-0ffb41b41533'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return ProductsModel.fromJson(data);
    }else {
      return ProductsModel.fromJson(data);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example 5'),),
      body: FutureBuilder<ProductsModel>(
        future: getApi(),
        builder: (context,AsyncSnapshot<ProductsModel> snapshot){
          if(!snapshot.hasData){
            return Text("Loading");
          }else{
            return ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context,index){
                  return Text(snapshot.data!.data![index].products.toString());
                });
          }
        }
      ),
    );
  }
}



