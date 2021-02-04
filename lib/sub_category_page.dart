import 'package:flutter/material.dart';
import 'package:gadjet_inventory/Form/UploadData.dart';
import 'package:gadjet_inventory/add_subcategory.dart';
import 'package:gadjet_inventory/main.dart';

import 'package:gadjet_inventory/subitems_model.dart';
import 'subitems_model.dart';




import 'add_subcategory.dart';

class SubCategoryPage extends StatefulWidget {
  SubCategoryPage({Key key, this.subcategory}) : super(key: key);
  final subcategory;


 // const SubCategoryPage({Key key, this.title, this.subcategoryData, this.subCategoryListLength, Category category}) : super(key: key);
  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  ViewModel2 viewModel2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(widget.subcategory.name, style: TextStyle(fontSize: 20), textAlign: TextAlign.center),   actions: <Widget>[

          IconButton(icon: Icon(Icons.folder_open, size: 36, color: Colors.white,),
            onPressed: () {
              //debugPrint("Add New Device Cattegorry");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UploadData();
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
            itemBuilder: (context, subitem) {
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
                          Icon(
                            getIconData(viewModel2.subcategories[subitem].iconName),
                            size: 90,
                          ),
                          SizedBox(height: 20),
                          Text(viewModel2.subcategories[subitem].name,
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
          debugPrint("Add New Device Sub-Category");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddSubCategory(
              viewModel2: viewModel2,
            );
          })); //
        },
        tooltip: 'Add Device Sub-Cattegorry',
        child: Icon(Icons.add),
      ),


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






class SubItemModel {
  String subitem;
  IconData icon;
  Widget page;
  SubItemModel({this.subitem, this.icon, this.page});
}



