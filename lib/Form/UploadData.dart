import 'dart:collection';
import 'dart:io';



import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:gadjet_inventory/Form/Data.dart';
import 'package:gadjet_inventory/Form/MainHomeScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

import 'package:gadjet_inventory/Form/ListTiles.dart';
import 'package:gadjet_inventory/main.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

import 'package:firebase_auth/firebase_auth.dart';


void main() async {



  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => UploadData(),

          //home: MyHomePage(),
        });
  }

}



class UploadData extends StatefulWidget {

  final Data data;

  UploadData([this.data]);
  @override
  _UploadDataState createState() => _UploadDataState();
  }

class _UploadDataState extends State<UploadData> {

  FirebaseAuth auth =FirebaseAuth.instance;
    TextEditingController textEditingController = new TextEditingController();


    // await Future.delayed(Duration(seconds: 1), () {});



var _todoDateController = TextEditingController();
  DateTime _dateTime = DateTime.now();

  get dataList => null;
 // DateTime _endDate = DateTime.now().add(Duration(days: 7));

 _selectedtodoDate(BuildContext context) async {
   var _pickedDate = await showDatePicker (

     context:context,
     initialDate:  _dateTime,
      firstDate:DateTime(2015),
      lastDate:DateTime(2100) );
     if (_pickedDate != null)
       {
         setState(( )
         {
           _dateTime = _pickedDate;
           _todoDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);


             });
       }
}
  bool _inProcess = false;
  File imageFile;
  String imgUrl;
  File imageFile2;
  String wcimgUrl;
  File imageFile3;
  String ugimgUrl;
  File PDfFile1;
  String wcpdfUrl;
  File PDfFile2;
  String ugpdfUrl;
  var formKey = GlobalKey<FormState>();
  String cattegorrytype,companyname,modelname ,seriesname,year,serielnumber,warrantydate,name,mobilenumber,address,website ;
  int selectedRadioTile;
  String get data => null;

  get index => null;
  String get path => null;

  String get title => null;

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }
  String _downloadPDFUrl;
  String _downloadPDFUrl2;
  String _downloadUrl;
  String _downloadUrl2;
  String _downloadUrl3;
  bool _uploaded= false;
  bool _uploaded2= false;
  bool _uploaded3= false;

  bool isPDF_selected2=false;
  bool isimage_selected2 = false;
  bool isimage_selected3 = false;
  bool  _PDF2Downloaded =false;
  bool _PDFUploaded2=false;



  bool isPDF_selected=false;
  bool  _PDF1Downloaded =false;

  bool isimage_selected = false;


  bool image_show_containervisible = false;
  String fileType = '';
  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;


  bool _PDFUploaded=false;





  /*Widget  _buildPDF1Field() {
    return Column(
      children: <Widget>[


        PDfFile1 != null && wcpdfUrl == null
            ? PDF.file(
          PDfFile1,
          height: 300,
          width: 200,


        )
            : PDfFile1 == null && wcpdfUrl == null
            ?
        RaisedButton(
            onPressed: () => _getLocalImage4(),
            child: Icon(Icons.picture_as_pdf, size: 80,
              color: Colors.red,)
        )

            :
        SizedBox(height: 0),

        SizedBox(height: 10,),
      ],


    );

  }*/


  /*Widget  _buildPDF2Field() {
    return Column(
      children: <Widget>[


        PDfFile2 != null && ugpdfUrl == null
            ? PDF.file(
          PDfFile2,
          height: 300,
          width: 200,

        )
            : PDfFile2 == null && ugpdfUrl == null
            ?
        RaisedButton(
            onPressed: () => _getLocalImage4(),
            child: Icon(Icons.picture_as_pdf, size: 80,
              color: Colors.red,)
        )

            :
        SizedBox(height: 0),

        SizedBox(height: 10,),
      ],


    );

  }*/

  Future <void> getWCImage(BuildContext context, ImageSource source) async {
    if (source != null) {
      File image2  = await ImagePicker.pickImage(source: source, imageQuality: 50, maxHeight: 1920, maxWidth: 1080);


      if (image2  != null) {
        setState(() {
          imageFile2=image2;

        //  print('compressedimagesize: ${imageFile2.lengthSync()}');
          isimage_selected2 = true;
          image_show_containervisible = true;
        });
      }

    }
   // Navigator.pop(context);
  }

  Future <void> getCamWCImage(BuildContext context, ImageSource source) async {
    if (source != null) {
      File image2  = await ImagePicker.pickImage(source: source,imageQuality: 50,  maxHeight: 1920, maxWidth: 1080);


      if (image2  != null) {
        setState(() {
          imageFile2 = image2;
        //  print('compressedimagesize: ${imageFile2.lengthSync()}');
          isimage_selected2 = true;
          image_show_containervisible = true;
        });
      }

    }
    // Navigator.pop(context);
  }

  void openWCImagePickerModal(BuildContext context) async {
    final flatButtonColor = Theme
        .of(context)
        .primaryColor;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 180.0,
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Pick An Image',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 15.0,
                ),
                FlatButton(
                  child: Text("Chose Image from Camera"),

                  onPressed: () {

                    getCamWCImage(context,ImageSource.camera);
                    Navigator.of(context).pop();
                    /* Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CameraScreen()));*/
                  },


                  color: Colors.green,
                  textColor: Colors.white,

                ),
                FlatButton(
                  child: Text("Chose Image From Gallery"),
                  onPressed: () {
                    getWCImage(context,ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  color: Colors.green,
                  textColor: Colors.white,

                ),
              ],
            ),
          );
        });
    // Navigator.of(context).pop(true);
  }

  Future <void> getUGImage(BuildContext context, ImageSource source) async {
    if (source != null) {
      File image3  = await ImagePicker.pickImage(source: source,imageQuality: 50,  maxHeight: 1920, maxWidth: 1080);


      if (image3  != null) {
        setState(() {
          imageFile3 = image3;
        //  print('compressedimagesize: ${imageFile3.lengthSync()}');
          isimage_selected3 = true;
          image_show_containervisible = true;
        });
      }

    }
  //  Navigator.pop(context);
  }

  Future <void> getCamUGImage(BuildContext context, ImageSource source) async {
    if (source != null) {
      final image3  = await ImagePicker.pickImage(source: source,imageQuality: 50,  maxHeight: 1920, maxWidth: 1080);


      if (image3  != null) {
        setState(() {
          imageFile3 = image3;
          print('compressedimagesize: ${imageFile3.lengthSync()}');
          isimage_selected3 = true;
          image_show_containervisible = true;
        });
      }

    }
    //  Navigator.pop(context);
  }

  void openUGImagePickerModal(BuildContext context) async {
    final flatButtonColor = Theme
        .of(context)
        .primaryColor;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 180.0,
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Pick An Image',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 15.0,
                ),
                FlatButton(
                  child: Text("Chose Image from Camera"),
                  onPressed: () {

                    getCamUGImage(context,ImageSource.camera);
                    Navigator.of(context).pop();
                    /* Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CameraScreen()));*/
                  },


                  color: Colors.green,
                  textColor: Colors.white,

                ),
                FlatButton(
                  child: Text("Chose Image From Gallery"),
                  onPressed: () {
                    getUGImage(context,ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  color: Colors.green,
                  textColor: Colors.white,

                ),
              ],
            ),
          );
        });
    // Navigator.of(context).pop(true);
  }

