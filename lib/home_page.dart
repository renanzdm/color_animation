import 'package:flutter/material.dart';

import 'package:transition_color_animation/color_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ColorModel _current = colorList.first;
  ColorModel _past = colorList.last;

  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        upperBound: 2.5,
        duration: const Duration(milliseconds: 700),
        vsync: this);

    super.initState();
  }

  void buttonClicked(ColorModel colorSelected) {
    setState(() {
      _current = colorSelected;
    });

    _controller.forward(from: 0.0).whenComplete(() {
      _past = _current;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: _past.color,
                    ),
                  ),
                  Positioned.fill(
                    child: AnimatedBuilder(
                        animation: _controller,
                        builder: (_, __) {
                          return ClipPath(
                            clipper: ColorClipper(percent: _controller.value),
                            child: Container(
                              color: _current.color,
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        itemCount: colorList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 16 / 9,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          return ButtonColor(
                            backgroundColor: colorList[index],
                            selected: _current.color == colorList[index].color,
                            onTap: () {
                              buttonClicked(colorList[index]);
                            },
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonColor extends StatelessWidget {
  const ButtonColor(
      {Key key, this.backgroundColor, this.onTap, this.selected = false})
      : super(key: key);
  final ColorModel backgroundColor;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor.color,
          border: Border.all(color: Colors.white, width: selected ? 10 : 3),
        ),
      ),
    );
  }
}

class ColorClipper extends CustomClipper<Path> {
  double percent;
  ColorClipper({
    this.percent,
  });
  @override
  getClip(Size size) {
    Path path = Path();
    path.addOval(Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        height: size.height * percent,
        width: size.height * percent));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
