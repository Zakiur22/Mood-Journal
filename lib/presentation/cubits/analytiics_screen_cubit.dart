import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_journal/domain/models/journal/journal.dart';
import 'package:mood_journal/domain/models/mood/mood_frequency.dart';
import 'package:mood_journal/domain/repository/mood_repo.dart';
import 'package:mood_journal/domain/repository/journal_repo.dart';
import 'package:mood_journal/presentation/cubits/cubit_state/cubit_state.dart';

class AnalyticsData {
  final MoodFrequency moodFrequency;
  final List<Journal> journals;
  final int streak;
  final int point;

  const AnalyticsData({
    required this.moodFrequency,
    required this.journals,
    required this.streak,
    required this.point,
  });
}

class AnalyticsScreenCubit extends Cubit<CubitState<AnalyticsData>> {
  final MoodRepo moodRepo;
  final JournalRepo journalRepo;

  AnalyticsScreenCubit({
    required this.moodRepo,
    required this.journalRepo,
  }) : super(const InitialState());

  Future<void> getMoodFrequencyByMonth(
      {required int month, required int year}) async {
    emit(const LoadingState());
    try {
      final moodFreq =
          await moodRepo.getMoodFrequencyByMonth(month: month, year: year);
      final journals = await journalRepo.getJournalByMonth(month, year);
      final streak = await journalRepo.streak();
      final point = await journalRepo.point();
      emit(LoadedState(AnalyticsData(
        moodFrequency: moodFreq,
        journals: journals,
        streak: streak,
        point: point,
      )));
    } catch (e) {
      emit(ErrorState(e is Exception ? e : Exception(e.toString())));
    }
  }

  Future<void> getMoodFrequencyByRange(
      {required DateTime start, required DateTime end}) async {
    emit(const LoadingState());
    try {
      final moodFreq = await moodRepo.getMoodFrequencyByRange(start: start, end: end);
      final journals = await journalRepo.getJournalByRange(start, end);
      final streak = await journalRepo.streak();
      final point = await journalRepo.point();
      emit(LoadedState(AnalyticsData(
        moodFrequency: moodFreq,
        journals: journals,
        streak: streak,
        point: point,
      )));
    } catch (e) {
      emit(ErrorState(e is Exception ? e : Exception(e.toString())));
    }
  }
}
