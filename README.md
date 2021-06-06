# Folding Menu

This is an easy to use package for adding Folding Menu to your Flutter Applications

## Demo
![](https://github.com/retroportalstudio/folding_menu/blob/master/folding_menu.gif)

## Usage
To Use, simply add Folding Menu to your Stack Widget(as the Last Element for most Cases):
```dart
      body: Stack(
        children: [
          Container(
            color: Colors.deepOrange,
            child: Center(child: Text("Other Screen Content",style: TextStyle(color: Colors.white,fontSize: 20),)),),
          // Add FoldingMenu as the Last Child to Stack
          FoldingMenu(duration: Duration(milliseconds: 900), shadowColor: Colors.black26, animationCurve: Curves.decelerate, folded: openMenu, children: [
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondScreen(
                          text: "Page 1",
                        )));
              },
              title: Text("Home Dance"),
              tileColor: Colors.white,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondScreen(
                          text: "Page 2",
                        )));
              },
              title: Text("Home Dance 2"),
              tileColor: Colors.white,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondScreen(
                          text: "Page 3",
                        )));
              },
              title: Text("Home Dance 3"),
              tileColor: Colors.white,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondScreen(
                          text: "Page 4",
                        )));
              },
              title: Text("Home Dance 4"),
              tileColor: Colors.white,
            ),
          ]),
        ],
      ),
```

## Roadmap
Plans to add more customizations.

## License
[MIT](https://choosealicense.com/licenses/mit/)
