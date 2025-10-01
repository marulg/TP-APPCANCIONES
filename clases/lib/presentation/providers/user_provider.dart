import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clases/domain/users.dart';

final userProvider = StateNotifierProvider<UsersNotifier, List<User>>(
  (ref) => UsersNotifier(FirebaseFirestore.instance),
);

class UsersNotifier extends StateNotifier<List<User>> {
  final FirebaseFirestore db;
  late final CollectionReference<User> usersRef;

  UsersNotifier(this.db) : super([]) {
    usersRef = db.collection('users').withConverter<User>(
      fromFirestore: User.fromFirestore,
      toFirestore: (User user, _) => user.toFirestore(),
    );
  }

  Future<void> getAllUsers() async {
    try {
      final snap = await usersRef.get();
      state = snap.docs.map((d) => d.data()).toList();
    } catch (e) {
      print('Error al obtener usuarios: $e');
    }
  }
}
