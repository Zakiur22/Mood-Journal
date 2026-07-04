import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_book/domain/models/mood/mood.dart';
import 'package:star_book/domain/repository/mood_repo.dart';
import 'package:star_book/domain/repository/journal_repo.dart';
import 'package:star_book/presentation/cubits/analytiics_screen_cubit.dart';
import 'package:star_book/presentation/cubits/cubit_state/cubit_state.dart';
import 'package:star_book/presentation/injector/injector.dart';
import 'package:star_book/presentation/shared/legends_chart.dart';
import 'package:star_book/presentation/shared/loader.dart';
import 'package:star_book/presentation/theme/styling/theme_color_style.dart';
import 'package:star_book/presentation/utils/extension.dart';
import 'package:star_book/presentation/utils/padding_style.dart';
import 'package:star_book/presentation/widgets/doughnut_chart.dart';
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

class MonthlyAnalyticsTab extends StatelessWidget {
  const MonthlyAnalyticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = context.deviceHeight;
    final ThemeColorStyle themeColorStyle = context.themeColorStyle;
    final TextTheme textTheme = context.textTheme;
    final currentDate = DateTime.now();

    return BlocProvider<AnalyticsScreenCubit>(
      create: (context) => AnalyticsScreenCubit(
        moodRepo: Injector.resolve<MoodRepo>(),
        journalRepo: Injector.resolve<JournalRepo>(),
      )..getMoodFrequencyByMonth(
          month: currentDate.month, year: currentDate.year),
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
                            centerLabel: 'Monthly Mood',
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

                final int daysInMonth = DateUtils.getDaysInMonth(currentDate.year, currentDate.month);
                final Map<int, int> countsByDay = {};
                for (int i = 1; i <= daysInMonth; i++) {
                  countsByDay[i] = 0;
                }
                for (final journal in data.journals) {
                  final day = journal.createdAt.day;
                  countsByDay[day] = (countsByDay[day] ?? 0) + 1;
                }
                final List<MoodTrendData> monthlyTrends = List.generate(daysInMonth, (index) {
                  final dayNum = index + 1;
                  return MoodTrendData(dayNum.toString(), countsByDay[dayNum] ?? 0);
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
                          centerLabel: 'Monthly Mood',
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
                                'Monthly Mood Logging Trends',
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
                                    labelStyle: const TextStyle(fontSize: 8),
                                    interval: 5, // Show labels every 5 days for premium clean aesthetic
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
                                    SplineAreaSeries<MoodTrendData, String>(
                                      dataSource: monthlyTrends,
                                      xValueMapper: (MoodTrendData d, _) => d.label,
                                      yValueMapper: (MoodTrendData d, _) => d.count,
                                      name: 'Logs',
                                      color: themeColorStyle.secondaryColor.withValues(alpha: 0.2),
                                      borderColor: themeColorStyle.secondaryColor,
                                      borderWidth: 2,
                                      gradient: LinearGradient(
                                        colors: [
                                          themeColorStyle.secondaryColor.withValues(alpha: 0.4),
                                          themeColorStyle.secondaryColor.withValues(alpha: 0.0),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
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
  String selectedMonths = 'Jan';

  final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];

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
          children: months.map((month) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedMonths = month;
                });
              },
              child: Container(
                width: deviceWidth * 0.105,
                height: deviceHeight * 0.03,
                decoration: BoxDecoration(
                  color: (month == selectedMonths)
                      ? themeColorStyle.secondaryColor
                      : themeColorStyle.secondaryColor.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                child: Text(
                  month,
                  style: textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: (month == selectedMonths)
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
