import 'package:evently/firebase_utils.dart';
import 'package:evently/model/event.dart';
import 'package:evently/ui/home/tabs/home_tab/event_date_or_time.dart';
import 'package:evently/ui/home/tabs/home_tab/event_item.dart';
import 'package:evently/ui/home/tabs/home_tab/event_tab.dart';
import 'package:evently/ui/widget/custom_elvated_button.dart';
import 'package:evently/ui/widget/custom_location_button.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  static const String routeName = '/addEvent';
  AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selected = 0;
  var selectedDate;
  String? formatedDate;
  var selectedTime;
  String? formatedTime;
  late String selectedImage;
  late String selectedEventName;

  var formKey = GlobalKey<FormState>();
  TextEditingController titleControler = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<Map<String, dynamic>> eventsList = [
      {
        "name": AppLocalizations.of(context)!.sport,
        "icon": Bootstrap.balloon,
      },
      {
        "name": AppLocalizations.of(context)!.birthday,
        "icon": Bootstrap.gift,
      },
      {
        "name": AppLocalizations.of(context)!.meeting,
        "icon": Bootstrap.people,
      },
      {
        "name": AppLocalizations.of(context)!.gaming,
        "icon": Bootstrap.controller,
      },
      {
        "name": AppLocalizations.of(context)!.workshop,
        "icon": Bootstrap.tools,
      },
      {
        "name": AppLocalizations.of(context)!.book_club,
        "icon": Bootstrap.book,
      },
      {
        "name": AppLocalizations.of(context)!.exhibition,
        "icon": Bootstrap.image,
      },
      {
        "name": AppLocalizations.of(context)!.holiday,
        "icon": Bootstrap.sun,
      },
      {
        "name": AppLocalizations.of(context)!.eating,
        "icon": Bootstrap.egg_fried,
      },
    ];

    List<String> eventImages = [
      AppAsset.sportBG,
      AppAsset.birthdayBG,
      AppAsset.meetingBG,
      AppAsset.gamingBG,
      AppAsset.work_shopBG,
      AppAsset.book_clubBG,
      AppAsset.exhibition_imageBG,
      AppAsset.holidayBG,
      AppAsset.eatingBG,
    ];
    selectedImage = eventImages[selected];
    selectedEventName = eventsList[selected]["name"];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: AppStyles.medium20Primary,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  eventImages[selected],
                  fit: BoxFit.cover,
                  height: height * 0.25,
                  width: width,
                ),
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                height: height * 0.07,
                /*######################################################################################################## */
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: eventsList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selected = index;
                        });
                      },
                      child: EventTab(
                        broderColor: AppColors.primaryLight,
                        selectedTextIconColor: AppColors.whiteColor,
                        unSelectedTextIconColor: AppColors.primaryLight,
                        selectedBackgroundColor: AppColors.primaryLight,
                        eventName: eventsList[index]["name"],
                        eventIcon: eventsList[index]["icon"],
                        isSelected: selected == index,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: height * 0.02),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.title,
                        style: AppStyles.bold16Primary.copyWith(
                          color: Theme.of(context).hoverColor,
                        ),
                      ),
                      SizedBox(height: height * 0.002),
                      /*######################################################################################################## */
                      CustomTextField(
                        hintText: AppLocalizations.of(context)!.event_title,
                        prefixIcon: const ImageIcon(
                          AssetImage(AppAsset.editIcon),
                        ),
                        controller: titleControler,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_event_title;
                          }
                        },
                      ),
                      /*################################################################################# */
                      SizedBox(height: height * 0.02),
                      Text(
                        AppLocalizations.of(context)!.description,
                        style: AppStyles.bold16Primary.copyWith(
                          color: Theme.of(context).hoverColor,
                        ),
                      ),
                      SizedBox(height: height * 0.002),
/*################################################################################# */
                      CustomTextField(
                        maxLine: 4,
                        hintText:
                            AppLocalizations.of(context)!.event_description,
                        controller: descriptionController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_event_description;
                          }
                        },
                      ),
                      /*################################################################################# */
                      SizedBox(height: height * 0.008),
                      EventDateOrTime(
                        IconImage: AppAsset.calenderIcon,
                        eventText: AppLocalizations.of(context)!.event_date,
                        chooseText: selectedDate == null
                            ? AppLocalizations.of(context)!.choose_date
                            : formatedDate!,
                        onChoosedDateOrTime: chooseDate,
                      ),
                      SizedBox(height: height * 0.001),

                      /*################################################################################# */
                      EventDateOrTime(
                        IconImage: AppAsset.timeIcon,
                        eventText: AppLocalizations.of(context)!.event_time,
                        chooseText: selectedTime == null
                            ? AppLocalizations.of(context)!.choose_time
                            : formatedTime!,
                        onChoosedDateOrTime: chooseTime,
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        AppLocalizations.of(context)!.location,
                        style: AppStyles.bold16Primary.copyWith(
                          color: Theme.of(context).hoverColor,
                        ),
                      ),
                      SizedBox(height: height * 0.006),
                      /*######################################################################################################## */
                      CustomLocationButton(
                        onTap: () {
                          //todo choose location
                        },
                        firstText:
                            AppLocalizations.of(context)!.choose_location,
                        leadingIconImage: AppAsset.locationIcon,
                        suffixIcon: true,
                      ),
                      SizedBox(height: height * 0.014),

                      /*######################################################################################################## */
                      CustomElvatedButton(
                          backgroundColor: AppColors.primaryLight,
                          onPressed: addEvent,
                          text: AppLocalizations.of(context)!.add_event),
                      SizedBox(height: height * 0.02),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      //todo: add event to db
      Event event = Event(
          title: titleControler.text,
          discription: descriptionController.text,
          image: selectedImage,
          eventName: selectedEventName,
          dateTime: selectedDate,
          time: formatedTime!);

      FirebaseUtils.addEventToFireStore(event)
          .timeout(Duration(milliseconds: 500), onTimeout: () {
        return showDailog();
        
      });
    }
    if (selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(AppLocalizations.of(context)!.please_enter_event_time)));
    }
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    selectedDate = chooseDate;
    formatedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    selectedTime = chooseTime;
    formatedTime = selectedTime!.format(context);
    setState(() {});
  }

  Future showDailog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text("Event Added Successful"),
          actions: [
            TextButton(
                onPressed: () {
              Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                  style: AppStyles.bold14Primary,
                )),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        );
      },
    );
  }
}
