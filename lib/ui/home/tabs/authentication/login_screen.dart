import 'package:evently/firebase_utils.dart';
import 'package:evently/model/my_user.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/home_screen.dart';
import 'package:evently/ui/home/tabs/authentication/forget_password.dart';
import 'package:evently/ui/home/tabs/authentication/register_screen.dart';
import 'package:evently/ui/onboarding/langauge_switch.dart';
import 'package:evently/ui/widget/custom_elvated_button.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/dailog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: 'ahmed@gmail.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscureStatus = true;
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
          child: Form(
            key: formKey,
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

                ///################################################################################
                CustomTextField(
                    hintText: AppLocalizations.of(context)!.email,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Image.asset(
                      AppAsset.emailIcon,
                    ),
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return AppLocalizations.of(context)!
                            .please_enter_your_email;
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);

                      if (!emailValid) {
                        return AppLocalizations.of(context)!
                            .please_enter_valid_email;
                      }
                      return null;
                    }),
                SizedBox(
                  height: height * 0.02,
                ),

                ///################################################################################
                CustomTextField(
                  keyboardType: TextInputType.visiblePassword,
                  hintText: AppLocalizations.of(context)!.password,
                  obscureText: obscureStatus,
                  obscuringCharacter: "*",
                  prefixIcon: Image.asset(
                    AppAsset.lockIcon,
                  ),
                  suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          obscureStatus = !obscureStatus;
                        });
                      },
                      child: obscureStatus == false
                          ? const Icon(
                              Icons.visibility,
                              color: AppColors.greyColor,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: AppColors.greyColor,
                            )),
                  controller: passwordController,
                  validator: (text) {
                    //todo: add password validator
                    if (text == null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!
                          .please_enter_your_password;
                    }
                    if (text.length < 6) {
                      return AppLocalizations.of(context)!
                          .password_is_too_short;
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //todo: add forget password
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ForgetPassword.routeName,
                            arguments: emailController.text);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.forgot_password,
                        style: AppStyles.bold16Primary.copyWith(
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryLight,
                          decorationThickness: 2.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),

                ///################################################################################
                CustomElvatedButton(
                  backgroundColor: AppColors.primaryLight,
                  onPressed: () {
                    //todo: add login function
                    login();
                    // Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  text: AppLocalizations.of(context)!.login,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dont_have_an_account,
                      style: AppStyles.medium16Black.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).hoverColor,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.create_account,
                        style: AppStyles.bold16Primary.copyWith(
                          fontSize: 14,
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
                  children: [
                    const Expanded(
                      child: Divider(
                        endIndent: 15,
                        indent: 15,
                        color: AppColors.primaryLight,
                        thickness: 1,
                      ),
                    ),
                    Text(AppLocalizations.of(context)!.or,
                        style: AppStyles.bold16Primary),
                    const Expanded(
                      child: Divider(
                        endIndent: 15,
                        indent: 15,
                        color: AppColors.primaryLight,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.02,
                ),

                ///################################################################################
                InkWell(
                  onTap: () {
                    //todo: add google login function
                  },
                  child: Container(
                    height: height * 0.075,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: AppColors.primaryLight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAsset.googleIcon),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Text(AppLocalizations.of(context)!.login_with_google,
                            style: AppStyles.medium20Primary),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LangaugeSwitch(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      //totdo: show loading
      DailogUtils.showLoading(context: context, message: "Loading...");
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        //todo readUser From FireStore
        MyUser? user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? "");
        if (user == null) {
          return;
        }
        //todo add user to provider
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        //todo:change index of event list
        var eventProvider = Provider.of<EventProvider>(context, listen: false);
        eventProvider.changeSelectdIndex(0, userProvider.user!.id, context);

        //todo: hide loading
        DailogUtils.hideLoading(context);
        //todo: show message
        DailogUtils.showMessage(
          context: context,
          message: "Login Successfully",
          posActionName: 'Ok',
          posAction: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              HomeScreen.routeName,
              (Route<dynamic> route) => false,
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        } else if (e.code == 'invalid-credential') {
          DailogUtils.hideLoading(context);
          //todo: show message
          DailogUtils.showMessage(
            context: context,
            title: 'Error',
            posActionName: 'Ok',
            message: "invalid-credential",
          );
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        DailogUtils.hideLoading(context);
        //todo: show message
        DailogUtils.showMessage(
          context: context,
          title: 'Error',
          posActionName: 'Ok',
          message: "invalid-credential",
        );
        print(e.toString());
      }
    }
  }
}
