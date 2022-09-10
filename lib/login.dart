import 'package:flutter/material.dart';

class Login extends StatelessWidget {
   Login({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post Api'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email'
              ),
            ),
            SizedBox(height: 20,),

            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'password'
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50)
              ),
              child: Center(child: Text('Signup',style: TextStyle(color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }
}
