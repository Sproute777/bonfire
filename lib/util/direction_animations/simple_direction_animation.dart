import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire/objects/animated_object_once.dart';
import 'package:bonfire/util/direction_animations/simple_animation_enum.dart';
import 'package:bonfire/util/vector2rect.dart';
import 'package:flutter/foundation.dart';

class SimpleDirectionAnimation {
  SpriteAnimation idleLeft;
  SpriteAnimation idleRight;
  SpriteAnimation idleTop;
  SpriteAnimation idleBottom;
  SpriteAnimation idleTopLeft;
  SpriteAnimation idleTopRight;
  SpriteAnimation idleBottomLeft;
  SpriteAnimation idleBottomRight;
  SpriteAnimation runTop;
  SpriteAnimation runRight;
  SpriteAnimation runBottom;
  SpriteAnimation runLeft;
  SpriteAnimation runTopLeft;
  SpriteAnimation runTopRight;
  SpriteAnimation runBottomLeft;
  SpriteAnimation runBottomRight;
  Map<String, SpriteAnimation> others = {};
  SimpleAnimationEnum init;

  SpriteAnimation current;
  SimpleAnimationEnum _currentType;
  AnimatedObjectOnce _fastAnimation;
  bool runToTheEndFastAnimation = false;
  Vector2Rect position;

  SimpleDirectionAnimation({
    @required Future<SpriteAnimation> idleLeft,
    @required Future<SpriteAnimation> idleRight,
    Future<SpriteAnimation> idleTop,
    Future<SpriteAnimation> idleBottom,
    Future<SpriteAnimation> idleTopLeft,
    Future<SpriteAnimation> idleTopRight,
    Future<SpriteAnimation> idleBottomLeft,
    Future<SpriteAnimation> idleBottomRight,
    Future<SpriteAnimation> runTop,
    @required Future<SpriteAnimation> runRight,
    Future<SpriteAnimation> runBottom,
    @required Future<SpriteAnimation> runLeft,
    Future<SpriteAnimation> runTopLeft,
    Future<SpriteAnimation> runTopRight,
    Future<SpriteAnimation> runBottomLeft,
    Future<SpriteAnimation> runBottomRight,
    Map<String, Future<SpriteAnimation>> others,
    this.init = SimpleAnimationEnum.idleRight,
  }) {
    idleLeft?.then((value) => this.idleLeft = value);
    idleRight?.then((value) => this.idleRight = value);
    idleTop?.then((value) => this.idleTop = value);
    idleBottom?.then((value) => this.idleBottom = value);
    idleTopLeft?.then((value) => this.idleTopLeft = value);
    idleTopRight?.then((value) => this.idleTopRight = value);
    idleBottomLeft?.then((value) => this.idleBottomLeft = value);
    idleBottomRight?.then((value) => this.idleBottomRight = value);
    runTop?.then((value) => this.runTop = value);
    runRight?.then((value) => this.runRight = value);
    runBottom?.then((value) => this.runBottom = value);
    runLeft?.then((value) => this.runLeft = value);
    runTopLeft?.then((value) => this.runTopLeft = value);
    runTopRight?.then((value) => this.runTopRight = value);
    runBottomLeft?.then((value) => this.runBottomLeft = value);
    runBottomRight?.then((value) => this.runBottomRight = value);
    others?.forEach((key, anim) {
      anim.then((value) {
        this.others[key] = value;
      });
    });
    play(init);
  }

  void play(SimpleAnimationEnum animation) {
    _currentType = animation;
    if (!runToTheEndFastAnimation) {
      _fastAnimation = null;
    }
    switch (animation) {
      case SimpleAnimationEnum.idleLeft:
        if (idleLeft != null) current = idleLeft;
        break;
      case SimpleAnimationEnum.idleRight:
        if (idleRight != null) current = idleRight;
        break;
      case SimpleAnimationEnum.idleTop:
        if (idleTop != null) current = idleTop;
        break;
      case SimpleAnimationEnum.idleBottom:
        if (idleBottom != null) current = idleBottom;
        break;
      case SimpleAnimationEnum.idleTopLeft:
        if (idleTopLeft != null) current = idleTopLeft;
        break;
      case SimpleAnimationEnum.idleTopRight:
        if (idleTopRight != null) current = idleTopRight;
        break;
      case SimpleAnimationEnum.idleBottomLeft:
        if (idleBottomLeft != null) current = idleBottomLeft;
        break;
      case SimpleAnimationEnum.idleBottomRight:
        if (idleBottomRight != null) current = idleBottomRight;
        break;
      case SimpleAnimationEnum.runTop:
        if (runTop != null) current = runTop;
        break;
      case SimpleAnimationEnum.runRight:
        if (runRight != null) current = runRight;
        break;
      case SimpleAnimationEnum.runBottom:
        if (runBottom != null) current = runBottom;
        break;
      case SimpleAnimationEnum.runLeft:
        if (runLeft != null) current = runLeft;
        break;
      case SimpleAnimationEnum.runTopLeft:
        if (runTopLeft != null) current = runTopLeft;
        break;
      case SimpleAnimationEnum.runTopRight:
        if (runTopRight != null) current = runTopRight;
        break;
      case SimpleAnimationEnum.runBottomLeft:
        if (runBottomLeft != null) current = runBottomLeft;
        break;
      case SimpleAnimationEnum.runBottomRight:
        if (runBottomRight != null) current = runBottomRight;
        break;
    }
  }

  void playOther(String key) {
    if (others?.containsKey(key) == true) {
      if (!runToTheEndFastAnimation) {
        _fastAnimation = null;
      }
      current = others[key];
    }
  }

  void playOnce(
    SpriteAnimation animation, {
    VoidCallback onFinish,
    bool runToTheEnd = false,
  }) {
    runToTheEndFastAnimation = runToTheEnd;
    _fastAnimation = AnimatedObjectOnce(
      animation: animation,
      onFinish: () {
        onFinish?.call();
        _fastAnimation = null;
      },
    );
  }

  void render(Canvas canvas) {
    if (position == null) return;
    if (_fastAnimation != null) {
      _fastAnimation.render(canvas);
    } else if (current?.getSprite()?.loaded() == true) {
      current.getSprite().render(
            canvas,
            position: position.position,
            size: position.size,
          );
    }
  }

  void update(double dt, Vector2Rect position) {
    this.position = position;
    if (_fastAnimation != null) {
      _fastAnimation.position = position;
      _fastAnimation.update(dt);
    } else {
      current?.update(dt);
    }
  }

  SimpleAnimationEnum get currentType => _currentType;
}
