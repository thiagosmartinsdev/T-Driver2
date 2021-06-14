import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackGrroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraints) {
      return Stack(
        children: [
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFF546E7A), Color(0xFF35454d)])),
            ),
          ),
          ClipPath(
            clipper: MyCustomClipperBottom(constraints),
            child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF546E7A), Color(0xFF35454d)]))),
          ),
        ],
      );
    });
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.01, size.height * 0.30,
        size.width * 0.1, size.height * 0.33);
    path.lineTo(size.width * 0.90, size.height * 0.53);
    path.quadraticBezierTo(
        size.width * 0.98, size.height * 0.54, size.width, size.height * 0.51);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyCustomClipperBottom extends CustomClipper<Path> {
  final BoxConstraints constraints;

  MyCustomClipperBottom(this.constraints);
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, constraints.maxHeight * 0.8);
    path.quadraticBezierTo(
        constraints.maxWidth * 0.02,
        constraints.maxHeight * 0.76,
        constraints.maxWidth * 0.13,
        constraints.maxHeight * 0.8);
    path.lineTo(constraints.maxWidth * 0.57, constraints.maxHeight * 0.96);
    path.quadraticBezierTo(
        constraints.maxWidth * 0.61,
        constraints.maxHeight * 0.98,
        constraints.maxWidth * 0.57,
        constraints.maxHeight);

    path.lineTo(0, constraints.maxHeight);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
