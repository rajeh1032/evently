import 'package:evently/ui/home/tabs/authentication/login_screen.dart';
import 'package:evently/ui/widget/custom_elvated_button.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/dailog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPassword extends StatelessWidget {
  static const String routeName = '/forget_password';
  ForgetPassword({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late var userEmail;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    userEmail = ModalRoute.of(context)!.settings.arguments as String;
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
                  resetPassword(context);
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

  Future<void> resetPassword(BuildContext context) async {
    try {
      DailogUtils.showLoading(
          context: context, message: "Sending reset link...");
      await FirebaseAuth.instance.sendPasswordResetEmail(email: userEmail);
      if (context.mounted) {
        DailogUtils.hideLoading(context);
        DailogUtils.showMessage(
          context: context,
          message: "Password reset link sent to your email",
          title: "Success",
          posActionName: "Back to Login",
          posAction: () {
            // Replace with pushNamedAndRemoveUntil to clear history
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.routeName,
              (route) => false, // This removes all previous routes
            );
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        DailogUtils.hideLoading(context);
        DailogUtils.showMessage(
          context: context,
          message: "An unexpected error occurred",
          title: "Error",
          posActionName: "OK",
        );
      }
    }
  }
}
