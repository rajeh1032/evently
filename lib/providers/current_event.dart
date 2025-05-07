import 'package:evently/model/event.dart';
import 'package:flutter/material.dart';

class CurrentEvent extends ChangeNotifier {
  Event? currentEvent;
 void setCurrentEvent(Event newEvent) {
  currentEvent = newEvent;
  notifyListeners();
}
}
