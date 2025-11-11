import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id; 
  final String email;
  final String password;
  final String name;
  final String address;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.address,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'address': address,
    };
  }

  static User fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      id: snapshot.id, // 👈 tomamos el id del documento
      email: data?['email'] ?? '',
      password: data?['password'] ?? '',
      name: data?['name'] ?? '',
      address: data?['address'] ?? '',
    );
  }
}
