import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert' as JSON;



/// Create one series with sample hard coded data.
class GetData {

  int calc_ranks(ranks) {
    double multiplier = .5;
    return (multiplier * ranks).round();
  }


  static List<charts.Series<StockPrices, int>> getDataFromAPI(String company_name, Map SeriesData) {

    SeriesData.forEach((key,value) => print(value));


    var actual_stock_price = JSON.jsonDecode(SeriesData['-LdoaOp0TVgou15J3Wl3']['MSFT']['actual_stock_price']);
    var predicted_stock_price = JSON.jsonDecode(SeriesData['-LdoaOp0TVgou15J3Wl3']['MSFT']['predicted_stock_price']);

    //Call API to get data and then run it in for loops over here to get it done

    List<StockPrices> actualPrices = [];
    List<StockPrices> predictedPrices = [];




    for(int i=0; i< actual_stock_price.length; i++ ){
      actualPrices.add(StockPrices(i,actual_stock_price[i]));
      predictedPrices.add(StockPrices(i,predicted_stock_price[i]-actual_stock_price[i]));
    }




    // Generate 2 shades of each color so that we can style the line segments.
    final blue = charts.MaterialPalette.blue.makeShades(2);
    final red = charts.MaterialPalette.red.makeShades(2);

    return [
      new charts.Series<StockPrices, int>(
        id: 'Color Change',
        // Light shade for even years, dark shade for odd.
        colorFn: (StockPrices sales, _) =>
        sales.year % 2 == 0 ? blue[1] : blue[0],
        domainFn: (StockPrices sales, _) => sales.year,
        measureFn: (StockPrices sales, _) => sales.sales,
        data: actualPrices,
      ),
      new charts.Series<StockPrices, int>(
        id: 'Dash Pattern Change',
        colorFn: (StockPrices sales, _) =>
        sales.year % 2 == 0 ? red[1] : red[0],
        domainFn: (StockPrices sales, _) => sales.year,
        measureFn: (StockPrices sales, _) => sales.sales,
        data: predictedPrices,
      )
    ];
  }
}


/// Sample linear data type.
class StockPrices {
  final int year;
  final double sales;
  StockPrices(this.year, this.sales);
}