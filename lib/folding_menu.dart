library folding_menu;

import 'package:flutter/material.dart';

class FoldingMenu extends StatefulWidget {
  final List<Widget> children;
  final bool folded;
  final Duration? duration;
  final Color? shadowColor;
  final Curve? animationCurve;

  const FoldingMenu(
      {Key? key, required this.children, required this.folded, this.duration = const Duration(milliseconds: 900), this.shadowColor = Colors.black, this.animationCurve = Curves.decelerate})
      : super(key: key);

  @override
  _FoldingMenuState createState() => _FoldingMenuState();
}

class _FoldingMenuState extends State<FoldingMenu> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation _curvedAnimation;
  late Animation _animation, transAnimation;

  List<GlobalKey> keys = [];
  List<List<dynamic>> widgets = [];
  Map<Widget, double> positions = {};
  double elementHeight = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: widget.duration);
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: widget.animationCurve!);

    initiateAnimations(widget.folded);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      double heightDisplacement = 0;
      keys.forEach((element) {
        positions[element.currentWidget!] = heightDisplacement;

        heightDisplacement += element.currentContext!.size!.height;
        elementHeight = element.currentContext!.size!.height;
      });
      setState(() {});
    });

    _animationController.addListener(() {
      setState(() {});
    });

    int index = 0;
    widget.children.forEach((element) {
      GlobalKey key = GlobalKey();
      keys.add(key);
      widgets.add([
        index,
        Container(
          key: key,
          child: element,
        )
      ]);
      index++;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FoldingMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.folded != widget.folded) {
      initiateAnimations(oldWidget.folded);
      _animationController.reset();
      _animationController.forward();
    }
  }

  initiateAnimations(bool folded) {
    _animation = (folded ? Tween(begin: 0.0, end: 1.57) : Tween(begin: 1.57, end: 0.0)).animate(_curvedAnimation);
    transAnimation = (folded ? Tween(begin: 0.0, end: 1.0) : Tween(begin: 1.0, end: 0.0)).animate(_curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: widgets.map((child) {
          final bool isOdd = child[0] % 2 != 0;
          Color shadowColor = widget.shadowColor!.withOpacity(transAnimation.value * 0.35);


          return Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.translationValues(0, transAnimation.value * (-(positions[child[1]] ?? 0) - (isOdd ? elementHeight : 0)), 0),
              child: Transform(
                  alignment: isOdd ? Alignment.bottomCenter : Alignment.topCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0090)
                    ..rotateX(isOdd ? -_animation.value : _animation.value),
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.white,
                        child: child[1],),
                      IgnorePointer(
                        ignoring: true,
                        child: Container(
                          width: double.infinity,
                          height: elementHeight,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: isOdd ? [Colors.transparent, shadowColor] : [shadowColor, Colors.transparent], end: Alignment.topCenter, begin: Alignment.bottomCenter)),
                        ),
                      )
                    ],
                  )));
        }).toList(),
      ),
    );
  }
}
