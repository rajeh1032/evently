import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/model/event.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  List<Event> eventList = [];

  void getAllEvent() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection().get();
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }
}
