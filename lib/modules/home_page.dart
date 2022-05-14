import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproj1/localization/demo_localization.dart';
import 'package:graduationproj1/models/language.dart';
import 'package:graduationproj1/modules/chat.dart';
import 'package:graduationproj1/modules/fingerprint_page.dart';
import 'package:graduationproj1/modules/settings.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../layout/frogMusclesLayout.dart';
import '../layout/frogSkinLayout.dart';
import 'package:graduationproj1/shared/components/components.dart';
import 'package:graduationproj1/shared/cubit/cubit.dart';
import 'package:graduationproj1/shared/cubit/langcubit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main.dart';
import 'package:graduationproj1/modules/settings.dart';
import '../../layout/quizLayout.dart';
import '../../layout/frogVideoLayout.dart';
import '../../layout/frogSkinLayout.dart';
import '../layout/quizLayout.dart';
import '../layout/frogSkinLayout.dart';
import 'package:graduationproj1/shared/components/components.dart';
import 'package:graduationproj1/shared/cubit/cubit.dart';
import 'package:graduationproj1/shared/cubit/langcubit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main.dart';
import 'chat.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int vIndiceWheel;
  SharedPreferences loginData;
  ParseUser currentUser;
  //scroll3d
  FixedExtentScrollController controller;
  Color hoverColor = Colors.white70;

  bool isHovering = false;
  String email;
  // String nameuser;
  //this should come from database
  // final name = 'Sarah Abs';

  //this should come from database
  final urlImage =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = FixedExtentScrollController();
    initial();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();

    setState(() {
      email = loginData.getString('email');
      // nameuser = registerData.getString('name');

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  Future<bool> hasUserLogged() async {
    ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
    if (currentUser == null) {
      return false;
    }
    //Checks whether the user's session token is valid
    final ParseResponse parseResponse =
    await ParseUser.getCurrentUserFromServer(currentUser.sessionToken);

    if (parseResponse?.success == null || !parseResponse.success) {
      //Invalid session. Logout
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }
  Widget imageProfile() {

    return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Align(
        alignment: Alignment.center,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: HexColor("#e8885b"),
            child: ClipOval(
              child: new SizedBox(
                  width: 190.0,
                  height: 190.0,
                  child:
                 uploadPic(context),

              ),
            ),
          ),
        )]));
  }

  void _changeLanguage(Language lang) {
    Locale _temp;
    switch (lang.languageCode) {
      case 'en':
        _temp = Locale(lang.languageCode, 'US');
        break;
      case 'ar':
        _temp = Locale(lang.languageCode, "ar-EG");
        break;
      case 'fr':
        _temp = Locale(lang.languageCode, 'fr-FR');
        break;
      default:
        _temp = Locale(lang.languageCode, 'US');
    }
    print(lang.languageCode);
    // MyApp.setLocale(context,_temp);
  }
  Future<ParseUser> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser;
    return currentUser;
  }
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title:
              // Text(' Hello $email!',).
              buildAppBar(context),
        ),



        endDrawer: FutureBuilder<ParseUser>(
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
                  if (snapshot.hasError) {
                    return Center(
                      child: Image.asset(
                        "assets/Frogmuscles.png",
                        fit: BoxFit.fill,
                    ));
                  } else {
                    return Drawer(
                        child: Material(
                          borderOnForeground: true,
                          child: Container(
                            decoration:
                            BoxDecoration(color: Theme
                                .of(context)
                                .backgroundColor),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    ListView(
                                      children: [
                                        buildHeader(
                                          // urlImage:  ,
                                          name: snapshot.data.username,
                                          email: snapshot.data.emailAddress,
                                        ),
                                        myDivider(),
                                        buildMenuItem(
                                          text: DemoLocalization.of(context)
                                              .translate('appmode'),
                                          icon: Icons.lightbulb,
                                          onClicked: () =>
                                              selectedItem(context, 0),
                                        ),
                                        buildMenuItem(
                                          text:
                                          DemoLocalization.of(context)
                                              .translate('chat'),
                                          icon: Icons.chat,
                                          onClicked: () =>
                                              selectedItem(context, 1),
                                        ),
                                        buildMenuItem(text: "Settings",
                                            icon: Icons.settings,
                                            onClicked: () =>
                                                selectedItem(context, 2)),
                                      ],
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: HexColor("#e8885b"),
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(5.0))),
                                        child: TextButton(
                                          child: Text(
                                            DemoLocalization.of(context)
                                                .translate('logout'),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                          onPressed: () {
                                            doUserLogout();
                                            // navigateTo(context, FingerprintPage());
                                            loginData.clear();
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ));
                  }
              }
            }),

        body:
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onHover: (val) {
                      setState(() {
                        isHovering = val;
                      });
                    },
                    // hoverColor: Colors.white70,
                    onTap: () {
                      if (vIndiceWheel == null) {
                        vIndiceWheel = 0;
                      }
                      switch (vIndiceWheel) {
                        case 1:
                          navigateTo(context, Chat());
                          break;
                        case 2:
                          navigateTo(context, QuizLayout());
                          break;
                        case 3:
                          navigateTo(context, FrogVideoLayout());
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListWheelScrollView(
                        onSelectedItemChanged: (ValueChanged) {
                          setState(() {
                            vIndiceWheel = ValueChanged;
                          });
                        },
                        physics: FixedExtentScrollPhysics(),

                        controller: controller,
                        itemExtent: 250,
                        // perspective: 0.001,
                        diameterRatio: 0.8,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: HexColor("#e8885b"),
                              // color:Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                    DemoLocalization.of(context).translate(
                                        'frogsystem'),
                                    style: TextStyle(
                                        fontSize: 40,
                                        wordSpacing: 2,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.0),
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: hoverColor,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage("assets/Frog.png")),
                                  // color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(
                                                  20))),
                                      child: Center(
                                          child: Text(
                                              DemoLocalization.of(context)
                                                  .translate('frogskin'),
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: HexColor(
                                                      "#e8885b")))))),
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/quiz.png"),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(
                                                  20))),
                                      child: Center(
                                          child: Text(
                                              DemoLocalization.of(context)
                                                  .translate('frogmuscles'),
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: HexColor(
                                                      "#e8885b")))))),
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/video.jpg"),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20))),
                                      child: Center(
                                          child: Text(
                                              DemoLocalization.of(context)
                                                  .translate('frogvideos'),
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: HexColor("#e8885b")))))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ));


  Widget uploadPic(BuildContext context) {
    return FutureBuilder<ParseObject>(
      future: getGalleryItem(),
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
            if (snapshot.hasError) {
              return Image.asset(
                "assets/Frogmuscles.png",
                fit: BoxFit.fill,
              );
              // if (!snapshot.hasData){
              //  return Image.asset(
              //     "assets/Frogmuscles.png",
              //     fit: BoxFit.fill,
              //   );
              // }
            }
            else {

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

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
      title: Text(
        DemoLocalization.of(context).translate('app_bar_title') ,
        style: Theme.of(context).textTheme.headline5,
      ),
      actions: [
        DropdownButton(
            iconSize: 30,
            dropdownColor: HexColor("#e8885b"),
            onChanged: (Language lang) {
              _changeLanguage(lang);
            },
            icon: Icon(Icons.language_rounded),
            underline: SizedBox(),
            items: Language.langlist()
                .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                      value: lang,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(lang.flag), Text(lang.name)],
                      ),
                      onTap: () {
                        if (lang.name == 'English') {
                          BlocProvider.of<LocaleCubit>(context).toEnglish();
                        } else if (lang.name == "مصرى") {
                          BlocProvider.of<LocaleCubit>(context).toArabic();
                        } else {
                          BlocProvider.of<LocaleCubit>(context).toFrance();
                        }
                      },
                    ))
                .toList()),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(DemoLocalization.of(context).translate('home_page'),
            style: Theme.of(context).textTheme.headline2),
      ],
    );
  }

  Widget buildMenuItem({
    @required String text,
    @required IconData icon,
    VoidCallback onClicked,
  }) {
    final hoverColor = Colors.white70;

    return ListTile(
      leading: IconButton(
        icon: Icon(icon),
        iconSize: 30,
        color: HexColor("#e8885b"),
        onPressed: onClicked,
      ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    // Navigator.of(context).pop();

    switch (index) {
      case 0:
        AppCubit.get(context).changeAppMode();

        break;
      case 1:
        navigateTo(context, Chat());
        break;
      case 2:navigateTo(context, SettingsPage());
      break;
    }
  }

  Widget buildHeader({
    @required String urlImage,
    @required String name,
    @required String email,
    VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                // CircleAvatar(
                //   radius: 30.0,
                //   backgroundImage: () => uploadPic(context),
                // ),
                imageProfile(),
                SizedBox(
                  width: 20.0,
                ),
            Flexible(
              child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
            )
              ],
            ),
          ),
        ),
      );
  void doUserLogout() async {
    var response = await currentUser.logout();
    if (response.success) {
      Message.showSuccess(
          context: context,
          message: 'User was successfully logout!',
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => FingerprintPage()),
                  (Route<dynamic> route) => false,
            );
          });
    } else {
      Message.showError(context: context, message: response.error.message);
    }
  }
}
