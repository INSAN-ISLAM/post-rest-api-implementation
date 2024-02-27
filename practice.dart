import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class postApi extends StatefulWidget {
  postApi({Key? key}) : super(key: key);



  @override
  State<postApi> createState() => _postApiState();
}

class _postApiState extends State<postApi> {

  final TextEditingController ProductCodeETController = TextEditingController();
  final TextEditingController ProductNameETController = TextEditingController();
  final TextEditingController TotalPriceETController = TextEditingController();
  final TextEditingController UnitPriceETController = TextEditingController();
  final TextEditingController QtyETController = TextEditingController();
  final TextEditingController ImgETController = TextEditingController();
  final Client httpClient = Client();
  Future<void> AddProdToApi() async {

    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');
    Response response = await httpClient.post(uri,
      headers: {
        "Content-Type":"application/json",
      },
    body:jsonEncode({
      "Img":ImgETController.text,
      "ProductCode":ProductCodeETController.text,
      "ProductName":ProductNameETController.text,
      "Qty":QtyETController.text,
      "TotalPrice":TotalPriceETController.text,
      "UnitPrice":UnitPriceETController.text,
    },),

    );
    print(response.body);
    final responsejson=jsonDecode(response.body);
    if(responsejson['status']=='success'){
      ImgETController.clear();
      ProductCodeETController.clear();
      ProductNameETController.clear();
      QtyETController.clear();
      TotalPriceETController.clear();
      UnitPriceETController.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('add success')));

    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('add fail')));
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller:ProductCodeETController,
              decoration: InputDecoration(
                hintText: " ProductCode",
              ),
            ),
            TextFormField(
              controller: ProductNameETController,
              decoration: InputDecoration(
                  hintText: " ProductName",
              ),



            ),
            TextFormField(
              controller:TotalPriceETController ,
              decoration: InputDecoration(
                  hintText: " TotalPrice"
              ),



            ),

            TextFormField(
              controller: UnitPriceETController,
              decoration: InputDecoration(
                  hintText: " UnitPrice"
              ),



            ),
            TextFormField(
              controller: QtyETController,
              decoration: InputDecoration(
                  hintText: " Qty"
              ),



            ),
            TextFormField(
              controller:ImgETController,
              decoration: InputDecoration(
                  hintText: " Img"
              ),



            ),
            ElevatedButton(onPressed: (){
              AddProdToApi();
            }, child: Text("Submit"))
          ],

        ),
      ),

    );
  }
}
