import 'category.dart';
import 'items_model.dart';
import 'package:flutter/material.dart';


class AddItem extends StatefulWidget {
  final ViewModel model;
  final Category category;

  AddItem({Key key, this.model, this.category}) : super(key: key);
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController nameController;
  TextEditingController typeController;

  @override
  void initState() {
    nameController = TextEditingController();
    typeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Add a new ${widget.category.name} item"),
        ),
        body: Container(
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: "Company name",
                          border: OutlineInputBorder())),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                      controller: typeController,
                      decoration: InputDecoration(
                          hintText: "Serial no.",
                          border: OutlineInputBorder())),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                      controller: typeController,
                      decoration: InputDecoration(
                          hintText: "Model no.", border: OutlineInputBorder())),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                      controller: typeController,
                      decoration: InputDecoration(
                          hintText: "Year of Manufacturuing",
                          border: OutlineInputBorder())),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                      controller: typeController,
                      decoration: InputDecoration(
                          hintText: "Warranty date",
                          border: OutlineInputBorder())),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                      controller: typeController,
                      decoration: InputDecoration(
                          hintText: "Service date",
                          border: OutlineInputBorder())),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                      controller: typeController,
                      decoration: InputDecoration(
                          hintText: "Customer name",
                          border: OutlineInputBorder())),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Upload device image"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Save"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )),
        ));
  }

//  addItem(ItemType addItem) {}
}
