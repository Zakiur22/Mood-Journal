import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:mood_journal/app_settings.dart';
import 'package:mood_journal/config.dart';
import 'package:mood_journal/presentation/injector/injector.dart';
import 'package:mood_journal/presentation/routes/routes.dart';
import 'package:mood_journal/presentation/theme/styling/theme_color_style.dart';
import 'package:mood_journal/presentation/utils/extension.dart';
import 'package:mood_journal/presentation/widgets/gradient_scaffold.dart';

class SplashScreen extends StatefulWidget implements Screen<SplashScreenRoute> {
  @override
  final SplashScreenRoute arg;

  const SplashScreen({super.key, required this.arg});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward().then((_) {
        final isFreshInstall = Injector.resolve<AppSettings>().isFreshInstall;
        if (isFreshInstall) {
          context.goToScreen(arg: const IntroScreenRoute());
        } else {
          context.goToScreen(arg: const HomeScreenRoute());
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = context.textTheme;
    final ThemeColorStyle themeColorStyle = context.themeColorStyle;
    final double deviceHeight = context.deviceHeight;

    return GradientScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Image(
              image: AssetImage('assets/icons/splash_screen_logo.png'),
              width: 115,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text('Starbook',
                style: textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: themeColorStyle.secondaryColor)),
            SizedBox(height: deviceHeight * 0.33),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, sanpshot) {
                if (!sanpshot.hasData) {
                  return const SizedBox();
                }
                return Text(
                  'v ${sanpshot.data!.version}-${kEnvironment.value}+${sanpshot.data!.buildNumber}',
                  style: textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                );
              },
            ),
            SizedBox(height: deviceHeight * 0.05),
          ],
        ),
      ),
    );
  }
}
