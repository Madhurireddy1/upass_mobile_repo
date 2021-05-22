import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:introduction_screen/src/model/page_decoration.dart';

class MyPageViewModel extends PageViewModel {

  /// Title of page
  final Widget? titleWidget;

  /// Widget content of page (description)
  final Widget? bodyWidget;

  /// Image of page
  /// Tips: Wrap your image with an alignment widget like Align or Center
  final Widget? image;

  /// Footer widget, you can add a button for example
  final Widget? footer;

  /// Page decoration
  /// Contain all page customizations, like page color, text styles
  final PageDecoration decoration;

  /// If widget Order is reverse - body before image
  final bool reverse;

  /// Wrap content in scrollView
  final bool useScrollView;

  MyPageViewModel({
    this.titleWidget,
    this.bodyWidget,
    this.image,
    this.footer,
    this.reverse = false,
    this.decoration = const PageDecoration(),
    this.useScrollView = true,
  });
}
