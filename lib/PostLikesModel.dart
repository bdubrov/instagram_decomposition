import 'package:flutter/widgets.dart';

class PostLikesModel extends ChangeNotifier {
  int _numOfLikes;

  PostLikesModel(this._numOfLikes);

  set numOfLikes(var numOfLikes) {
    numOfLikes = numOfLikes;
    notifyListeners();
  }

  int get numOfLines => _numOfLikes;

  void increment() {
    _numOfLikes++;
    notifyListeners();
  }
}
