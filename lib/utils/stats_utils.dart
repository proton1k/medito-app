import 'package:shared_preferences/shared_preferences.dart';

enum UnitType { day, min }

String getUnits(UnitType type, int value) {
  switch (type) {
    case UnitType.day:
      return  value == 1 ? 'day' : 'days';
      break;
    case UnitType.min:
      return  value == 1 ? 'min' : 'mins';
      break;
  }
}

Future<String> getCurrentStreak() async {
  var prefs = await SharedPreferences.getInstance();


  var streak = prefs.getInt('streakCount');
  if (streak == null)
    return '0';
  else
    return streak.toString();
}

Future<int> _getCurrentStreakInt() async {
  var prefs = await SharedPreferences.getInstance();

  var streak = prefs.getInt('streakCount');
  return streak ?? 0;
}

void updateMinuteCounter(int additionalSecs) async {
  var prefs = await SharedPreferences.getInstance();

  var current = await _getSecondsListened();
  var plusOne = current + additionalSecs;
  prefs.setInt('secsListened', plusOne);
}

void updateStreak({String streak = ''}) async {
  var prefs = await SharedPreferences.getInstance();

  if (streak.isNotEmpty) {
    prefs.setInt('streakCount', int.parse(streak));
    _updateLongestStreak(int.parse(streak), prefs);
    return;
  }

  List<String> streakList = prefs.getStringList('streakList');
  int streakCount = prefs.getInt('streakCount');

  if (streakList == null) {
    streakList = [];
  }
  if (streakCount == null) {
    streakCount = 0;
  }

  if (streakList.length > 0) {
    //if you have meditated before, was it on today? if not, increase counter
    final lastDayInStreak =
    DateTime.fromMillisecondsSinceEpoch(int.parse(streakList.last));
    final now = DateTime.now();

    if (!isSameDay(lastDayInStreak, now)) {
      incrementStreakCounter(streakCount);
    }
  } else {
    //if you've never done one before
    incrementStreakCounter(streakCount);
  }

  streakList.add(DateTime
      .now()
      .millisecondsSinceEpoch
      .toString());
  prefs.setStringList('streakList', streakList);
}

Future<void> incrementStreakCounter(int streakCount,) async {
  var prefs = await SharedPreferences.getInstance();

  streakCount++;
  prefs.setInt('streakCount', streakCount);

  //update longestStreak
  await _updateLongestStreak(streakCount, prefs);
}

Future _updateLongestStreak(int streakCount, SharedPreferences prefs) async {
  //update longestStreak
  var longest = await _getLongestStreakInt();
  if (streakCount > longest) {
    prefs.setInt('longestStreak', streakCount);
  }
}

Future<String> getMinutesListened() async {
  var prefs = await SharedPreferences.getInstance();

  var streak = prefs.getInt('secsListened');
  if (streak == null)
    return '0';
  else
    return Duration(seconds: streak).inMinutes.toString();
}

Future<int> _getSecondsListened() async {
  var prefs = await SharedPreferences.getInstance();

  var streak = prefs.getInt('secsListened');
  if (streak == null)
    return 0;
  else
    return streak;
}

Future<String> getLongestStreak() async {
  var prefs = await SharedPreferences.getInstance();

  if (await _getLongestStreakInt() < await _getCurrentStreakInt()) {
    return getCurrentStreak();
  }

  var streak = prefs.getInt('longestStreak');
  if (streak == null)
    return '0';
  else
    return streak.toString();
}

Future<int> _getLongestStreakInt() async {
  var prefs = await SharedPreferences.getInstance();

  var streak = prefs.getInt('longestStreak');
  return streak ?? 0;
}

Future<String> getNumSessions() async {
  var prefs = await SharedPreferences.getInstance();

  if (prefs == null) return '...';

  var streak = prefs.getInt('numSessions');
  if (streak == null)
    return '0';
  else
    return streak.toString();
}

Future<int> _getNumSessionsInt() async {
  var prefs = await SharedPreferences.getInstance();

  var streak = prefs.getInt('numSessions');
  return streak ?? 0;
}

void incrementNumSessions() async {
  var prefs = await SharedPreferences.getInstance();

  var current = await _getNumSessionsInt();
  current++;
  prefs.setInt('numSessions', current);
}

bool isSameDay(DateTime day1, DateTime day2) {
  return day1.year == day2.year &&
      day1.month == day2.month &&
      day1.day == day2.day;
}