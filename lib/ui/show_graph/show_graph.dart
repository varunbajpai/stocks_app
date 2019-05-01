import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SegmentsLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SegmentsLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory SegmentsLineChart.withSampleData() {
    return new SegmentsLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text('Compare Prices'),),
      body:
      Container(
        height: 400,
        child: new charts.LineChart(seriesList,
          defaultRenderer:
          new charts.LineRendererConfig(includeArea: true, stacked: true),
          animate: animate),
      ),
    );
  }


  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    return [];
  }
}

/// Sample linear data type.
class LinearSales {
}

