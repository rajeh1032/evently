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

class ForgetPassword extends StatelessWidget {
  static const String routeName = '/forget_password';
  ForgetPassword({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.forgot_password_2,
          style: AppStyles.bold20Black
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppAsset.resetPasswordImg,
              ),
              SizedBox(
                height: height * 0.07,
              ),
              CustomElvatedButton(
                backgroundColor: AppColors.primaryLight,
                onPressed: () {
                  //todo: add reset password Acc function
                },
                text: AppLocalizations.of(context)!.reset_password,
              ),
              SizedBox(
                height: height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
