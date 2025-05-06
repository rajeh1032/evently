import 'package:evently/model/event.dart';
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
    Event event = ModalRoute.of(context)!.settings.arguments as Event;
    var eventProvider = Provider.of<EventProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

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
              icon: const ImageIcon(AssetImage(AppAsset.pinIcon),
                  color: AppColors.primaryLight)),
          IconButton(
              onPressed: () async {
    // Show confirmation dialog
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("delete_event"),
        content: Text("delete_event_confirmation"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
           "delete",
              style: const TextStyle(color: AppColors.redColor),
            ),
          ),
        ],
      ),
    );

    if (confirm ?? false) {
      try {
        final eventProvider = Provider.of<EventProvider>(context, listen: false);
        await eventProvider.deleteEvent(eventId:   event.id,uId: userProvider.user!.id);
        Navigator.pop(context); // Return to previous screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("event_deleted_successfully"),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("error_deleting_event"),
            backgroundColor: Colors.red,
          ),
        );
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
                  event.image,
                  fit: BoxFit.cover,
                  height: height * 0.25,
                  width: width,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(event.title, style: AppStyles.medium20Primary),
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
