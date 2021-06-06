import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:folding_menu/folding_menu.dart';

import 'second_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Folding Menu Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool openMenu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Folding Menu"),
        actions: [
          IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                setState(() {
                  openMenu = !openMenu;
                });
              })
        ],
      ),
      body: Stack(
        children: [
          ScreenContent(),
          AnimatedOpacity(
            opacity: openMenu?1.0:0.0,
            duration: Duration(milliseconds: 400),
            child: Container(
              color: Colors.black54,
              child: Center(child: Text("")),
            ),
          ),
          // Add FoldingMenu as the Last Child to Stack
          FoldingMenu(duration: Duration(milliseconds: 900), shadowColor: Colors.black26, animationCurve: Curves.decelerate, folded: openMenu, children: [
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondScreen(
                          text: "Page 1",
                        )));
              },
              title: Text("Screen 1"),
              tileColor: Colors.white,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondScreen(
                          text: "Page 2",
                        )));
              },
              title: Text("Screen 2"),
              tileColor: Colors.white,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondScreen(
                          text: "Page 3",
                        )));
              },
              title: Text("Screen 3"),
              tileColor: Colors.white,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondScreen(
                          text: "Page 4",
                        )));
              },
              title: Text("Screen 4"),
              tileColor: Colors.white,
            ),
          ]),
        ],
      ),
    );
  }
}

class ScreenContent extends StatefulWidget {
  @override
  _ScreenContentState createState() => _ScreenContentState();
}

class _ScreenContentState extends State<ScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Music Albums",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Expanded(child: Center()),
              IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
              CircleAvatar(
                child: Image.asset("assets/images/dp_default.png"),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(border: InputBorder.none, hintText: "Look for your Interest!", fillColor: Colors.grey.shade200, filled: true),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DropdownButton(
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  icon: Icon(Icons.keyboard_arrow_down),
                  underline: Container(
                    color: Colors.white,
                  ),
                  items: ["Featured", "Most Rated", "Recent", "Popular"]
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (newItem) {}),
              IconButton(icon: Icon(Icons.sort), onPressed: () {})
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView(
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
                  .map((e) => Card(
                        child: Column(
                          children: <Widget>[
                            Image.asset("assets/images/image_$e.jpg"),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    ));
  }
}
