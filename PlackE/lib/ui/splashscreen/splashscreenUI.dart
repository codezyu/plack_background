import 'dart:async';
import 'package:flutter/material.dart';
import 'package:placke/index.dart';
import 'package:placke/ui/authentication/loginscreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 0), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            depth: 8,
            lightSource: LightSource.topLeft,
            color: Colors.white
        ),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    depth: 20,
                    lightSource: LightSource.topLeft,
                    color: Colors.grey[10],
                    border: new NeumorphicBorder( color:Color(0x33000000), width:0.8)
                ),
                child:Image.asset(
                  'assets/img/splashscreen/splashscreen.jpg',
                  height: 240,
                )
            ),
            const SizedBox(
              height: 20,
            ),
            SpinKitWaveSpinner(color: Colors.greenAccent,waveColor: Colors.lightGreen,duration: const Duration(milliseconds: 4000),),
            NeumorphicText(
              'hear,feel,love',
              textStyle: NeumorphicTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,

              ),

              style: NeumorphicStyle(

                  depth: 20,

                  lightSource: LightSource.left,

                  color: Colors.amberAccent[200],

                  shape: NeumorphicShape.flat

              ),

            )
          ],
        ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Center(
    //       child:
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Image.asset(
              //       'assets/img/splashscreen/splashscreen.jpg',
              //       height: 240,
              //     ),
              //     const SizedBox(
              //       height: 20,
              //     ),
              //     NeumorphicProgressIndeterminate(
              //       height: 10,
              //     ),
              //     NeumorphicText(
              //       'hear,feel,love',
              //       textStyle: NeumorphicTextStyle(
              //         fontSize: 20,
              //         fontWeight: FontWeight.w900,
              //
              //       ),
              //
              //       style: NeumorphicStyle(
              //
              //           depth: 20,
              //
              //           lightSource: LightSource.left,
              //
              //           color: Colors.amberAccent[200],
              //
              //           shape: NeumorphicShape.flat
              //
              //       ),
              //
              //     )
              //   ],
              // ),
    //   ),
    // );
    }
}