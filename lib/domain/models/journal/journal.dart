import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mood_journal/data/models/journal/journal.dart' as j;
import 'package:mood_journal/domain/models/mood/mood.dart';

part 'journal.freezed.dart';

@freezed
class Journal with _$Journal {
  const Journal._();
  const factory Journal({
    required final String id,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    required final Mood mood,
    required final String title,
    required final String memo,
  }) = _Journal;

  factory Journal.initial() => Journal(
        id: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        mood: Mood.initial(),
        title: '',
        memo: '',
      );

  factory Journal.fromLSJournal(
    j.Journal from,
  ) {
    return Journal(
      id: from.id,
      createdAt: from.createdAt,
      updatedAt: from.updatedAt,
      mood: Mood.fromLSMood(from.mood),
      title: from.title,
      memo: from.memo,
    );
  }
}

extension XJournal on Journal {
  j.Journal get toLSJournal {
    var journal = j.Journal(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        title: title,
        memo: memo);
    journal.mood = mood.toLSMood;
    return journal;
  }
}

@freezed
class JournalBody with _$JournalBody {
  const JournalBody._();
  const factory JournalBody({
    required final Mood mood,
    required final String title,
    required final String memo,
    final DateTime? createdAt,
  }) = _JournalBody;

  factory JournalBody.initial() => JournalBody(
        mood: Mood.initial(),
        title: '',
        memo: '',
      );

  factory JournalBody.fromJournal(Journal journal) => JournalBody(
        mood: journal.mood,
        title: journal.title,
        memo: journal.memo,
        createdAt: journal.createdAt,
      );

  factory JournalBody.fromLSJournal(j.Journal journal) => JournalBody(
      mood: Mood.fromLSMood(journal.mood),
      title: journal.title,
      memo: journal.memo,
      createdAt: journal.createdAt);
}

extension XJournalBody on JournalBody {
  j.JournalBody get toLSJournalBody {
    var journalBody = j.JournalBody(
      title: title,
      memo: memo,
      createdAt: createdAt,
      mood: mood.toLSMood,
    );
    return journalBody;
  }
}
