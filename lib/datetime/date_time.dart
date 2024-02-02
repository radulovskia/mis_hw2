class DateTimeService {
  static final DateTimeService _instance = DateTimeService._internal();

  DateTimeService._internal();

  factory DateTimeService() {
    return _instance;
  }

  String todaysDateYYYYMMDD() {
    return convertDateTimeToYYYYMMDD(DateTime.now());
  }

  DateTime createDateTimeObject(String yyyymmdd) {
    int yyyy = int.parse(yyyymmdd.substring(0, 4));
    int mm = int.parse(yyyymmdd.substring(4, 6));
    int dd = int.parse(yyyymmdd.substring(6, 8));

    DateTime dateTimeObject = DateTime(yyyy, mm, dd);
    return dateTimeObject;
  }

  String convertDateTimeToYYYYMMDD(DateTime dateTime) {
    String year = dateTime.year.toString();

    String month = dateTime.month.toString();
    if (month.length == 1) {
      month = '0$month';
    }

    String day = dateTime.day.toString();
    if (day.length == 1) {
      day = '0$day';
    }

    String yyyymmdd = year + month + day;

    return yyyymmdd;
  }

}