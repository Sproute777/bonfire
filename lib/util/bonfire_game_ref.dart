import 'package:bonfire/base/bonfire_game.dart';
import 'package:bonfire/base/bonfire_game_interface.dart';
import 'package:flame/components.dart';

mixin BonfireHasGameRef on Component {
  BonfireGame? _gameRef;

  BonfireGame get gameRef {
    if (_gameRef == null) {
      var c = parent;
      while (c != null) {
        if (c is BonfireHasGameRef) {
          _gameRef = c.gameRef;
          return _gameRef!;
        } else if (c is BonfireGame) {
          _gameRef = c as BonfireGame;
          return _gameRef!;
        } else {
          c = c.parent;
        }
      }
      throw StateError(
        'Cannot find reference $BonfireGame in the component tree',
      );
    }
    return _gameRef!;
  }

  bool get hasGameRef => _getGameRef() != null;

  BonfireGame? _getGameRef() {
    if (_gameRef == null) {
      var c = parent;
      while (c != null) {
        if (c is BonfireHasGameRef) {
          _gameRef = c.gameRef;
          return _gameRef!;
        } else if (c is BonfireGame) {
          _gameRef = c as BonfireGame;
          return _gameRef!;
        } else {
          c = c.parent;
        }
      }
    }
    return _gameRef;
  }

  set gameRef(BonfireGame gameRef) {
    _gameRef = gameRef;
    this
        .children
        .whereType<BonfireHasGameRef>()
        .forEach((e) => e.gameRef = gameRef);
  }

  @override
  void onRemove() {
    _gameRef = null;
    super.onRemove();
  }
}
