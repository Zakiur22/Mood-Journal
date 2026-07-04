import 'package:star_book/data/models/journal/journal.dart';
import 'package:star_book/domain/models/mood/mood.dart';

typedef Frequency = int;

class MoodFrequency {
  late Map<Mood, Frequency> info;

  MoodFrequency.fromJournal({required List<Journal> journals}) {
    info = {};
    for (final journal in journals) {
      final domainMood = Mood.fromLSMood(journal.mood);
      if (info.containsKey(domainMood)) {
        info[domainMood] = info[domainMood]! + 1;
      } else {
        info[domainMood] = 1;
      }
    }
  }
}
