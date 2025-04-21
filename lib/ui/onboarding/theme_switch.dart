import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.currentTheme == ThemeMode.dark;
    return AnimatedToggleSwitch.rolling(
      current: isDark,
      values: [false, true],
      onChanged: (value) {
        themeProvider.changeTheme(value ? ThemeMode.dark : ThemeMode.light);
      },
      iconBuilder: (val, size) {
        return Icon(
          val ? Icons.dark_mode : Icons.light_mode,
          color: Colors.white,
          size: 24,
        );
      },
      style: ToggleStyle(
        backgroundColor: Colors.black26,
        indicatorColor: AppColors.primaryLight,
        borderColor: Colors.white12,
        borderRadius: BorderRadius.circular(30),
      ),
      height: 50,
      indicatorSize: const Size.square(45),
    );
  }
}
