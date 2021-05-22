import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

List<PageViewModel> getPages() {
  List<PageViewModel> pages =  [];
  var page1 = PageViewModel(body: "This is a body",
  image: Image.asset('assets/students/students1.jpeg'),
  bodyWidget: Column(children: [
    Text('Line 1'),
    Text('Line 2')
  ],
  ),);
  pages.add(page1);

  var page2 = PageViewModel(body: "This is a body",
    image: Image.asset('assets/students/students2.jpeg'),
    bodyWidget: Column(children: [
      Text('Line 1'),
      Text('Line 2')
    ],
    ),);
  pages.add(page2);

  var page3 = PageViewModel(body: "This is a body",
    image: Image.asset('assets/students/students3.jpeg'),
    bodyWidget: Column(children: [
      Text('Line 1'),
      Text('Line 2')
    ],
    ),);
  pages.add(page3);


  return pages;
}