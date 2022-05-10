import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduationproj1/main.dart';
import 'package:graduationproj1/modules/home_page.dart';
import 'package:graduationproj1/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  File file;
  var formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  PickedFile pickedFile;
  File _image;
  // ParseUser currentUser =  ParseUser.currentUser() as ParseUser;
  var emailController = TextEditingController();
  var nameController = TextEditingController();

  Future<ParseUser> getUser() async {

    ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
    return currentUser;

  }



  Widget imageProfile() {

              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: HexColor("#e8885b"),
                        child: ClipOval(
                          child: new SizedBox(
                            width: 190.0,
                            height: 190.0,
                            child:
                                uploadPic(context)

                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: HexColor('#e8885b'),
                          size: 28.0,
                        ),
                        onPressed: () {
                          getImage();
                        }
                        ,
                      ),
                    ),
                  ],
                ),
              );
          }

  @override
  Widget build(BuildContext context) {
    // nameController.text ='';
    // emailController.text ="arwa@gmail.com";

    return Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title, style: Theme.of(context).textTheme.headline5),
        ),

        body:

        FutureBuilder<ParseUser>(
           future: getUser(),
           builder: (context, snapshot) {
             switch (snapshot.connectionState) {
               case ConnectionState.none:
                 case ConnectionState.waiting:
                   return Center(
                     child: Container(
                         width: 100,
                         height: 100,
                         child: CircularProgressIndicator()),
                   );
                   default:
                     return
                     SingleChildScrollView(
                         child: Padding(
                             padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
                             child: Center(
                                 child: Form(
                                     key: formKey,
                                     child: Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           SizedBox(height: 40),
                                           imageProfile(),
                                           SizedBox(height: 40),

                                           defaultFormField(
                                               context: context,
                                               controller: nameController,


                                               type: TextInputType.name,
                                               // validate: (String value) {
                                               //   if (value.isEmpty) {
                                               //     return 'name must not be empty';
                                               //   }
                                               //   return null;
                                               //   },


                                               hint: '${snapshot.data.username}',

                                               prefix: Icons.person),
                                           SizedBox(height: 15),
                              //already made in the component as widget
                                     defaultFormField(
                                     controller: emailController,
                                         context: context,
                                         type: TextInputType.emailAddress,
                                         validate: (String value) {
                                       // if (value.isEmpty) {
                                       //   return 'email must not be empty';
                                       //
                                       // }else
                                      //  if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                      //    return 'Please, enter a valid Email';
                                      // }


                                    return null;
                                  },

                                  hint: ('${snapshot.data.emailAddress}'),

                                  prefix: Icons.email_outlined),

                              SizedBox(height: 18.0),

                              defaultButton(
                                      function: () => saveImage(),

                                  text: ('Save'),
                                  style: Theme.of(context).textTheme.button,
                                  background: HexColor("#e8885b"),
                                  isUpperCase: true
                              ),

                            ] )

                    )
                )
            )
        );
    }})
    );
  }
  Future saveImage() async {
    bool isLoading = false;
    ParseFileBase parseFile;
    ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
    if (kIsWeb) {
      //Flutter Web
      parseFile = ParseWebFile(
          await pickedFile.readAsBytes(),
          name: 'image.jpg'); //Name for file is required
    } else {
      //Flutter Mobile/Desktop
      parseFile = ParseFile(File(pickedFile.path));
    }
    await parseFile.save();
    await parseFile.download();
    ParseFileBase parseimage = ParseFile(File('assets/q1.jpeg'));
    parseimage.save();
    final quizimg = ParseObject('Quiz2')
      ..set('image', parseimage);
    await quizimg.save();

    final gallery = ParseObject('Gallery')
      ..set('file', parseFile)
      ..set('myuser', currentUser.username);
    await gallery.save();

    // final myuser = ParseObject('ImageUser')
    //   ..set('Gallerys', ParseObject('Gallery')..objectId = gallery.objectId)
    // ..set('users', ParseObject('User')..objectId = gallery.objectId);
    // await myuser.save();


    setState(() {
      isLoading = false;
      return Center(
        child: Container(
            width: 100,
            height: 100,
            child: CircularProgressIndicator()),
      );
    });

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(
          'Save file with success ',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.blue,
      ));
  }
Future<Widget> getImage() async {
  bool isLoading = false;
  PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery);

  if (image != null) {
    setState(() {
      pickedFile = image;
      print('Image Path $pickedFile');
    });
    _image = File(pickedFile.path);
  }
}
  Widget uploadPic(BuildContext context) {
   return FutureBuilder<ParseObject>(
        future: getGalleryItem(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Container(
                    // width: 100,
                    // height: 100,
                    // child: CircularProgressIndicator()
                  ),
              );
            default:
              if (snapshot.hasError) {
           return Image.asset(
          "assets/Frogmuscles.png",
          fit: BoxFit.fill,
          );
              } else if (pickedFile != null){
                 return Image.file(
                  File(pickedFile.path)
                 );
              } else{

                      //Web/Mobile/Desktop
                      ParseFile varFile =
                      snapshot.data.get<ParseFile>('file');
                      return Image.network(
                        varFile.url,
                        width: 200,
                        height: 200,
                        fit: BoxFit.fitHeight,
                      );

              }

        }},
    );

  }

  Future<ParseObject> getGalleryItem() async {
    ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
    QueryBuilder<ParseObject> queryPublisher =
    QueryBuilder<ParseObject>(ParseObject('Gallery'))
      ..whereEqualTo('myuser', currentUser.username )
      ..orderByDescending('updatedAt');
    final ParseResponse apiResponse = await queryPublisher.query();

    return apiResponse.results.first as ParseObject;
  }


  }
  

  
class ProfileImage extends StatefulWidget {
  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  // File _image;
  PickedFile pickedFile;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {

    Future getImage() async {
      PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          pickedFile = image;

        });
      }
    }

//   
  }

}