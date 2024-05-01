import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Padding(
        padding: EdgeInsets.all(32.0),
        child: SquareAnimation(),
      ),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({Key? key}) : super(key: key);

  @override
  State<SquareAnimation> createState() {
    return SquareAnimationState();
  }
}

class SquareAnimationState extends State<SquareAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  BoxPosition boxPosition = BoxPosition.center;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Animation duration
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.5, end: 0.5).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  width: boxPosition == BoxPosition.left
                      ? (size.width * _animation.value) <= 0 ? 0 : size.width * _animation.value
                      : ((size.width * _animation.value) - _squareSize-100 ) <= 0 ? 0 : size.width * _animation.value - _squareSize -100,

                ),
                Container(
                  width: _squareSize,
                  height: _squareSize,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(),
                  ),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton(
              onPressed: boxPosition == BoxPosition.right
                  ? null
                  : () {
                setState(() {
                  _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
                  boxPosition = BoxPosition.right;
                  _controller.forward();
                });
              },
              child: const Text('Right'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: boxPosition == BoxPosition.left
                  ? null
                  : () {
                setState(() {
                  _animation = Tween<double>(begin: 1, end: 0).animate(_controller);

                  boxPosition = BoxPosition.left;
                  _controller.forward();
                });
              },
              child: const Text('Left'),
            ),
          ],
        ),
      ],
    );
  }

  static const _squareSize = 50.0;
}

enum BoxPosition { center, left, right }
