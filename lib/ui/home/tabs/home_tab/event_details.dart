import 'package:evently/ui/home/tabs/home_tab/edit_even.dart';
import 'package:evently/ui/widget/custom_location_button.dart';
import 'package:flutter/material.dart';
import 'package:evently/ui/home/tabs/home_tab/event_date_or_time.dart';
import 'package:evently/ui/home/tabs/home_tab/event_item.dart';
import 'package:evently/ui/home/tabs/home_tab/event_tab.dart';
import 'package:evently/ui/widget/custom_elvated_button.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatelessWidget {
  static const routeName = '/event_details';
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: AppStyles.medium20Primary,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditEven.routeName);
              },
              icon: ImageIcon(AssetImage(AppAsset.pinIcon),
                  color: AppColors.primaryLight)),
          IconButton(
              onPressed: () {
                //todo : add delete event function
              },
              icon: const ImageIcon(AssetImage(AppAsset.recycleIcon),
                  color: AppColors.redColor)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  AppAsset.sportBG,
                  fit: BoxFit.cover,
                  height: height * 0.25,
                  width: width,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text("We Are Going To Play Football",
                  style: AppStyles.medium20Primary),
              SizedBox(
                height: height * 0.02,
              ),
              CustomLocationButton(
                firstText: "21 November 2024 ",
                secondText: "12:12PM",
                leadingIconImage: AppAsset.calenderIcon,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomLocationButton(
                firstText: "Cairo , Egypt",
                leadingIconImage: AppAsset.locationIcon,
                suffixIcon: true,
                onTap: () {
                  //todo: open map
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Image.asset("assets/images/map.png"),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                AppLocalizations.of(context)!.description,
                style: AppStyles.bold16Primary.copyWith(
                  color: Theme.of(context).hoverColor,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit eget neque senectus a. Nulla at non malesuada odio duis lectus amet nisi sit. Risus hac enim maecenas auctor et. At cras massa diam porta facilisi lacus purus. Iaculis eget quis ut amet. Sit ac malesuada nisi quis  feugiat.",
                style: AppStyles.medium16Black,
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
