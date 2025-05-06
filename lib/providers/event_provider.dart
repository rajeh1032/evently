import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/model/event.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventProvider extends ChangeNotifier {
  List<Event> eventList = [];
  List<Event> filterList = [];
  List<Event> favoriteEventList = [];
  List<Map<String, dynamic>> eventsNameIcon = [];

  int selectedIndex = 0;

//todo get event list withowt filter

  void getAllEvent(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId).get();

    ///List<Event>  List<queryDocumentSnapshot<Event>>
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterList = eventList;

//todo sortung list
    filterList.sort((Event event1, Event event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });

    notifyListeners();
  }

//todo get filter list
  void getAllEventFilter(BuildContext context, String uId) async {
    if (eventsNameIcon.isEmpty) {
      geteventsNameIcon(context);
    }
    var querySnapShot = await FirebaseUtils.getEventCollection(uId)
        .where('event_name', isEqualTo: eventsNameIcon[selectedIndex]['name'])
        .orderBy('date_time')
        .get();
    filterList = querySnapShot.docs.map((doc) {
      return doc.data();
    }).toList();

    notifyListeners();
  }

  //todo update isFavorite
  void updateIsFavorite(Event event, String uId, BuildContext context) async {
    FirebaseUtils.getEventCollection(uId)
        .doc(event.id)
        .update({'is_favorite': !event.isFavorite}).timeout(
            const Duration(milliseconds: 200), onTimeout: () {
      ToastMsg.addToast(
          message: "Favorite Update Successfull",
          BGColor: AppColors.primaryLight,
          textColor: AppColors.whiteColor);
    });
    selectedIndex == 0 ? getAllEvent(uId) : getAllEventFilter(context, uId);
    notifyListeners();
  }

  //todo get Favorite ordering
  void getAllIsFavorite(String uId) async {
    var querySnapShot = await FirebaseUtils.getEventCollection(uId)
        .where('is_favorite', isEqualTo: true)
        .orderBy('date_time')
        .get();

    favoriteEventList = querySnapShot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void changeSelectdIndex(
      int newSelectedIndex, String uId, BuildContext context) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? getAllEvent(uId) : getAllEventFilter(context, uId);
    notifyListeners();
  }

  Future<void> deleteEvent({required String eventId,required String uId}) async {
    await FirebaseUtils.getEventCollection(uId).doc().delete();
    eventList.removeWhere((event) => event.id == eventId);
    favoriteEventList.removeWhere((event) => event.id == eventId);
    notifyListeners();
  }

  List<Map<String, dynamic>> geteventsNameIcon(BuildContext context) {
    if (eventsNameIcon.isEmpty) {
      eventsNameIcon = [
        {
          "name": AppLocalizations.of(context)!.all,
          "icon": Bootstrap.list,
        },
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
    }

    return eventsNameIcon;
  }
}
