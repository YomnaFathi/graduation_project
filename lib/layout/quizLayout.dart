import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:graduationproj1/modules/frogMuscles/mediaMuscles/audioMuscles.dart';
import 'package:graduationproj1/modules/frogMuscles/mediaMuscles/pdfMuscles.dart';
import 'package:graduationproj1/modules/frogMuscles/mediaMuscles/quizePageMuscles.dart';
import 'package:graduationproj1/modules/frogMuscles/mediaMuscles/videoMuscles.dart';
import 'package:graduationproj1/shared/components/components.dart';
import 'package:graduationproj1/shared/cubit/navBarCubit.dart';
import 'package:graduationproj1/shared/cubit/navBarState.dart';
import 'package:hexcolor/hexcolor.dart';
import '../modules/frogMuscles/mediaMuscles/quiz2.dart';

class QuizLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (BuildContext context) => NavBarCubit(),
    //   child: BlocConsumer<NavBarCubit, NavBarState>(
    //     listener: (BuildContext context, NavBarState state) {},
    //     builder: (BuildContext context, NavBarState state) {
    //       NavBarCubit cubit = NavBarCubit.get(context);
    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
        title: Text("Quizzes",
          // cubit.titlesMuscles[cubit.currentIndex],
          style: TextStyle(color: HexColor("#819b6d")),
        ),
      ),
      body:
      // cubit.screensMuscles[cubit.currentIndex],
      // floatingActionButton:
      Container(
        // child: ListView(
        // icon: Icons.perm_media,
        // heroTag: "one",
        // backgroundColor: HexColor("#819b6d"),
        // animatedIcon: AnimatedIcons.menu_close,
        // overlayColor: HexColor("#efe8d8"),
        // overlayOpacity: 0.0,
        // children: [
        // Image(
        //   // label: "Pdfs",
        //   image: NetworkImage("assets/q1.jpeg"),
        //   onTap: () => navigateTo(context, PdfPage()),
        // ),
        // Image(
        //  // label: "Videos",
        //   image: NetworkImage("assets/q1.jpeg"),
        //   onTap: () => navigateTo(context, VideoPage()),
        // ),
        // Image(
        //   //label: "Audios",
        //   backgroundColor: HexColor("#efe8d8"),
        //   onTap: () => navigateTo(context, AudioPage()),
        // ),

        child:ListView(
            children: [
              SizedBox(
                height: 70,
              ),
              Padding(
                padding:  const EdgeInsets.only(left:20, right:20),

                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight:Radius.circular(20))
                    ,color: HexColor("#e8885b"),),

                  child: SizedBox(
                    height: 65,
                    child: Center(child: Text('Quiz 1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),)),
                  ),
                ),
              ),
              Padding(
                padding:  const EdgeInsets.only(left:20, right:20),

                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20), bottomRight:Radius.circular(20))
                    ,color: HexColor("#e8885b"),),

                  padding: const EdgeInsets.all(8.0),
                  child :GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/video.jpg',),

                    ),

                    // child: InkWell(
                    onTap: () =>    Navigator.push(context,                   //animation
                        PageRouteBuilder(
                            transitionDuration: Duration(seconds: 2),
                            transitionsBuilder: (BuildContext context,Animation<double>animation,Animation<double> secAnimation, Widget child){
                              animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
                              return ScaleTransition(alignment:Alignment.center,scale: animation,child: child);
                            },

                            pageBuilder:(BuildContext context,
                                Animation<double>animation,Animation<double> secAnimation){
                              return QuizePage();
                            })
                    ),
                    // ),

                    // height: 400,

                    // color: Colors.deepPurple[200],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding:  const EdgeInsets.only(left:20, right:20),

                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight:Radius.circular(20))
                    ,color: HexColor("#e8885b"),),

                  child: SizedBox(
                    height: 65,
                    child: Center(child: Text('Quiz 2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),)),
                  ),
                ),
              ),
              Padding(
                padding:  const EdgeInsets.only(left:20, right:20),

                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20), bottomRight:Radius.circular(20))
                    ,color: HexColor("#e8885b"),),                       padding: const EdgeInsets.all(8.0),
                  child :GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/video.jpg',),

                    ),
                    // child: InkWell(
                    onTap: () =>    Navigator.push(context,
                        PageRouteBuilder(
                            transitionDuration: Duration(seconds: 2),
                            transitionsBuilder: (BuildContext context,Animation<double>animation,Animation<double> secAnimation, Widget child){
                              animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
                              return ScaleTransition(alignment:Alignment.center,scale: animation,child: child);
                            },

                            pageBuilder:(BuildContext context,
                                Animation<double>animation,Animation<double> secAnimation){
                              return Quize2Page();
                            })
                    ),
                    // ),

                    // height: 400,

                    // color: Colors.deepPurple[200],
                  ),
                ),
              ),
              // ),

              //
              // Padding(padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     child: Ink.image(
              //       image: AssetImage('assets/video.jpg'),
              //       child: InkWell(
              //         onTap: () => navigateTo(context, Quize2Page()),
              //       ),
              //
              //       height: 250,
              //     ),
              //   ),
              //

              //                  )
            ]
        ),

        // child: Image(
        //   // label: "Quiz2",
        //     image: NetworkImage("assets/q2.jpeg"),
        //   onTap: () => navigateTo(context, Quize2Page()),
        // ),
        // ],
      ),
      //     bottomNavigationBar: BottomNavigationBar(
      //         backgroundColor: HexColor("#f7cc72"),
      //         selectedIconTheme: IconThemeData(color: HexColor("#e8885b")),
      //         selectedFontSize: 17.0,
      //         selectedItemColor: HexColor("#e8885b"),
      //         iconSize: 25.0,
      //         unselectedItemColor: Colors.white,
      //         unselectedIconTheme: IconThemeData(color: Colors.white),
      //         elevation: 0.0,
      //         type: BottomNavigationBarType.fixed,
      //         onTap: (index) {
      //           cubit.changeIndex(index);
      //         },
      //         currentIndex: cubit.currentIndex,
      //         items: cubit.bottomItems),
      //     );
      //},
      //)
    );
  }
}
