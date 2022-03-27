
import 'package:cz3003_infinity_towers/screens/barchart_most_correct.dart';
import 'package:cz3003_infinity_towers/screens/barchart_most_incorrect.dart';
import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/screens/manage_towers.dart';

import '../bar_chart/bar_chart_page.dart';
import '../bar_chart/bar_chart_page2.dart';
import '../bar_chart/bar_chart_page3.dart';

class ViewPerformanceChart extends StatefulWidget {
  const ViewPerformanceChart({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  _ViewPerformanceChartState createState() => _ViewPerformanceChartState();
}

class _ViewPerformanceChartState extends State<ViewPerformanceChart> {
  int _currentPage = 0;

  final _controller = PageController(initialPage: 0);
  final _duration = const Duration(milliseconds: 300);
  final _curve = Curves.easeInOutCubic;
  final _pages = const [

    BarChartPage2(),
    BarChartPage2(),

    //BarChartPage3(),

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('View Statistics Report'),
          leading: IconButton(
              icon:Icon(Icons.arrow_back,size:30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageTowers(),
                  ),
                );
              }
          )),
      body: SafeArea(
        child: ListView(
          children: [
            BarChartMostIncorrect(),
            SizedBox(height: 2,),
            BarChartMostCorrect()

          ],

        ),
      ),
    );
  }
}