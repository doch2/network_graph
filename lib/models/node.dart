part of network_graph;

class NodeModel {
  String? id;
  String content;
  double? x;
  double? y;
  LinearGradient? gradient;
  bool isBigNode;
  Function? onClick;

  NodeModel({this.id, required this.content, this.x, this.y, this.isBigNode = false, this.gradient = blueLinearGradientOne,this.onClick});
}