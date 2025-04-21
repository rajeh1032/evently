import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/onboarding/langauge_switch.dart';
import 'package:evently/ui/onboarding/on_boarding_screen.dart';
import 'package:evently/ui/onboarding/theme_switch.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:provider/provider.dart';

class HomeOnboardingScreen extends StatelessWidget {
  static const routeName = "HomeOnboardingScreen";
  const HomeOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var langaugeProvider = Provider.of<LanguageProvider>(context);
    final isEnglish = langaugeProvider.currentLanguage == "en";

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.057,
              ),
              Center(child: Image.asset(AppAsset.topLogo)),
              SizedBox(
                height: height * 0.033,
              ),
              Image.asset(
                themeProvider.currentTheme == ThemeMode.dark
                    ? AppAsset.onboardingImg1Dark
                    : AppAsset.onboardingImg1Light,
                width: double.infinity,
              ),
              SizedBox(
                height: height * 0.022,
              ),
              Text(
                AppLocalizations.of(context)!.personalize_your,
                style: AppStyles.bold20Primary,
              ),
              SizedBox(
                height: height * 0.022,
              ),
              Text(
                AppLocalizations.of(context)!.choose_your_preferred_theme,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: height * 0.022,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: AppStyles.bold20Primary,
                  ),
                  LangaugeSwitch(),
                ],
              ),
              SizedBox(
                height: height * 0.022,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: AppStyles.bold20Primary,
                  ),
                  ThemeSwitch(),
                ],
              ),
              SizedBox(
                height: height * 0.022,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, OnBoardingScreen.routeName);
                },
                child: Container(
                  width: double.infinity,
                  height: height * 0.066,
                  decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(18)),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.lets_start,
                      style: AppStyles.bold20White,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

