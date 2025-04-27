import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
            fromFirestore: (snapshot, options) =>
                Event.fromFireStore(snapshot.data()!),
            toFirestore: (event, options) => event.toFireStore());
  }

  static Future<void> addEventToFireStore(Event event) {
    var eventCollection = getEventCollection();
    var docRef = eventCollection.doc(); //.doc(id) ==> can write id here manyally
    event.id = docRef.id;
    return docRef.set(event);
  }
}
