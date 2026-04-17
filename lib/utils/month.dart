enum Month {
  jan('Jan'),
  feb('Feb'),
  mar('Mar'),
  apr('Apr'),
  may('May'),
  jun('Jun'),
  jul('Jul'),
  aug('Aug'),
  sep('Sep'),
  oct('Oct'),
  nov('Nov'),
  dec('Dec');

  const Month(this.abbreviation);

  final String abbreviation;

  static String formatDate(DateTime date) {
    final month = Month.values[date.month - 1];
    return '${month.abbreviation} ${date.day}, ${date.year}';
  }
}
