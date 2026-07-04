import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_journal/domain/models/mood/mood.dart';
import 'package:mood_journal/domain/repository/mood_repo.dart';
import 'package:mood_journal/domain/repository/journal_repo.dart';
import 'package:mood_journal/presentation/cubits/analytiics_screen_cubit.dart';
import 'package:mood_journal/presentation/cubits/cubit_state/cubit_state.dart';
import 'package:mood_journal/presentation/injector/injector.dart';
import 'package:mood_journal/presentation/shared/legends_chart.dart';
import 'package:mood_journal/presentation/shared/loader.dart';
import 'package:mood_journal/presentation/theme/styling/theme_color_style.dart';
import 'package:mood_journal/presentation/utils/extension.dart';
import 'package:mood_journal/presentation/utils/padding_style.dart';
import 'package:mood_journal/presentation/widgets/doughnut_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MoodTrendData {
  final String label;
  final int count;

  const MoodTrendData(this.label, this.count);
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = context.textTheme;
    final ThemeColorStyle themeColorStyle = context.themeColorStyle;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: themeColorStyle.secondaryColor.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: textTheme.bodySmall!.copyWith(
                    color: themeColorStyle.tertiaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: textTheme.bodyMedium!.copyWith(
                    color: themeColorStyle.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeeklyAnalyticsTab extends StatelessWidget {
  const WeeklyAnalyticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = context.deviceHeight;
    final ThemeColorStyle themeColorStyle = context.themeColorStyle;
    final TextTheme textTheme = context.textTheme;

    return BlocProvider<AnalyticsScreenCubit>(
      create: (context) => AnalyticsScreenCubit(
        moodRepo: Injector.resolve<MoodRepo>(),
        journalRepo: Injector.resolve<JournalRepo>(),
      )..getMoodFrequencyByRange(
          start: DateTime.now().subtract(const Duration(days: 7)),
          end: DateTime.now()),
      child: BlocBuilder<AnalyticsScreenCubit, CubitState<AnalyticsData>>(
        builder: (context, state) {
          return state.when(
              initial: () => const SizedBox(),
              loading: () => const Loader(),
              loaded: (data) {
                final mood = data.moodFrequency;
                if (mood.info.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CustomPadding.mediumPadding),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: StatCard(
                                  title: 'Streak',
                                  value: '${data.streak} Days',
                                  icon: Icons.local_fire_department_rounded,
                                  iconColor: Colors.orange,
                                  backgroundColor: themeColorStyle.quinaryColor,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: StatCard(
                                  title: 'Points',
                                  value: '${data.point} pts',
                                  icon: Icons.star_rounded,
                                  iconColor: Colors.amber,
                                  backgroundColor: themeColorStyle.quinaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          MoodDoughnutChart(
                            isDataEmpty: true,
                            centerLabel: 'Weekly Mood',
                            moodDataMap: {
                              const Mood(
                                  id: '',
                                  label: 'Productive',
                                  color: 0xFF32C74F): 20,
                              const Mood(
                                  id: '', label: 'Angry', color: 0xFFFF3932): 20,
                              const Mood(
                                  id: '', label: 'Sick', color: 0xFFFF9600): 20,
                              const Mood(id: '', label: 'Sad', color: 0xFF565AC9):
                                  20,
                              const Mood(
                                  id: '', label: 'Happy', color: 0xFF0179FF): 20,
                            },
                          ),
                          SizedBox(height: deviceHeight * 0.05),
                          const SelectableTab(),
                          SizedBox(height: deviceHeight * 0.03),
                          const LegendsChart(),
                        ],
                      ),
                    ),
                  );
                }

                final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                final Map<int, int> countsByWeekday = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0};
                for (final journal in data.journals) {
                  final weekday = journal.createdAt.weekday;
                  countsByWeekday[weekday] = (countsByWeekday[weekday] ?? 0) + 1;
                }
                final List<MoodTrendData> weeklyTrends = List.generate(7, (index) {
                  final weekdayNum = index + 1;
                  return MoodTrendData(weekdays[index], countsByWeekday[weekdayNum] ?? 0);
                });

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: CustomPadding.mediumPadding),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                title: 'Streak',
                                value: '${data.streak} Days',
                                icon: Icons.local_fire_department_rounded,
                                iconColor: Colors.orange,
                                backgroundColor: themeColorStyle.quinaryColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: StatCard(
                                title: 'Points',
                                value: '${data.point} pts',
                                icon: Icons.star_rounded,
                                iconColor: Colors.amber,
                                backgroundColor: themeColorStyle.quinaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        MoodDoughnutChart(
                          moodDataMap: mood.info,
                          centerLabel: 'Weekly Mood',
                        ),
                        SizedBox(height: deviceHeight * 0.03),
                        const SelectableTab(),
                        SizedBox(height: deviceHeight * 0.02),
                        const LegendsChart(),
                        SizedBox(height: deviceHeight * 0.04),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: themeColorStyle.quinaryColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Weekly Mood Logging Trends',
                                style: textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: themeColorStyle.secondaryColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 200,
                                child: SfCartesianChart(
                                  plotAreaBorderWidth: 0,
                                  primaryXAxis: CategoryAxis(
                                    majorGridLines: const MajorGridLines(width: 0),
                                    axisLine: const AxisLine(width: 1),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    majorGridLines: MajorGridLines(
                                      color: themeColorStyle.secondaryColor.withValues(alpha: 0.1),
                                      dashArray: const [4, 4],
                                    ),
                                    axisLine: const AxisLine(width: 0),
                                    minimum: 0,
                                    interval: 1,
                                  ),
                                  tooltipBehavior: TooltipBehavior(enable: true),
                                  series: <CartesianSeries>[
                                    ColumnSeries<MoodTrendData, String>(
                                      dataSource: weeklyTrends,
                                      xValueMapper: (MoodTrendData d, _) => d.label,
                                      yValueMapper: (MoodTrendData d, _) => d.count,
                                      name: 'Logs',
                                      color: themeColorStyle.secondaryColor,
                                      borderRadius: BorderRadius.circular(6),
                                      gradient: LinearGradient(
                                        colors: [
                                          themeColorStyle.secondaryColor,
                                          themeColorStyle.secondaryColor.withValues(alpha: 0.7),
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                );
              },
              error: (e) => Text(e.toString()));
        },
      ),
    );
  }
}

class SelectableTab extends StatefulWidget {
  const SelectableTab({super.key});

  @override
  State<SelectableTab> createState() => _SelectableTabState();
}

class _SelectableTabState extends State<SelectableTab> {
  String _selectedTab = 'Mon';

  final List<String> _daysOfWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = context.textTheme;
    final ThemeColorStyle themeColorStyle = context.themeColorStyle;
    final double deviceHeight = context.deviceHeight;
    final double deviceWidth = context.deviceWidth;
    return BlocBuilder<AnalyticsScreenCubit, CubitState<AnalyticsData>>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _daysOfWeek.map((day) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTab = day;
                });
              },
              child: Container(
                width: deviceWidth * 0.105,
                height: deviceHeight * 0.03,
                decoration: BoxDecoration(
                  color: (day == _selectedTab)
                      ? themeColorStyle.secondaryColor
                      : themeColorStyle.secondaryColor.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                child: Text(
                  day,
                  style: textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: (day == _selectedTab)
                        ? themeColorStyle.quinaryColor
                        : themeColorStyle.secondaryColor,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
