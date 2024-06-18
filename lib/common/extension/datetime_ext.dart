extension DtimeExt on DateTime {
  String get stringify {
    // 16:00 2/16/23
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} ${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/${year.toString().padLeft(2, '0')}';
  }
}
