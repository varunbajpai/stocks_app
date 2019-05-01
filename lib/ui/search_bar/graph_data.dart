import 'package:charts_flutter/flutter.dart' as charts;

/// Create one series with sample hard coded data.
class GetData {
  static List<charts.Series<LinearSales, int>> getDataFromAPI(String company_name) {
    print(company_name);

    //Call API to get data and then run it in for loops over here to get it done


    final actualPrices = [
      new LinearSales(0, 5),
      new LinearSales(1, 15),
      new LinearSales(2, 25),
      new LinearSales(3, 75),
      new LinearSales(4, 500),
      new LinearSales(5, 90),
      new LinearSales(6, 75),
    ];

    // Series of data with changing color and dash pattern.
    final predictedPrices = [
      new LinearSales(0, 5),
      new LinearSales(1, 15),
      new LinearSales(2, 25),
      new LinearSales(3, 75),
      new LinearSales(4, -200),
      new LinearSales(5, 90),
      new LinearSales(6, 75),
    ];


    // Generate 2 shades of each color so that we can style the line segments.
    final blue = charts.MaterialPalette.blue.makeShades(2);
    final red = charts.MaterialPalette.red.makeShades(2);

    return [
      new charts.Series<LinearSales, int>(
        id: 'Color Change',
        // Light shade for even years, dark shade for odd.
        colorFn: (LinearSales sales, _) =>
        sales.year % 2 == 0 ? blue[1] : blue[0],
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: actualPrices,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Dash Pattern Change',
        colorFn: (LinearSales sales, _) =>
        sales.year % 2 == 0 ? red[1] : red[0],
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: predictedPrices,
      )
    ];
  }
}


/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  LinearSales(this.year, this.sales);
}