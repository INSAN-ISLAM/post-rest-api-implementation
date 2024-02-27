import 'dart:convert';
import 'dart:html';

import 'package:assainment/practice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'karim.dart';



void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
    MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
  class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   final Client httpClient = Client();
   ProductModel productModel=ProductModel();
   bool  datainprogress=false;
  Future<void> getApi() async {
    datainprogress=true;
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct');
    Response response = await httpClient.get(uri);
    productModel= ProductModel.fromJson(jsonDecode(response.body));

    print( productModel.status);
    print( productModel.data?.length?? 0);
    datainprogress=false;
  setState(() {});


  }

@override
  void initState() {
    super.initState();
    getApi();
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          getApi();

        },
        child: datainprogress ? Center(
          child: CircularProgressIndicator(),
        )   :ListView.separated(
                itemCount: productModel.data?.length?? 0,
                addAutomaticKeepAlives: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
        return ListTile(
          title: Text(productModel.data?[index].productName ?? 'Unknown'),
          subtitle:Text('unitPrice: ${productModel.data?[index].unitPrice}'),
          trailing: Text('qty: ${productModel.data?[index].qty}'),
          leading:  CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage('${productModel.data?[index].img}'),
          ),
        );
        },


          separatorBuilder: (context, index) {
        return Divider(
          thickness: 2,
          height: 15,
          color: Colors.deepOrange,
        );
    },
        ),
      ),

floatingActionButton:FloatingActionButton(
  child:Icon(Icons.add) ,
  onPressed: (){

Navigator.push(context, MaterialPageRoute(builder: (context)=>postApi()));
  },

) ,

      );
  }
}
