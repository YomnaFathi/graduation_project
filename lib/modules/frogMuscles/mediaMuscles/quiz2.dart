// import 'package:audio_manager/audio_manager.dart';

import 'dart:io';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:graduationproj1/main.dart';
import 'package:flutter/material.dart';
// import 'package:graduationproj1/data/quiz2_list.dart';
import 'package:graduationproj1/score/result_screen2.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'dart:async';
// import '../../../data/quiz2_list.dart';
import '../../score/result_screen2.dart';

class Quize2Page extends StatefulWidget {
  @override
  _AudioPageState createState() => _AudioPageState();

}

class _AudioPageState extends State<Quize2Page> {

  Color mainColor = Color(0xFF252c4a);
  Color secondColor = HexColor("#e8885b");
  int question_pos = 0;
  int score = 0;
  bool btnPressed = false;
  PageController _controller;
  String btnText = "Next Question";
  bool answered = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
    // doSaveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(MyApp.title, style: Theme.of(context).textTheme.headline5),
    ),

    body: FutureBuilder<List<ParseObject>>(
        future: getList(),
    builder: (context, snapshot) {
    switch (snapshot.connectionState) {
    case ConnectionState.none:
    case ConnectionState.waiting:
    // return Center(
    // child: Container(
    // width: 100,
    // height: 100,
    // child: CircularProgressIndicator()),
    // );
    default:
    if (snapshot.hasError) {
    return Center(
    child: Text("Error..."),
    );
    }
    if (!snapshot.hasData) {
    return Center(
    child: Text("Loading..."),
    );
    } else {
    return Scaffold(

      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (page) {
              if (page == snapshot.data.length - 1) {
                setState(() {
                  btnText = "See Results";
                });
              }
              setState(() {
                answered = false;
              });
            },
            physics: new NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              //Get Parse Object Values
              final varQues = snapshot.data[index];
              final varTitle = varQues.get<String>('Question');
              final varAnswer =  varQues.get('answers');
              final varImage =  varQues.get<ParseFileBase>('QuesImage');
              return SingleChildScrollView( //bottom overflowed of rotation
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Question ${index + 1}/10",
                      textAlign: TextAlign.start,
                      style: TextStyle(

                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  Divider(),

                  SizedBox(
                    width: double.infinity,
                    height: 60.0,
                    child: Text(
                      "${varTitle}",

                      style: TextStyle(

                        fontSize: 22.0,
                      ),
                    ),

                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 150.0,
                    child: Image.network(
                      varImage.url,


                    ),

                  ),
                  SizedBox(
                  height: 30.0,
                  ),
                  for (int i = 0; i < varAnswer.length; i++)
                    Container(
                      width: double.infinity,
                      height: 35.0,
                      margin: EdgeInsets.only(
                          bottom: 20.0, left: 12.0, right: 12.0),
                      child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        fillColor: btnPressed
                            ? varAnswer.values.toList()[i]
                            ? Colors.green
                            : Colors.red
                            : secondColor,
                        onPressed: !answered
                            ? () {
                          // AudioManager.instance.playOrPause();//sound click
                          if (varAnswer
                              .values
                              .toList()[i]) {
                            score++;
                            print("yes");
                            FlutterBeep.beep();
                          } else {
                            print("no");
                            FlutterBeep.beep(false);
                          }
                          setState(() {
                            btnPressed = true;
                            answered = true;
                          });
                        }
                            : null,
                        child: Text(varAnswer.keys.toList()[i],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            )),
                        // onLongPress: ()=>  AudioManager.instance.playOrPause(),

                      ),
                    ),
                  SizedBox(
                    height: 15.0,
                  ),

                  RawMaterialButton(

                    onPressed: () {
                      if (_controller.page?.toInt() == snapshot.data.length - 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultScreen2(score)));
                      } else {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeInExpo);

                        setState(() {
                          btnPressed = false;
                        });
                      }
                    },
                    shape: StadiumBorder(),
                    fillColor: HexColor("#819b6d"),
                    padding: EdgeInsets.all(18.0),
                    elevation: 0.0,
                    child: Text(
                      btnText,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ));
            },
            itemCount: snapshot.data.length,
          )),
    );
    }}
        })
    );
  }
  Future<List<ParseObject>> getList() async {
    QueryBuilder<ParseObject> queryTodo =
    QueryBuilder<ParseObject>(ParseObject('Quiz2'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }
  }

