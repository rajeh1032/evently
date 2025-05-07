import 'package:evently/model/event.dart';
import 'package:evently/providers/current_event.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/tabs/home_tab/event_date_or_time.dart';
import 'package:evently/ui/home/tabs/home_tab/event_item.dart';
import 'package:evently/ui/home/tabs/home_tab/event_tab.dart';
import 'package:evently/ui/widget/custom_elvated_button.dart';
import 'package:evently/ui/widget/custom_location_button.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEven extends StatefulWidget {
  static const String routeName = '/editEvent';
  const EditEven({super.key});

  @override
  State<EditEven> createState() => _EditEventState();
}

class _EditEventState extends State<EditEven> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var currentEventProvider =
          Provider.of<CurrentEvent>(context, listen: false);

      var event = currentEventProvider.currentEvent;

      setState(() {
        titleControler.text = event!.title;
        descriptionControler.text = event.discription;
        selectedDate = event.dateTime;
        formatedDate = DateFormat('dd/MM/yyyy').format(event.dateTime);
        formatedTime = event.time;
        selected = eventsList
            .indexWhere((element) => element["name"] == event.eventName);
      });
    });
  }

  late List<Map<String, dynamic>> eventsList;
  int selected = 0;
  var selectedDate;
  String? formatedDate;
  var selectedTime;
  String? formatedTime;
  var formKey = GlobalKey<FormState>();
  TextEditingController titleControler = TextEditingController();
  TextEditingController descriptionControler = TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventsList = [
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

    String selectedImage = eventImages[selected];
    String selectedEventName = eventsList[selected]["name"];
    var eventProvider = Provider.of<EventProvider>(context);

    var userProvider = Provider.of<UserProvider>(context);
    if (userProvider.user == null) {
      return const Center(
        child: Text('Please login to view events'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.edit_event,
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
                          return null;
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
                        controller: descriptionControler,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_event_description;
                          }
                          return null;
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
                          onPressed: updateEvent,
                          text: AppLocalizations.of(context)!.update_event),
                      SizedBox(height: height * 0.02),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void updateEvent() async {
    if (formKey.currentState?.validate() == true) {
      //todo: update event
      try {
        var currentEventProvider =
            Provider.of<CurrentEvent>(context, listen: false);
        var event = currentEventProvider.currentEvent;
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        var eventProvider = Provider.of<EventProvider>(context, listen: false);
        Event upDateEvent = Event(
            id: event!.id,
            title: titleControler.text,
            discription: descriptionControler.text,
            image: eventImages[selected],
            eventName: eventsList[selected]['name'],
            dateTime: selectedDate,
            time: formatedTime!,
            isFavorite: event.isFavorite);
        await eventProvider.updateEvent(upDateEvent, userProvider.user!.id);

        if (context.mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Event Update Successfuly")));
        }
      } catch (e) {
        print("error is $e");
      }
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
}
