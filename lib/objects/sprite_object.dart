import 'dart:ui';

import 'package:bonfire/base/game_component.dart';
import 'package:bonfire/util/extensions.dart';
import 'package:bonfire/util/priority_layer.dart';
import 'package:flame/sprite.dart';

class SpriteObject extends GameComponent {
  Sprite sprite;

  @override
  void render(Canvas canvas) {
    if (sprite != null && position != null)
      sprite.renderFromVector2Rect(canvas, this.position);
  }

  @override
  int priority = PriorityLayer.OBJECTS;
}
