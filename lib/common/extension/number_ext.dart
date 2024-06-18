extension NumberExt on num {
  String get asRp {
    return 'Rp. ${toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')},-';
  }

  // number to duration seconds,minutes,hours,days,weeks,months,years
  Duration get seconds {
    // if is 5.5 then 5 seconds and 500 milliseconds and if is 5 then 5 seconds
    final seconds = toInt();
    final milliseconds = ((this - seconds) * 1000).toInt();
    return Duration(seconds: seconds, milliseconds: milliseconds);
  }

  Duration get minutes {
    // if is 5.5 then 5 minutes and 30 seconds and if is 5 then 5 minutes
    final minutes = toInt();
    final seconds = ((this - minutes) * 60).toInt();
    return Duration(minutes: minutes, seconds: seconds);
  }

  Duration get hours {
    // if is 5.5 then 5 hours and 30 minutes and if is 5 then 5 hours
    final hours = toInt();
    final minutes = ((this - hours) * 60).toInt();
    return Duration(hours: hours, minutes: minutes);
  }

  Duration get days {
    // if is 5.5 then 5 days and 12 hours and if is 5 then 5 days
    final days = toInt();
    final hours = ((this - days) * 24).toInt();
    return Duration(days: days, hours: hours);
  }
}
