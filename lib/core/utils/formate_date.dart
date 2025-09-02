String formatDate(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays == 0) {
    return 'Today';
  } else if (difference.inDays == 1) {
    return 'Yesterday';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  } else {
    return '${date.day}/${date.month}/${date.year}';
  }
}

String formatStringDate(String date) {
  try {
    // Split the date string into year, month, day
    List<String> parts = date.split('-');
    if (parts.length != 3) return date; // Return original if format is invalid

    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);

    // Map month numbers to abbreviated month names
    const Map<int, String> monthAbbreviations = {
      1: 'Jan',
      2: 'Feb',
      3: 'Mar',
      4: 'Apr',
      5: 'May',
      6: 'Jun',
      7: 'Jul',
      8: 'Aug',
      9: 'Sep',
      10: 'Oct',
      11: 'Nov',
      12: 'Dec',
    };

    // Get the abbreviated month name
    String monthAbbr = monthAbbreviations[month] ?? 'Invalid';

    // Format the day with leading zero if needed
    String formattedDay = day.toString().padLeft(2, '0');

    return '$formattedDay-$monthAbbr-$year';
  } catch (e) {
    // Return original date if parsing fails
    return date;
  }
}
