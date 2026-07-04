import 'package:flutter/material.dart';
import 'package:mood_journal/presentation/routes/routes.dart';
import 'package:mood_journal/presentation/screen/calendar/custom_calendar.dart';
import 'package:mood_journal/presentation/shared/app_bar.dart';
import 'package:mood_journal/presentation/widgets/gradient_scaffold.dart';

class YearScreen extends StatelessWidget implements Screen<YearScreenRoute> {
  @override
  final YearScreenRoute arg;

  const YearScreen({super.key, required this.arg});

  @override
  Widget build(BuildContext context) {
    return const GradientScaffold(
      appBar: PrimaryAppBar(
        showLeading: false,
        centerTitle: 'Year',
      ),
      body: CustomCalendar(),
    );
  }
}
