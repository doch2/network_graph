part of network_graph;

class GraphViewPainter extends CustomPainter {
  static const gridWidth = 50.0;
  static const gridHeight = 50.0;

  var _width = 0.0;
  var _height = 0.0;

  final double offsetX;
  final double offsetY;

  final DrawingModel model;

  GraphViewPainter(this.model, this.offsetX, this.offsetY);

  void _drawBackground(Canvas canvas) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.transparent
      ..isAntiAlias = true;

    Rect rect = Rect.fromLTWH(0, 0, _width, _height);
    canvas.drawRect(rect, paint);
  }

  Offset? _getCenterPosOfNode(nodeId) {
    for (final node in model.getNodeList()) {
      if (nodeId == node.id) {
        return Offset(node.x, node.y);
      }
    }
    return null;
  }

  void _drawEdges(Canvas canvas) {
    for (final edge in model.getEdgeList()) {
      final fromPos = _getCenterPosOfNode(edge.fromId);
      final toPos = _getCenterPosOfNode(edge.toId);

      if ((fromPos != null) && (toPos != null)) {
        NodeModel toNode = model.getNodeToUUID(edge.toId)!;
        NodeModel fromNode = model.getNodeToUUID(edge.fromId)!;
        int nodeIndex = (model.getNodeList()).indexOf(toNode);
        double nodeRadius = model.nodeRadiusList![nodeIndex];

        final paint = Paint()
          ..style = PaintingStyle.stroke
          ..shader = (toNode.gradient!).createShader((Offset(toNode.x!, toNode.y!) & Size(nodeRadius*1.5, nodeRadius*1.5)))
          ..strokeWidth = 2
          ..isAntiAlias = true;


        if (model.isShowArrowShape) {
          final distance =
              Offset(
                  toPos.dx - fromPos.dx, toPos.dy - fromPos.dy).distance  - (model.nodeRadiusList![nodeIndex]);
          final theta = atan2((toPos.dy - fromPos.dy), (toPos.dx - fromPos.dx));
          final targetX = fromPos.dx + distance * cos(theta);
          final targetY = fromPos.dy + distance * sin(theta);

          var path = Path();
          path.moveTo(fromPos.dx, fromPos.dy);
          path.lineTo(targetX, targetY);
          path = ArrowPath.make(path: path);
          canvas.drawPath(path, paint);
        } else {
          canvas.drawLine(Offset(toNode.x!, toNode.y!), Offset(fromNode.x!, fromNode.y!), paint);
        }
      }
    }
  }

  void _drawNodes(Canvas canvas) {
    List nodeList = model.getNodeList();
    for (NodeModel node in nodeList) {
      int index = nodeList.indexOf(node);
      final c = Offset(node.x!, node.y!);

      TextStyle textStyle = node.isBigNode ? bigNode : smallNode;
      double nodeRadius = model.nodeRadiusList![index];


      var paint = Paint()
        ..style = PaintingStyle.fill
        ..shader = (node.gradient!).createShader((c & Size(nodeRadius*1.5, nodeRadius*1.5)))
        ..isAntiAlias = true;

      canvas.drawCircle(c, nodeRadius, paint);
      _drawText(canvas, node.x, node.y, node.content, textStyle);
    }
  }

  void _initNodeColor() {
    List<LinearGradient> result = [];

    for (final node in model.getNodeList()) {
      int randomIndex = Random().nextInt(gradientList.length);
      LinearGradient linearGradient = gradientList[randomIndex];

      result.add(linearGradient);
    }

    model.nodeColorList = result;
  }

  void _initNodeRadius() {
    List<double> result = [];

    for (final node in model.getNodeList()) {
      TextStyle textStyle = node.isBigNode ? bigNode : smallNode;
      double radius = getNodeRadius(node.content, node.isBigNode, textStyle.fontSize!);

      result.add(radius);
    }

    model.nodeRadiusList = result;
  }

  void _drawText(Canvas canvas, centerX, centerY, text, style) {
    final textSpan = TextSpan(
      text: text,
      style: style,
    );

    final textPainter = TextPainter()
      ..text = textSpan
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout();

    final xCenter = (centerX - textPainter.width / 2);
    final yCenter = (centerY - textPainter.height / 2);
    final offset = Offset(xCenter, yCenter);

    textPainter.paint(canvas, offset);
  }

  void _drawCanvas(Canvas canvas) {
    _drawBackground(canvas);

    canvas.save();
    canvas.translate(offsetX, offsetY);

    _drawEdges(canvas);
    _drawNodes(canvas);

    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    _width = size.width;
    _height = size.height;

    if (model.nodeColorList == null) {  _initNodeColor(); }
    if (model.nodeRadiusList == null) {  _initNodeRadius(); }

    _drawCanvas(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}