/*  _showImage4() {
    if (PDfFile1 == null &&  wcpdfUrl == null) {
      return Text("PDF placeholder");
    } else if (PDfFile1 != null) {
      print('showing pdf from local file');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          PDF.file(
            PDfFile1,
            height: 600,
            width: MediaQuery.of(context).size.width * 0.90,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change PDF',
              style: TextStyle(color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage4(),
          )
        ],
      );
    } else if (wcpdfUrl != null) {
      print('showing PDF from url');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          /*Image.network(
            _imageUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            height: 150,
          ),*/
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change PDF',
              style: TextStyle(color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage4(),
          )
        ],
      );
    }
  }*/

  _getLocalImage4() async {
    File pickedFile = await FilePicker.getFile(
        allowedExtensions: ['pdf'], type: FileType.custom);

    /*  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://upload-image-7c0f4/storage/upload-image-7c0f4.appspot.com');
    String PDFPath = 'DeviceDocs/DeviceDocs${DateTime.now()}.pdf';
    final StorageReference  _storagepdf1reference   = FirebaseStorage().ref().child(PDFPath);



    StorageUploadTask uploadTask = _storagepdf1reference.putFile(PDfFile1);
    StorageTaskSnapshot downloadPDFUrl = (await uploadTask.onComplete);
       String url4 = (await downloadPDFUrl.ref.getDownloadURL());


    var _imageUrl4 = await (await uploadTask.onComplete).ref.getDownloadURL();
  //  String url4 = _imageUrl4.toString();*/


    setState(() {
      //  _uploadTask = _storage.ref().child(PDFPath).putFile(PDfFile1);
      PDfFile1 = pickedFile;
    });
  }




  /*_showImage5() {
    if (PDfFile2 == null &&  ugpdfUrl == null) {
      return Text("PDF placeholder");
    } else if (PDfFile2 != null) {
      print('showing pdf from local file');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          PDF.file(
            PDfFile2,
            height: 600,
            width: MediaQuery.of(context).size.width * 0.90,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change PDF',
              style: TextStyle(color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage5(),
          )
        ],
      );
    } else if (ugpdfUrl != null) {
      print('showing PDF from url');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          /*Image.network(
            _imageUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            height: 150,
          ),*/
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change PDF',
              style: TextStyle(color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage5(),
          )
        ],
      );
    }
  }*/

  _getLocalImage5() async {
    File pickedFile = await FilePicker.getFile(allowedExtensions: ['pdf'], type: FileType.custom);
    /*  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://upload-image-7c0f4/storage/upload-image-7c0f4.appspot.com');
    String PDFPath2 = 'DeviceDocs/DeviceDocs${DateTime.now()}.pdf';
    final StorageReference  _storagepdf1reference   = FirebaseStorage().ref().child(PDFPath2);



    StorageUploadTask uploadTask = _storagepdf1reference.putFile(PDfFile2);
    StorageTaskSnapshot downloadPDFUrl = (await uploadTask.onComplete);
       String url5 = (await downloadPDFUrl.ref.getDownloadURL());


    var _imageUrl5 = await (await uploadTask.onComplete).ref.getDownloadURL();*/
    // String url5 = _imageUrl5.toString();
    setState(() {
      //  _uploadTask = _storage.ref().child(PDFPath2).putFile(PDfFile2);
      PDfFile2 = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        //backgroundColor: Colors.white,

      backgroundColor: Color(0xffffffff),
      appBar: AppBar( centerTitle: true,
        backgroundColor: Colors.blue,
        title: new Text("Device Details", style:
        TextStyle(fontSize: 20), textAlign: TextAlign.center),

        actions: <Widget>[
          IconButton(icon: Icon(Icons.folder_open, size: 36, color: Colors.white,),
            onPressed: () {
              //debugPrint("Add New Device Cattegorry");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MainHomeScreen();
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
          )
        ],),
      body: SingleChildScrollView(
        child: Center(
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                  SizedBox(height: 20,),


    Padding(padding: EdgeInsets.only(top: 15)),
              Container(
                child: imageFile==null?
                FlatButton(
                    onPressed: (){
                      openImagePickerModal(context);
                    },
                    child: Icon(Icons.add_a_photo,size: 80,color: Colors.blueGrey,)
                ):
                Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                  height: 250,
                ),

              ),

              SizedBox(height: 10,),


      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.blue,
                      ),
                      child: TextFormField(
                        validator: (value){
                          if(value.isEmpty){
                            return "Please write the Cattegorry Type of production";
                          }else {
                            cattegorrytype = value;
                          }
                        },

                        keyboardType: TextInputType.name,
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Cattegorry Type',
                          hintText: 'Enter the Cattegorry name',
                        ),
                        maxLength: 15,


                      ),
                    ),
                  ),
                  ),
        ],
      ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: TextFormField(
                        validator: (value){
                          if(value.isEmpty){
                            return "Please write the Company Name of production";
                          }else {
                            companyname = value;
                          }
                        },

                        keyboardType: TextInputType.name,
                        autofocus: false,
                          style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Company Name',
                          hintText: 'Enter the Company Name',
                        ),
                        maxLength: 15,


                        ),

                      ),
                  ),
                  ),




                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                      child: TextFormField(
                        validator: (value){
                          if(value.isEmpty){
                            return "Please write the Model  Name of production";
                          }else {
                            modelname = value;
                          }
                        },

                        keyboardType: TextInputType.name,
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Model  Name',
                          hintText: 'Enter the Model Name',
                        ),
                        maxLength: 15,


                      ),

                      ),
                    ),
                  ),

        ],
      ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: TextFormField(
                          validator: (value){
                            if(value.isEmpty){
                              return "Please write the Series Name of production";
                            }else {
                              seriesname = value;
                            }
                          },

                          keyboardType: TextInputType.name,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Series Name',
                            hintText: 'Enter the Series Name',
                          ),
                          maxLength: 15,


                        ),

                      ),
                    ),
                  ),



                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: TextFormField(
                          validator: (value){
                            if(value.isEmpty){
                              return "Please write the Year of MFG of production";
                            }else {
                              year = value;
                            }
                          },

                          keyboardType: TextInputType.number,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Year of MFG ',
                            hintText: 'Enter the Year of MFG',
                          ),
                          maxLength: 4,


                        ),

                      ),
                    ),
                  ),

        ],
      ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: TextFormField(
                          validator: (value){
                            if(value.isEmpty){
                              return "Please write the Seriel Number of production";
                            }else {
                              serielnumber = value;
                            }
                          },

                          keyboardType: TextInputType.number,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Seriel Number',
                            hintText: 'Enter the Seriel Number',
                          ),
                          maxLength: 15,


                        ),

                      ),
                    ),
                  ),





                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: TextFormField(
                            controller: _todoDateController,
                          validator: (value){
                            if(value.isEmpty){
                              return "Please write the Warranty Date of production";
                            }else {
                              warrantydate = value;
                            }
                          },


                          autofocus: false,
                            decoration: InputDecoration(
                                labelText:'Warranty Date',
                                hintText: 'Pick a Date',
                                prefixIcon: InkWell(

                                  onTap:(){
                                    _selectedtodoDate(context);

                                  },
                                  child:Icon(Icons.calendar_today),
                                )
                            )

                        ),

                      ),
                    ),
                  ),

                      ],
                    ),




          SizedBox(height: 10,),
                    RaisedButton(

                       onPressed: () {
                        Fluttertoast.showToast(
                          msg: "Enter Service Centre Details",
                          gravity: ToastGravity.CENTER,
                          toastLength: Toast.LENGTH_LONG,
                          // timeInSecForIosWeb: 2
                        );

                        //  _startWCUpload();

                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      color: Colors.blue,
                      child: Text("Service Centre Details",
                        style: TextStyle(fontSize: 18, color: Colors.white),),
                    ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Theme(
                              data: ThemeData(
                                hintColor: Colors.blue,
                              ),

                              child: TextFormField(
                                validator: (value){
                                  if(value.isEmpty){
                                    return "Please write the Name of production";
                                  }else {
                                    name = value;
                                  }
                                },

                                keyboardType: TextInputType.name,
                                autofocus: false,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  hintText: 'Enter the Name',
                                ),
                                maxLength: 15,


                              ),

                            ),
                          ),
                        ),







                    Expanded(
                        flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: TextFormField(
                          validator: (value){
                            if(value.isEmpty){
                              return "Please write the Mobile Number of production";
                            }else {
                              mobilenumber = value;
                            }
                          },

                          keyboardType: TextInputType.number,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            hintText: 'Enter the Mobile Number',
                        ),
                          maxLength: 10,


                        ),

                      ),
                    ),
                  ),

                          ],
                        ),




                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                    Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(
                          hintColor: Colors.blue,
                        ),

                        child: TextFormField(
                          validator: (value){
                            if(value.isEmpty){
                              return "Please write the Address of production";
                            }else {
                              address = value;
                            }
                          },

                          keyboardType: TextInputType.name,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: ' Address ',
                            hintText: 'Enter the Address',
                          ),
                          maxLength: 15,


                        ),

                      ),
                    ),
                  ),






    Expanded(
    flex: 1,
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Theme(
    data: ThemeData(
    hintColor: Colors.blue,
    ),
                      child: TextFormField(
                        validator: (value){
                          if(value.isEmpty){
                            return "Please write the Company Website of production";
                          }else {
                            website = value;
                          }
                        },

                        keyboardType: TextInputType.name,
                        autofocus: false,
                        controller: textEditingController,
                        decoration: InputDecoration(
                          labelText: ' Company Website ',
                          hintText: 'Enter the Company Website',
                          prefixIcon: IconButton(
                            onPressed: () async {
                              if(textEditingController.text.toString() == null || textEditingController.text.toString() == ""){
                                print("null data");
                              }else{
                                print(textEditingController.text.toString());
                                if (await canLaunch("https://" + textEditingController.text.toString())) {
                                  await launch("https://" + textEditingController.text.toString());
                                } else {
                                  throw 'Could not launch ${textEditingController.text.toString()}';
                                }
                              }
                            },
                            icon: Icon(Icons.open_in_browser),
                          ),
                        ),
                        maxLength: 15,
                      ),
                  ),
                ),
              ),


                  SizedBox(width: 5,),






        ],
      ),

                    RaisedButton(

                     /* onPressed: () {
                        Fluttertoast.showToast(
                          msg: "Upload Warranty Card",
                          gravity: ToastGravity.CENTER,
                          toastLength: Toast.LENGTH_LONG,
                          // timeInSecForIosWeb: 2
                        );

                        //  _startWCUpload();

                      },*/
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      color: Colors.blue,
                      child: Text("Warranty Card",
                        style: TextStyle(fontSize: 18, color: Colors.white),),
                    ),
                    RadioListTile(
                      value: 1,
                      groupValue: selectedRadioTile,
                      title: Text("PDF",style: TextStyle(color: Colors.black),)
                      //subtitle: Text("Upload PDF File"),
                      /*  onChanged: (val) {
                        filePicker(context);
                      },*/



                    ),


                    Padding(padding: EdgeInsets.only(top: 15)),

                  //  _showImage4(),
                    SizedBox(height: 16),

                   // _buildPDF1Field(),


                   PDfFile1 != null && wcpdfUrl == null
                        ? PDF.file(
                      PDfFile1,
                      height: 300,
                      width: 200,
                      placeHolder: Image.asset("assets/images/pdf.png",
                          height: 200, width: 100),
                    )
                        : PDfFile1 == null && wcpdfUrl == null
                        ?
                      RaisedButton(
                          onPressed: () => _getLocalImage4(),
                          child: Icon(Icons.picture_as_pdf, size: 80,
                            color: Colors.red,)
                      )

                        :
                    SizedBox(height: 0),

                    SizedBox(height: 10,),









                    RadioListTile(
                      value: 2,
                      groupValue: selectedRadioTile,
                      title: Text("Image",style: TextStyle(color: Colors.black),)
                      //subtitle: Text("Upload W Card Image"),
                      /* onChanged: (val) {
                        openWCImagePickerModal(context);
                        //_startWCUpload();
                      },*/



                    ),

                    Padding(padding: EdgeInsets.only(top: 15)),

                    //  _showImage2(),
                    SizedBox(height: 16),

                    Container(

                      child: imageFile2 == null && wcimgUrl == null
                          ?
                      FlatButton(
                          onPressed: (){
                            openWCImagePickerModal(context);
                          },
                          child: Icon(Icons.add_a_photo,size: 80,color: Colors.blueGrey,)
                      ):
                      Image.file(
                        imageFile2,
                        fit: BoxFit.cover,
                        height: 250,
                      ),


                    ),









                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(top: 15)),

                    RaisedButton(

                   /*   onPressed: () {
                        Fluttertoast.showToast(
                          msg: "Upload User Guide",
                          gravity: ToastGravity.CENTER,
                          toastLength: Toast.LENGTH_LONG,
                          // timeInSecForIosWeb: 2
                        );

                        // startUpload();

                      },*/
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // color: Color(0xffff2fc3),
                      color: Colors.blue,
                      child: Text("User Guide",
                        style: TextStyle(fontSize: 18, color: Colors.white),),
                    ),
                    RadioListTile(
                      value: 1,
                      groupValue: selectedRadioTile,
                      title: Text("PDF",style: TextStyle(color: Colors.black),)
                      //subtitle: Text("Upload PDF File"),
                      /* onChanged: (val) {
                      filePicker2(context);
                    },*/


                    ),
                    Padding(padding: EdgeInsets.only(top: 15)),
                  //  _showImage5(),


                    //_buildPDF2Field(),


                    PDfFile2 != null && ugpdfUrl == null
                        ? PDF.file(
                      PDfFile2,
                      height: 300,
                      width: 200,
                      placeHolder: Image.asset("assets/images/pdf.png",
                          height: 200, width: 100),
                    )
                        : PDfFile2 == null && ugpdfUrl == null
                        ?
                      RaisedButton(
                          onPressed: () => _getLocalImage5(),
                          child: Icon(Icons.picture_as_pdf, size: 80,

                            color: Colors.red,)
                      ):

                    SizedBox(height: 0),

                    SizedBox(height: 10,),













                    RadioListTile(
                      value: 2,
                      groupValue: selectedRadioTile,
                      title: Text("Image",style: TextStyle(color: Colors.black),)
                      //subtitle: Text("Upload W Card Image"),
                      /*  onChanged: (val) {
                        openUGImagePickerModal(context);
                        //_startUGUpload();
                      },*/


                    ),

                    Padding(padding: EdgeInsets.only(top: 15)),

                    //_showImage3(),
                    SizedBox(height: 16),
                    Container(

                      child: imageFile3 == null && ugimgUrl == null
                          ?
                      FlatButton(
                          onPressed: (){
                            openUGImagePickerModal(context);
                          },
                          child: Icon(Icons.add_a_photo,size: 80,color: Colors.blueGrey,)
                      ):
                      Image.file(
                        imageFile3,
                        fit: BoxFit.cover,
                        height: 250,
                      ),



                    ),




                    SizedBox(height: 10,),






                    RaisedButton(
                onPressed: (){

                  if(imageFile == null){
                    Fluttertoast.showToast(
                        msg: "Please select Device image",
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIos: 2
                    );

                  } else

                  if (imageFile2 == null && PDfFile1 == null){
                    Fluttertoast.showToast(
                        msg: "Please select an Warranty card Image",
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIos: 2
                    );

                  }
                     else
                  if (imageFile3 == null && PDfFile2 == null){
                    Fluttertoast.showToast(
                        msg: "Please select User Guide Document",
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIos: 2
                    );

                  } else {


                    upload();
                    Fluttertoast.showToast(
                        msg: "Data Uploaded Successfully",
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIos: 2
                    );


                      auth.currentUser().then((value) {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (BuildContext context) => ListTiles()));
                      });
                    }


                  },


                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.blue,
                child: Text("Upload Data",style: TextStyle(fontSize: 18,color: Colors.white),),
              )


                  ],
                ),
            ),
        ),
      ),



    );

  }





  Future <void> openGallery(BuildContext context, ImageSource source) async {
    if (source != null) {
      File image1  = await ImagePicker.pickImage(source: source, imageQuality: 50, maxHeight: 1920, maxWidth: 1080);


        setState(() {
          imageFile = image1;
          print(imageFile.lengthSync());
       //   print('compressedimagesize: ${imageFile.lengthSync()}');
          isimage_selected = true;
          image_show_containervisible = true;
        });


    }
    // Navigator.pop(context);
  }

  Future <void> openCamera(BuildContext context, ImageSource source) async {
    if (source != null) {
      File image1  = await ImagePicker.pickImage(source: source, imageQuality: 50, maxHeight: 1920, maxWidth: 1080);



        setState(() {
          imageFile = image1;
          print(imageFile.lengthSync());
          //   print('compressedimagesize: ${imageFile.lengthSync()}');
          isimage_selected = true;
          image_show_containervisible = true;
        });


    }
    // Navigator.pop(context);
  }

  void openImagePickerModal(BuildContext context) async {
    final flatButtonColor = Theme
        .of(context)
        .primaryColor;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 180.0,
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Pick An Image',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 15.0,
                ),
                FlatButton(
                  child: Text("Chose Image from Camera"),

                  onPressed: () {

                    openCamera(context, ImageSource.camera);
                    Navigator.of(context).pop();
                    /* Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CameraScreen()));*/
                  },


                  color: Colors.green,
                  textColor: Colors.white,

                ),
                FlatButton(
                  child: Text("Chose Image From Gallery"),
                  onPressed: () {
                    openGallery(context, ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  color: Colors.green,
                  textColor: Colors.white,

                ),
              ],
            ),
          );
        });
    // Navigator.of(context).pop(true);
  }

  Future<void> upload() async{
    if(formKey.currentState.validate()) {




      String PDFPath = 'DeviceDocs/WCDocs${DateTime.now()}.pdf';
      final StorageReference  _storagepdf1reference   = FirebaseStorage().ref().child(PDFPath);



      StorageUploadTask uploadTask4 = _storagepdf1reference.putFile(PDfFile1);
      StorageTaskSnapshot downloadPDFUrl = (await uploadTask4.onComplete);
   //   String pdf1url = (await downloadPDFUrl.ref.getDownloadURL());


      var wcpdfUrl = await (await uploadTask4.onComplete).ref.getDownloadURL();
      String pdf1url = wcpdfUrl.toString();




      String PDF2Path = 'DeviceDocs/UGDocs${DateTime.now()}.pdf';
      final StorageReference  _storagepdf2reference   = FirebaseStorage().ref().child(PDF2Path);



      StorageUploadTask uploadTask5 = _storagepdf2reference.putFile(PDfFile2);
      StorageTaskSnapshot downloadPDFUrl2 = (await uploadTask5.onComplete);
      var ugpdfUrl = await (await uploadTask5.onComplete).ref.getDownloadURL();
      String pdf2url =ugpdfUrl.toString();




      String UGImagesPath = 'DeviceImages/DeviceImage${DateTime.now()}.jpg';
      final StorageReference  _reference3    = FirebaseStorage().ref().child(UGImagesPath);

      StorageUploadTask uploadTask3 = _reference3.putFile(imageFile3);

      var ugimgUrl = await (await uploadTask3.onComplete).ref.getDownloadURL();
      String ugurl = ugimgUrl.toString();




      String WCImagesPath = 'DeviceImages/DeviceImage${DateTime.now()}.jpg';
      final StorageReference  _reference2    = FirebaseStorage().ref().child(WCImagesPath);

     /* StorageReference _reference3 = FirebaseStorage.instance.ref().child(
          "ugimages")
          .child(new DateTime.now().millisecondsSinceEpoch.toString() + "." +
          imageFile3.path);*/

      StorageUploadTask uploadTask2 = _reference2.putFile(imageFile2);

      var wcimgUrl = await (await uploadTask2.onComplete).ref.getDownloadURL();
      String wcurl = wcimgUrl.toString();


      String ImagesPath = 'DeviceImages/DeviceImage${DateTime.now()}.jpg';
      final StorageReference _reference    = FirebaseStorage().ref().child(ImagesPath);



      StorageUploadTask uploadTask = _reference.putFile(imageFile);

      var imgUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      String url = imgUrl.toString();
      DatabaseReference databaseReference = FirebaseDatabase.instance
          .reference().child("Data");
      String uploadId = databaseReference
          .push()
          .key;
      HashMap map = new HashMap();
      map ["imgUrl"] = url;
      map ["cattegorrytype"] = cattegorrytype;
      map ["companyname"] = companyname;
      map ["modelname"] = modelname;
      map ["seriesname"] = seriesname;
      map ["year"] = year;
      map ["serielnumber"] = serielnumber;
      map ["warrantydate"] = warrantydate;

      map ["wcimgUrl"] = wcurl;
      map ["ugimgUrl"] = ugurl;

      map ["wcpdfUrl"] = pdf1url;
      map ["ugpdfUrl"] = pdf2url;

      map ["name"] = name;
      map ["mobilenumber"] = mobilenumber;
      map ["address"] = address;
      map ["website"] = website;



      databaseReference.child(uploadId).set(map);
    }
  }



}

