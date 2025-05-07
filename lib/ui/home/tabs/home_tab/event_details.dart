import 'package:evently/model/event.dart';
import 'package:evently/providers/current_event.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/tabs/home_tab/edit_even.dart';
import 'package:evently/ui/widget/custom_location_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:provider/provider.dart';

class EventDetails extends StatelessWidget {
  static const routeName = '/event_details';
  EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var eventProvider = Provider.of<EventProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    if (userProvider.user == null) {
      return const Center(
        child: Text('Please login to view events'),
      );
    }
    var currentEventProvider = Provider.of<CurrentEvent>(context);
    var event = currentEventProvider.currentEvent;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: AppStyles.medium20Primary,
        ),
        actions: [
          ///todo: edit button
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditEven.routeName);
              },
              icon: const ImageIcon(AssetImage(AppAsset.pinIcon),
                  color: AppColors.primaryLight)),

          ///todo: delete button
          IconButton(
              onPressed: () async {
                try {
                  await eventProvider.deleteEvent(
                      eventId: event!.id, uId: userProvider.user!.id);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }
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
                  event!.image,
                  fit: BoxFit.cover,
                  height: height * 0.25,
                  width: width,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(event!.title, style: AppStyles.medium20Primary),
              SizedBox(
                height: height * 0.02,
              ),
              CustomLocationButton(
                firstText: DateFormat('dd/MMM/yyyy').format(event.dateTime),
                secondText: event.time,
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
                event.discription,
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
