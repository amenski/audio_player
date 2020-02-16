class DateUtil {

  dateUtcInMilliSinceEpoch() {
    return dateInUtc(DateTime.now()).millisecondsSinceEpoch;
  }

  dateInUtc(DateTime dateTime) {
    return dateTime.toUtc();
  }


  /// DateUtil instantiation
  static DateUtil _instance = DateUtil._internal();
  factory DateUtil() => _instance;
  DateUtil._internal();

}