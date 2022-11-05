import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:network_graph/network_graph.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'network_graph Plugin Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    double _displayWidth = MediaQuery.of(context).size.width;
    double _displayHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: _displayWidth,
          height: _displayHeight,
          child: MultiNetworkGraphView(
            nodeGroupList: [
              NodeGroup(
                  title: "Subject",
                  centerNodeOnClick: () => _showToast("Subject Center Node onClick"),
                  gradient: purpleLinearGradientOne,
                  childNodeList: [
                    NodeModel(content: "P.E"),
                    NodeModel(content: "Music"),
                    NodeModel(content: "Social"),
                    NodeModel(content: "English"),
                    NodeModel(content: "StageCraft"),
                  ],
                  x: (_displayWidth / 2),
                  y: (_displayHeight / 1.6)
              ),
              NodeGroup(
                  title: "Country",
                  centerNodeOnClick: () => _showToast("Country Center Node onClick"),
                  gradient: blueLinearGradientOne,
                  childNodeList: [
                    NodeModel(content: "USA"),
                    NodeModel(content: "South Korea"),
                    NodeModel(content: "England"),
                    NodeModel(content: "Japan"),
                  ],
                  x: (_displayWidth / 1.85),
                  y: (_displayHeight / 4.5)
              )
            ],
          ),
        )
      )
    );
  }

  void _showToast(String content) => Fluttertoast.showToast(
      msg: content,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.indigoAccent.withAlpha(95),
      textColor: Colors.black,
      fontSize: 13.0
  );
}
