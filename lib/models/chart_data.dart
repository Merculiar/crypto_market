class ChartData {
  ChartData({this.date, this.price});

  DateTime? date;
  double? price;

  ChartData.fromList(List<dynamic> list) {
    date = DateTime.fromMillisecondsSinceEpoch(list[0]);
    price = list[1].toDouble();
  }
}
