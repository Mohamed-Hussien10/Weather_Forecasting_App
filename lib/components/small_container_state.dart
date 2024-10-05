import 'package:flutter/material.dart';

class SmallContainer extends StatefulWidget {
  final IconData iconn;
  final String text1;
  final String text2;

  const SmallContainer(
      {super.key,
      required this.iconn,
      required this.text1,
      required this.text2});

  @override
  State<SmallContainer> createState() => _SmallContainer();
}

class _SmallContainer extends State<SmallContainer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: const BoxDecoration(
            color: Color(0xff414475),
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Color(0xff4b4f85),
                offset: Offset(0, 18),
                blurRadius: 20,
                spreadRadius: -12,
              ),
            ]),
        child: Column(
          children: [
            Container(
              height: 10,
            ),
            Icon(widget.iconn, color: Colors.orange, size: 28),
            Container(
              height: 5,
            ),
            Text(widget.text1,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                )),
            Container(
              height: 4,
            ),
            Text(widget.text2,
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 15,
                  shadows: [
                    Shadow(
                      color: Colors.black
                          .withOpacity(0.5), // Shadow color with opacity
                      offset: const Offset(1, 1), // Shadow position (x, y)
                      blurRadius: 2, // Blur radius for the shadow
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
