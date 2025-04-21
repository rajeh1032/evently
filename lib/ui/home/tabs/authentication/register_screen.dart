import 'package:evently/providers/language_provider.dart';
import 'package:evently/ui/home/tabs/authentication/forget_password.dart';
import 'package:evently/ui/home/tabs/authentication/login_screen.dart';
import 'package:evently/ui/home/tabs/authentication/register_screen.dart';
import 'package:evently/ui/onboarding/langauge_switch.dart';
import 'package:evently/ui/widget/custom_elvated_button.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register';
  RegisterScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Image.asset(
                AppAsset.logo,
                width: width * 0.8,
                height: height * 0.3,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.name,
                prefixIcon: Image.asset(
                  AppAsset.personIcon,
                ),
                controller: emailController,
                validator: (text) {
                  //todo: add email name validation
                },
              ),
              SizedBox(
                height: height * 0.01,
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.email,
                prefixIcon: Image.asset(
                  AppAsset.emailIcon,
                ),
                controller: emailController,
                validator: (text) {
                  //todo: add email validator
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: Image.asset(
                  AppAsset.lockIcon,
                ),
                suffixIcon: Image.asset(
                  AppAsset.eyeSlashIcon,
                ),
                controller: passwordController,
                validator: (text) {
                  //todo: add password validator
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.re_password,
                prefixIcon: Image.asset(
                  AppAsset.lockIcon,
                ),
                suffixIcon: Image.asset(
                  AppAsset.eyeSlashIcon,
                ),
                controller: passwordController,
                validator: (text) {
                  //todo: re password validator
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomElvatedButton(
                backgroundColor: AppColors.primaryLight,
                onPressed: () {
                  //todo: add create Acc function
                },
                text: AppLocalizations.of(context)!.create_account,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.already_have_an_account,
                    style: AppStyles.medium16Black.copyWith(
                      color: Theme.of(context).hoverColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: AppStyles.bold16Primary.copyWith(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryLight,
                        decorationThickness: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LangaugeSwitch(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
