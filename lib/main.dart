import 'package:flutter/services.dart';
import 'package:gadjet_inventory/Form/ListTiles.dart';
import 'package:gadjet_inventory/Form/UploadData.dart';
import 'package:gadjet_inventory/item_details.dart';
import 'package:gadjet_inventory/sub_category_page.dart';
import 'add_category.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'items_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  registerAdapters();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ViewModel>(
          create: (context) => ViewModel(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/': (context) => MyHomePage(),

            //home: MyHomePage(),
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String item;
  ViewModel viewModel;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (viewModel == null) {
      viewModel = Provider.of<ViewModel>(context);
      viewModel.getAllCategories();
    }
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: new Text("Gadget Inventory",
              style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.folder_open,
                size: 36,
                color: Colors.white,
              ),
              onPressed: () {
                //debugPrint("Add New Device Cattegorry");
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ListTiles();
                })); //
              },
            )
          ],
        ),

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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SubCategoryPage(
                          subcategory: viewModel.categories[item],
                        ),
                      ),
                    );
                    /* Navigator.of(context).push(
                        MaterialPageRoute(
                          // this is navigaton to subcollection page.
                          builder: (context) => SubCategoryPage(
                            title: viewModel.categories[item].name,
                            subCategoryListLength: viewModel.categories[item].list.length,
                            subcategoryData: viewModel.categories[item],
                          ),
                        ),
                      );*/
                    //Navigate to the Page you have
                    /*  Navigator.of(context).push(
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
                          getIconData(viewModel.categories[item].iconName),
                          size: 90,
                        ),
                        SizedBox(height: 20),
                        Text(viewModel.categories[item].name,
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
          itemCount: viewModel.categories.length,
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
  "Mobile Accessories": Icons.headset,
  "Computers": Icons.computer,
  "Televisions": Icons.tv,
  "Large Appliances": Icons.local_laundry_service,
  "Kitchen Appliances": Icons.kitchen,
  "Home Appliances": Icons.home,
  "Home Entertainment Systems": Icons.devices_other,
  "Head Phones": Icons.headset_mic,
  "Cameras": Icons.photo_camera,
  "Speakers": Icons.speaker,
  "Camera Accessories": Icons.camera_roll,
};

class ItemModel {
  String item;
  IconData icon;
  Widget page;
  ItemModel({this.item, this.icon, this.page});
}
