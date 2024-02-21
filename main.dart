import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CircleSelectionScreen(),
    );
  }
}

class CircleSelectionScreen extends StatefulWidget {
  @override
  _CircleSelectionScreenState createState() => _CircleSelectionScreenState();
}

class _CircleSelectionScreenState extends State<CircleSelectionScreen> {
  int selectedCircleIndex = -1;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < colors.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCircleIndex = i;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors[i],
                        border: Border.all(
                          color: selectedCircleIndex == i
                              ? Colors.black
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: selectedCircleIndex != -1
                    ? colors[selectedCircleIndex]
                    : Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  selectedCircleIndex != -1
                      ? 'Selected color: ${colors[selectedCircleIndex]}'
                      : 'Select a color',
                  style: TextStyle(
                    color: selectedCircleIndex != -1
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
