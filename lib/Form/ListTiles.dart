import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:gadjet_inventory/Form/MainHomeScreen.dart';


import 'package:gadjet_inventory/Form/Data.dart';


import 'package:gadjet_inventory/Form/UploadData.dart';
import 'package:gadjet_inventory/main.dart';
import 'package:pdf_flutter/pdf_flutter.dart';



import 'Data.dart';

import 'UploadData.dart';


// ignore: must_be_immutable
import 'package:url_launcher/url_launcher.dart';

class ListTiles extends StatefulWidget {
  @override
  _ListTilesState createState() => _ListTilesState();
}

class _ListTilesState extends State<ListTiles> {
  List<Data> dataList = [];
  List<bool> favList = [];
  bool searchState = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  String get data => null;

  get index => null;
  @override
  void initState() {

    super.initState();
    DatabaseReference referenceData = FirebaseDatabase.instance.reference().child("Data");
    referenceData.once().then((DataSnapshot dataSnapShot) {
      dataList.clear();
      favList.clear();

      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;

      for (var key in keys) {

        Data data = new Data(
            values [key]['imgUrl'],
            values [key]['wcimgUrl'],
            values [key]['ugimgUrl'],
            values [key]['wcpdfUrl'],
            values [key]['ugpdfUrl'],
            values [key]['cattegorrytype'],
            values [key]['companyname'],
            values [key]['modelname'],
            values [key]['seriesname'],
            values [key]['year'],
            values [key]['serielnumber'],
            values [key]['warrantydate'],

            values [key]['name'],
            values [key]['mobilenumber'],
            values [key]['address'],
            values [key]['website'],
            key
          //key is the uploadid
        );
        dataList.add(data);
        // auth.currentUser().then((value) {
        //   DatabaseReference reference = FirebaseDatabase.instance.reference().child("Data").child(key).child("Fav")
        //       .child(value.uid).child("state");
        //   reference.once().then((DataSnapshot snapShot){
        //     if(snapShot.value!=null){
        //       if(snapShot.value=="true"){
        //         favList.add(true);
        //       }else{
        //         favList.add(false);
        //       }
        //     }else{
        //       favList.add(false);
        //     }
        //   });
        // });

      }


      Timer(Duration(seconds: 1),(){
        setState(() {
          //
        });
      });


    });


  }



  @override
  Widget build(BuildContext context) {


    print("Showing Device Details");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: new Text("Devices Details", style:
        TextStyle(fontSize: 20), textAlign: TextAlign.center),

        actions: <Widget>[
          
          IconButton(icon: Icon(Icons.home, size: 36, color: Colors.white,),
            onPressed: () {
              //debugPrint("Add New Device Cattegorry");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyHomePage();
              }
              )
              ); //
            },
          )
        ],),

      body: Center(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.network(
                dataList[index].imgUrl != null
                    ? dataList[index].imgUrl
                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                width: 120,
                fit: BoxFit.fitWidth,



              ),

              title: Text(dataList[index].cattegorrytype),
              subtitle: Text(dataList[index].companyname),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>DetailView(dataList[index])));
              },
            );
          },
          itemCount: dataList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.black,
            );
          },
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return UploadData(

              );
            }),
          );
        },
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
      ),
    );
  }
}





