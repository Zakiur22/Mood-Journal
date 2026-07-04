import 'package:isar/isar.dart';
import 'package:mood_journal/data/models/user/user.dart';

import '../models/journal/journal.dart';
import '../models/mood/mood.dart';

abstract class LocalDatabase {
  static Future<void> initialise({required String directory}) async {
    await Isar.open(
      [
        JournalSchema,
        MoodSchema,
        UserSchema,
      ],
      directory: directory,
    );
  }

  static Future<bool> clear() async {
    final isar = Isar.getInstance()!;
    return isar.close(deleteFromDisk: true);
  }
}
