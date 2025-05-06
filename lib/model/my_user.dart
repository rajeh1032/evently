class MyUser {
  static const String coolectionName = '/User';
  String name;
  String email;
  String id;
  MyUser({required this.name, required this.email, required this.id});
  //todo:json to object
  MyUser.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'] as String,
          name: data['name'] as String,
          email: data['email'] as String,
        );
  //todo:object to json
  Map<String, dynamic> toFireStore() {
    return {'id': id, 'name': name, 'email': email};
  }
}
 