part of network_graph;

class MultiNetworkGraphView extends StatefulWidget {
  bool isShowArrowShape;
  List<NodeGroup> nodeGroupList;
  MultiNetworkGraphView({this.isShowArrowShape=true, required this.nodeGroupList});

  @override
  State createState() => _MultiNetworkGraphViewState(nodeGroupList: nodeGroupList, isShowArrowShape: isShowArrowShape);
}

class _MultiNetworkGraphViewState extends State<MultiNetworkGraphView> {
  late DrawingModel model;

  var offsetX = 0.0;
  var offsetY = 0.0;

  var preX = 0.0;
  var preY = 0.0;

  NodeModel? currentNode;

  List<NodeGroup> nodeGroupList;
  bool isShowArrowShape;
  _MultiNetworkGraphViewState({required this.nodeGroupList, required this.isShowArrowShape}){
    model = DrawingModel(isShowArrowShape: isShowArrowShape);

    nodeGroupList.forEach((element) {
      model.addNodeList(element.nodeList);
      model.addEdgeList(element.edgeList);
    });
  }

  void _handlePanDown(details) {
    final x = details.localPosition.dx;
    final y = details.localPosition.dy;

    final node = model.getNode(x - offsetX, y - offsetY);
    if (node != null) {
      currentNode = node;
    } else {
      currentNode = null;
    }

    preX = x;
    preY = y;
  }

  void _handlePanUpdate(details) {
    final dx = details.localPosition.dx - preX;
    final dy = details.localPosition.dy - preY;

    if (currentNode != null) {
      setState(() {
        currentNode?.x = currentNode!.x! + dx;
        currentNode?.y = currentNode!.y! + dy;
      });
    } else {
      setState(() {
        offsetX = offsetX + dx;
        offsetY = offsetY + dy;
      });
    }

    preX = details.localPosition.dx;
    preY = details.localPosition.dy;
  }

  void _handleLongPressStart(details) {
    final x = details.localPosition.dx;
    final y = details.localPosition.dy;

    final node = model.getNode(x - offsetX, y - offsetY);

    if (node == null) {
      return;
    }

    if (node.onClick != null) {
      node.onClick!.call();
    }
  }

  void _handleLongPressMoveUpdate(details) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanDown: _handlePanDown,
        onPanUpdate: _handlePanUpdate,
        onLongPressStart: _handleLongPressStart,
        onLongPressMoveUpdate: _handleLongPressMoveUpdate,
        child: CustomPaint(
          child: Container(),
          painter: GraphViewPainter(model, offsetX, offsetY),
        ),
      ),
    );
  }
}
