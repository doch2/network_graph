library network_graph;

import 'dart:math';

import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

part 'multi_network_graph_view.dart';
part 'models/drawing_model.dart';
part 'models/edge.dart';
part 'models/node.dart';
part 'models/node_group.dart';
part 'painters/graph_view_painter.dart';
part 'themes/color_theme.dart';
part 'themes/text_theme.dart';


const uuidObject = Uuid();

getNewUUID() => uuidObject.v4();