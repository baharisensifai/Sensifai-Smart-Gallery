import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationViewModel with ChangeNotifier, DiagnosticableTreeMixin {


  int _currentIndex = 0;
  int get index => _currentIndex;


  final PageController _controller = PageController(initialPage: 0);
  PageController get controller => _controller;


  void changePage(int page) {
    _currentIndex = page;
    _controller.jumpToPage(page);
    notifyListeners();
  }
}