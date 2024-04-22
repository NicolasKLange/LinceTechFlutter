import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shape Changer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ShapeChanger(),
    );
  }
}

enum ShapeType { circle, square, triangle }

class ShapeChanger extends StatefulWidget {
  @override
  _ShapeChangerState createState() => _ShapeChangerState();
}

class _ShapeChangerState extends State<ShapeChanger> {
  Color _currentColor = Colors.blue;
  ShapeType _currentShape = ShapeType.circle;

  void _changeShape(ShapeType shapeType) {
    setState(() {
      _currentShape = shapeType;
    });
  }

  void _changeColor() {
    setState(() {
      _currentColor = _generateRandomColor();
    });
  }

  Color _generateRandomColor() {
    List<Color> colors = [
      Colors.purple,
      Colors.yellow,
      Colors.blue,
      Colors.green,
      Colors.pink,
      Colors.red,
    ];
    Random random = Random();
    return colors[random.nextInt(colors.length)];
  }

  Widget _buildShape() {
    switch (_currentShape) {
      case ShapeType.circle:
        return CircleAvatar(
          backgroundColor: _currentColor,
          radius: 100,
        );
      case ShapeType.square:
        return Container(
          width: 200,
          height: 200,
          color: _currentColor,
        );
      case ShapeType.triangle:
        return _Triangle(color: _currentColor);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shape Changer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildShape(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _changeShape(ShapeType.circle);
                  },
                  child: Text('Círculo'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _changeShape(ShapeType.square);
                  },
                  child: Text('Quadrado'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _changeShape(ShapeType.triangle);
                  },
                  child: Text('Triângulo'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _changeColor();
              },
              child: Text('Cor Aleatória'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Triangle extends StatelessWidget {
  final Color color;

  const _Triangle({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: _TrianglePainter(color),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TrianglePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}