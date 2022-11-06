part of network_graph;

class NodeGroup {
  String title;
  Function? centerNodeOnClick;
  List<NodeModel> childNodeList;
  double x;
  double y;
  LinearGradient gradient;

  late List<NodeModel> nodeList;
  late List<EdgeModel> edgeList;

  NodeGroup({
    required this.title,
    this.centerNodeOnClick,
    required this.childNodeList,
    required this.x,
    required this.y,
    this.gradient = blueLinearGradientOne,
  }) {
    nodeList = initNodeList();
    edgeList = initEdgeList();
  }

  initNodeList() {
    List<NodeModel> resultList = [NodeModel(isBigNode: true, id: getNewUUID(), content: title, onClick: centerNodeOnClick, x: x, y: y, gradient: gradient)];

    Offset rootOffset = Offset(x, y);

    List<NodeModel> preprocessingChildNodeList = [];
    childNodeList.forEach((element) {
      int index = childNodeList.indexOf(element);


      double degree = (720 / (childNodeList.length * 1.4)) * index;
      double distance = getNodeRadius(element.content, element.isBigNode, (element.isBigNode ? bigNode : smallNode).fontSize!) * (2.7 + (Random().nextInt(2) / 10));
      if (distance < 100) { distance = distance + Random().nextInt(10) + 45; }

      Offset childNodeOffset = _getPos(degree: degree, distance: distance, rootOffset: rootOffset);

      element.id ??= getNewUUID();
      element.x ??= childNodeOffset.dx;
      element.y ??= childNodeOffset.dy;
      element.gradient = gradient;

      preprocessingChildNodeList.add(element);
    });

    childNodeList = preprocessingChildNodeList;

    resultList.addAll(preprocessingChildNodeList);

    return resultList;
  }

  initEdgeList() {
    List<EdgeModel> resultList = [];

    String mainNodeUUID = nodeList[0].id!;

    for (int i=1; i<(nodeList.length); i++) {
      resultList.add(EdgeModel(mainNodeUUID, nodeList[i].id!));
    }

    return resultList;
  }

  Offset _getPos({required double degree, required double distance, required Offset rootOffset}) {
    double dx = distance * cos(_degreeToRadian(degree: degree)) + rootOffset.dx;
    double dy = distance * sin(_degreeToRadian(degree: degree)) + rootOffset.dy;
    return Offset(dx, dy);
  }

  double _degreeToRadian({required double degree}) {
    return degree * (pi / 180);
  }
}