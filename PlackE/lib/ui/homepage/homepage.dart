import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/model/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/model/screen_hidden_drawer.dart';
import 'package:placke/index.dart';
import 'package:placke/models/camera_icons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
   return NeumorphicButton(

     style: NeumorphicStyle(

       boxShape: NeumorphicBoxShape.roundRect(

         BorderRadius.circular(12),

       ),

       color: Colors.grey[200],

       shape: NeumorphicShape.flat,

     ),

     child: Container(

       color: Colors.grey[200],

       width: 100,

       height: 25,

       child: const Center(

         child: Text('Click me'),

       ),

     ),

     onPressed: () {},

   );
  }
}