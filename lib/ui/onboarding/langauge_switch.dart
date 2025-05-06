import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LangaugeSwitch extends StatelessWidget {
  const LangaugeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    var langaugeProvider = Provider.of<LanguageProvider>(context);
    final isEnglish = langaugeProvider.currentLanguage == "en";
    return AnimatedToggleSwitch.rolling(
      current: isEnglish,
      values: const [false, true],
      onChanged: (value) {
        langaugeProvider.changeLangauge(value ? "en" : "ar");
      },
      iconBuilder: (val, size) {
        return val
            ? Image.asset(AppAsset.amircaFlag)
            : Image.asset(AppAsset.EgyptFlag);
      },
      style: ToggleStyle(
        backgroundColor: Colors.transparent,
        indicatorColor: AppColors.primaryLight,
        borderColor: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(60),
      ),
      height: 40,
      indicatorSize: const Size.square(45),
    );
  }
}
