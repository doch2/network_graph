part of network_graph;

class DrawingModel {
  final List<NodeModel> _nodeList = List.empty(growable: true);
  final List<EdgeModel> _edgeList = List.empty(growable: true);

  List<LinearGradient>? nodeColorList;
  List<double>? nodeRadiusList;

  bool isShowArrowShape;

  DrawingModel({this.isShowArrowShape = true}) {
    _nodeList.clear();
    _edgeList.clear();
  }

  void addNode(NodeModel node) {
    _nodeList.add(node);
  }

  void addEdge(EdgeModel edge) {
    _edgeList.add(edge);
  }

  void addNodeList(List<NodeModel> node) {
    _nodeList.addAll(node);
  }

  void addEdgeList(List<EdgeModel> edge) {
    _edgeList.addAll(edge);
  }

  NodeModel? getNode(x, y) {
    const radius = 30.0;
    for (final node in _nodeList) {
      final distance =
      sqrt((node.x! - x) * (node.x! - x) + (node.y! - y) * (node.y! - y));
      if (distance <= radius) {
        return node;
      }
    }
    return null;
  }

  NodeModel? getNodeToUUID(String searchUUID) {
    for (final node in _nodeList) {
      if (node.id == searchUUID) { return node; }
    }

    return null;
  }

  List getNodeList() {
    return _nodeList;
  }

  List getEdgeList() {
    return _edgeList;
  }
}