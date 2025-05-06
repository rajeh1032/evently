import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/home/tabs/authentication/login_screen.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:evently/ui/home/home_screen.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String routeName = "on_boarding_screen";

  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    bool isRTL = languageProvider.currentLanguage == 'ar' ? true : false;

    return IntroductionScreen(
      pages: [
        PageViewModel(
          titleWidget: Image.asset(
            AppAsset.topLogo,
          ),
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppAsset.onboardingImg2Light,
                width: double.infinity,
              ),
              SizedBox(height: height * 0.071),
              Text(AppLocalizations.of(context)!.find_events_inspire,
                  style: AppStyles.bold20Primary),
              SizedBox(height: height * 0.033),
              Text(AppLocalizations.of(context)!.dive_into_a_world_of_events,
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          decoration: PageDecoration(
            pageColor: themeProvider.currentTheme == ThemeMode.dark
                ? AppColors.primaryDark
                : AppColors.whiteColor,
          ),
        ),
        PageViewModel(
          titleWidget: Image.asset(
            AppAsset.topLogo,
          ),
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppAsset.onboardingImg3Light,
                width: double.infinity,
              ),
              SizedBox(height: height * 0.071),
              Text(AppLocalizations.of(context)!.effortless_event_planning,
                  style: AppStyles.bold20Primary),
              SizedBox(height: height * 0.033),
              Text(
                  AppLocalizations.of(context)!
                      .take_the_hassle_out_of_organizing,
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          decoration: PageDecoration(
            pageColor: themeProvider.currentTheme == ThemeMode.dark
                ? AppColors.primaryDark
                : AppColors.whiteColor,
          ),
        ),
        PageViewModel(
          titleWidget: Image.asset(
            AppAsset.topLogo,
          ),
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppAsset.onboardingImg4Light,
                width: double.infinity,
              ),
              SizedBox(height: height * 0.071),
              Text(
                  AppLocalizations.of(context)!
                      .connect_with_friends_and_share_moments,
                  style: AppStyles.bold20Primary),
              SizedBox(height: height * 0.033),
              Text(AppLocalizations.of(context)!.make_every_event_memorable,
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          decoration: PageDecoration(
            pageColor: themeProvider.currentTheme == ThemeMode.dark
                ? AppColors.primaryDark
                : AppColors.whiteColor,
          ),
        ),
      ],
      onDone: () {
        Navigator.popAndPushNamed(context, LoginScreen.routeName);
      },
      onSkip: () {
        Navigator.of(context).pushReplacementNamed('/home');
      },
      // Conditionally set next button icon based on RTL
      next: (Text(
        AppLocalizations.of(context)!.next,
        style: AppStyles.bold20Primary,
      )),
      showBackButton: true,
      back: (Text(
        AppLocalizations.of(context)!.back,
        style: AppStyles.bold20Primary,
      )),
      done: Text(
          AppLocalizations.of(context)!.finish, // Use localized "Finish" text
          style: AppStyles.bold20Primary),
      dotsDecorator: DotsDecorator(
        size: const Size(8.0, 8.0),
        color: themeProvider.currentTheme == ThemeMode.dark
            ? AppColors.whiteColor
            : AppColors.blackColor,
        activeColor: AppColors.primaryLight,
        activeSize: const Size(16.0, 8.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      showSkipButton: false,
      globalBackgroundColor: themeProvider.currentTheme == ThemeMode.dark
          ? AppColors.primaryDark
          : AppColors.whiteColor,
    );
  }
}
