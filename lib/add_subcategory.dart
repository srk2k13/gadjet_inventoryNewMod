// Pages [NOTE]: You can use one page fpr all of them and pass the item to that page

import 'package:gadjet_inventory/subcategory.dart';

import 'subcategory.dart';
import'subitems_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'main.dart';


class AddSubCategory extends StatefulWidget {
  ViewModel2 viewModel2;
  AddSubCategory({Key key, this.viewModel2}) : super(key: key);
  @override
  _AddSubCategoryState createState() => _AddSubCategoryState();
}

class _AddSubCategoryState extends State<AddSubCategory> {
  TextEditingController controller;
  String dropdownValue;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add New SubCategory"),
        ),
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.all(20),
            child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                              hintText: "Enter New Subcategory",
                              border: OutlineInputBorder())),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(
                            Icons.arrow_downward,
                            size: 16,
                          ),
                          isExpanded: true,
                          iconSize: 12,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.lightBlueAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: iconData.keys
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            if (controller.text.isNotEmpty ||
                                dropdownValue == null) {
                              setState(() {
                                var subcategory = SubCategory()
                                  ..id = Uuid().toString()
                                  ..name = controller.text.trim()
                                  ..iconName = dropdownValue.toString()
                                  ..list = List();
                                widget.viewModel2.addSubCategory(subcategory);
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Add"),
                        ))
                  ],
                ))));
  }
}
