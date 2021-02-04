

import 'package:gadjet_inventory/Form/ListTiles.dart';
import 'package:gadjet_inventory/Form/UploadData.dart';
import 'package:gadjet_inventory/add_category.dart';
import 'package:gadjet_inventory/item.dart';
import 'package:gadjet_inventory/main.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'category.dart';
import 'items_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import 'add_category.dart';

class ItemDetailPage extends StatefulWidget {
  ItemDetailPage({Key key, this.category}) : super(key: key);
  final category;

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State< ItemDetailPage> {
  ViewModel viewModel;
  @override
  void initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(widget.category.name, style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
        actions: <Widget>[

          IconButton(icon: Icon(Icons.folder_open, size: 36, color: Colors.white,),
            onPressed: () {
              //debugPrint("Add New Device Cattegorry");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ListTiles();
              }
              )
              ); //
            },
          ),
          IconButton(icon: Icon(Icons.home, size: 36, color: Colors.white,),
            onPressed: () {
              //debugPrint("Add New Device Cattegorry");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyHomePage();
              }
              )
              ); //
            },
          ),
        ],),

      body: Center(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, item) {
              return Container(
                child: GestureDetector(
                    onTap: () {

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UploadData()));
                      //Navigate to the Page you have
                      /* Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ItemDetailPage(
                            category: viewModel.categories[item],
                          ),
                        ),
                      );*/
                    },


                    /* onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FirstRoute()),
                    );
                  },*/
                    child: Card(
                      elevation: 2,
                      margin: EdgeInsets.all(5.0),
                      //color: Colors.cyan[100],
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Icon(
                          //   getIconData(
                          //       // viewModel.categories[item].iconName
                          //     widget.category[item].iconName
                          //   ),
                          //   size: 90,
                          // ),
                          SizedBox(height: 20),
                          Text(
                              // viewModel.categories[item].name,
                           "add new",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    )),
              );
            },
            itemCount: 1,
            primary: false,
            padding: const EdgeInsets.all(20),
          )),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        mini: false,
        highlightElevation: 20.0,
        //shape: BeveledRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(16.0)) ),
        onPressed: () {
          debugPrint("Add New Device Category");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddCategory(

              viewModel: viewModel,
            );
          })); //
        },
        tooltip: 'Add Device Cattegorry',
        child: Icon(Icons.add),
      ),


      //

    );
  }

  getIconData(String iconName) {
    try {
      return iconData[iconData.keys.firstWhere((key) => key == iconName)];
    } catch (e) {
      return Icons.star;
    }
  }
}



Map<String, IconData> iconData = {

  "Mobiles": Icons.smartphone,
  "Mobile Accessories" : Icons.headset,
  "Computers": Icons.computer,
  "Televisions": Icons.tv,
  "Large Appliances" : Icons.local_laundry_service,
  "Kitchen Appliances" :Icons.kitchen,
  "Home Appliances" : Icons.home,
  "Home Entertainment Systems" : Icons.devices_other,
  "Head Phones" : Icons.headset_mic,
  "Cameras" : Icons.photo_camera,
  "Speakers" : Icons.speaker,
  "Camera Accessories" : Icons.camera_roll,

};






class ItemModel {
  String item;
  IconData icon;
  Widget page;
  ItemModel({this.item, this.icon, this.page});
}
