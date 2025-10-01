import 'package:cloud_firestore/cloud_firestore.dart';
// por si se esta probando: mail: juan@gmail.com, contraseña: 1234

class User {
  final String email;
  final String password;
  final String name;
  final String address;

  User(this.email, this.password, this.name, this.address);

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
      data?['email'],
      data?['password'],
      data?['name'],
      data?['address'],
    );
  }
}
