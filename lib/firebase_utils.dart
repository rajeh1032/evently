import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/event.dart';
import 'package:evently/model/my_user.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection(uId) {
    return getMyUserCollection()
        .doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
            fromFirestore: (snapshot, options) =>
                Event.fromFireStore(snapshot.data()!),
            toFirestore: (event, options) => event.toFireStore());
  }

  static Future<void> addEventToFireStore(Event event, String uId) {
    var eventCollection = getEventCollection(uId);
    var docRef =
        eventCollection.doc(); //.doc(id) ==> can write id here manyally
    event.id = docRef.id;
    return docRef.set(event);
  }

  static CollectionReference<MyUser> getMyUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.coolectionName)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()!),
            toFirestore: (myUser, options) => myUser.toFireStore());
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    var querysnapShot = await getMyUserCollection().doc(id).get();
    return querysnapShot.data();
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getMyUserCollection().doc(myUser.id).set(myUser);
  }
}
