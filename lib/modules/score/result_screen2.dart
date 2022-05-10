import 'package:flutter/material.dart';
import 'package:graduationproj1/modules/frogMuscles/mediaMuscles/quiz2.dart';
import 'package:hexcolor/hexcolor.dart';


class ResultScreen2 extends StatefulWidget {
  final int score;
  const ResultScreen2(this.score,{Key key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen2> {

  @override
  Widget build(BuildContext context) {
    Color mainColor = Color(0xFF252c4a);
    Color secondColor = Color(0xFF117eeb);
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text("Congratulations",style: TextStyle(fontSize: 38.0,fontWeight:FontWeight.bold)
            ),
            SizedBox(height: 20.0,),
            Text("your score is:",style: TextStyle(fontSize: 28.0,fontWeight:FontWeight.w400)
            ),
            SizedBox(height: 50.0),
            Text("${widget.score}",style: TextStyle(color: HexColor("#e8885b"),fontSize: 80.0,fontWeight:FontWeight.bold),)
            ,SizedBox(height: 60.0,),
            MaterialButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Quize2Page()));
            },
                color: HexColor("#819b6d"),
                textColor: Colors.white,
                child: Text("Repeat the Quiz")
            ),
          ],
        ),
      ),
    );
  }
}
