import 'package:evently/firebase_utils.dart';
import 'package:evently/model/my_user.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/home_screen.dart';
import 'package:evently/ui/home/tabs/authentication/forget_password.dart';
import 'package:evently/ui/home/tabs/authentication/login_screen.dart';
import 'package:evently/ui/home/tabs/authentication/register_screen.dart';
import 'package:evently/ui/onboarding/langauge_switch.dart';
import 'package:evently/ui/widget/custom_elvated_button.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/dailog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController =
      TextEditingController(text: 'ahmed@gmail.com');
  TextEditingController nameController = TextEditingController(text: 'ahmed');

  TextEditingController passwordController =
      TextEditingController(text: '123456');
  TextEditingController RepasswordController =
      TextEditingController(text: '123456');
  bool obscureStatus = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.name,
                  prefixIcon: Image.asset(
                    AppAsset.personIcon,
                  ),
                  controller: nameController,
                  validator: (text) {
                    //todo: add name validation
                    if (text == null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!
                          .please_enter_your_name;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.email,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Image.asset(
                    AppAsset.emailIcon,
                  ),
                  controller: emailController,
                  validator: (text) {
                    //todo: add email validator
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
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
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
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                  keyboardType: TextInputType.visiblePassword,
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
                  controller: RepasswordController,
                  validator: (text) {
                    //todo: re password validator
                    if (text != passwordController.text) {
                      return AppLocalizations.of(context)!
                          .please_enter_your_retype_password;
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomElvatedButton(
                  backgroundColor: AppColors.primaryLight,
                  onPressed: () {
                    //todo: add create Acc function
                    register(context);
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

  void register(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      //todo: show loading
      DailogUtils.showLoading(context: context, message: "Loading..");
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //todo:Save User To fireStore
        MyUser myUser = MyUser(
            email: emailController.text,
            id: credential.user?.uid ?? "",
            name: nameController.text);
        await FirebaseUtils.addUserToFireStore(myUser);
        //todo add user to provider
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);
        //todo:change index of event list
        var eventProvider = Provider.of<EventProvider>(context, listen: false);
        eventProvider.changeSelectdIndex(0, userProvider.user!.id, context);
        //todo: hide loading
        DailogUtils.hideLoading(context);
        //todo: show message
        DailogUtils.showMessage(
            context: context,
            message: AppLocalizations.of(context)!.account_created_successfully,
            posActionName: 'Ok',
            posAction: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName,
                (Route<dynamic> route) => false,
              );
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo: hide loading
          DailogUtils.hideLoading(context);
          //todo: show message
          DailogUtils.showMessage(
            context: context,
            message: "weak-password",
            title: 'Error',
            posActionName: 'Ok',
          );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          //todo: hide loading
          DailogUtils.hideLoading(context);
          //todo: show message
          DailogUtils.showMessage(
            context: context,
            message: "The account already exists for that email.e",
            title: 'Error',
            posActionName: 'Ok',
          );
          print('The account already exists for that email.');
        }
      } catch (e) {
        DailogUtils.hideLoading(context);
        //todo: show message
        DailogUtils.showMessage(
          context: context,
          message: "The account already exists for that email.e",
          title: 'Error',
          posActionName: 'Ok',
        );
        print(e.toString());
      }
    }
  }
}
