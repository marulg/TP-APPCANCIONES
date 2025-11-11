import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clases/domain/users.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart' as auth;

final userProvider = StateNotifierProvider<UsersNotifier, List<domain.User>>(
  (ref) => UsersNotifier(FirebaseFirestore.instance),
);

class UsersNotifier extends StateNotifier<List<domain.User>> {
  final FirebaseFirestore db;
  late final CollectionReference<domain.User> usersRef;

  UsersNotifier(this.db) : super([]) {
    usersRef = db.collection('users').withConverter<domain.User>(
      fromFirestore: domain.User.fromFirestore,
      toFirestore: (domain.User user, _) => user.toFirestore(),
    );
    print("🟢 UsersNotifier inicializado correctamente");
  }

  Future<void> getAllUsers() async {
    print("📥 Obteniendo todos los usuarios de Firestore...");
    try {
      final snap = await usersRef.get();
      state = snap.docs.map((d) => d.data()).toList();
      print("✅ Se obtuvieron ${state.length} usuarios de Firestore");
    } catch (e) {
      print('🔴 Error al obtener usuarios: $e');
    }
  }

  Future<String> createWithPassword(String email, String password) async {
    print("🟦 Iniciando creación de usuario con email: $email");
    try {
      // Limpia sesión previa para evitar credenciales inválidas
      await auth.FirebaseAuth.instance.signOut();
      print("🔄 Sesión Firebase limpia antes del registro");

      final cred = await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      print("🟢 Usuario autenticado en FirebaseAuth: ${cred.user?.uid}");

      final newUser = domain.User(
        id: '',
        name: '',
        email: email,
        password: password,
        address: '',
      );

      print("🟨 Guardando usuario en Firestore: ${newUser.toString()}");
      await addUsuario(newUser);
      print("🟩 Usuario guardado exitosamente en Firestore");

      await getAllUsers();
      print("📋 Usuarios actualizados en el estado: ${state.length}");

      return 'Usuario creado exitosamente';
    } on auth.FirebaseAuthException catch (e) {
      print('🔥 FirebaseAuthException: ${e.code} - ${e.message}');
      if (e.code == 'weak-password') {
        return 'La contraseña es demasiado débil';
      } else if (e.code == 'email-already-in-use') {
        return 'Ese email ya está registrado';
      } else if (e.code == 'invalid-email') {
        return 'El email no es válido';
      } else if (e.code == 'invalid-credential') {
        return 'Las credenciales no son válidas o expiraron.';
      } else {
        return 'Error de autenticación: ${e.message}';
      }
    } catch (e, st) {
      print('❌ Error inesperado al crear usuario: $e');
      print('📄 Stacktrace: $st');
      return 'Error inesperado al crear el usuario';
    }
  }

  Future<String> signInWithEmailPassword(String email, String password) async {
    print("🔹 Intentando iniciar sesión con email: $email");
    try {
      final userCredential = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final auth.User user = userCredential.user!;
      print("🟢 Login exitoso con Firebase: ${user.email} / UID: ${user.uid}");

      final domain.User matched = await buscarUsuario(user.email ?? '');
      print("🟩 Usuario encontrado en Firestore: ${matched.email}");

      state = [matched];
      return 'Inicio de sesión exitoso: ${user.email}';
    } on auth.FirebaseAuthException catch (e) {
      print('🔥 Error en login FirebaseAuthException: ${e.code} - ${e.message}');
      switch (e.code) {
        case 'user-not-found':
          return 'No existe un usuario con ese email.';
        case 'wrong-password':
          return 'La contraseña es incorrecta.';
        case 'invalid-email':
          return 'El email ingresado no es válido.';
        case 'invalid-credential':
          return 'Las credenciales ya no son válidas. Cerrá sesión e intentá nuevamente.';
        default:
          return 'Error desconocido: ${e.message}';
      }
    } catch (e, st) {
      print('❌ Error inesperado al iniciar sesión: $e');
      print('📄 Stacktrace: $st');
      return 'Error al iniciar sesión';
    }
  }

  Future<void> addUsuario(domain.User usuario) async {
    final doc = usersRef.doc();
    try {
      usuario.id = doc.id;
      print("🟨 Guardando documento Firestore con ID: ${doc.id}");
      await doc.set(usuario);
      print("🟩 Usuario guardado correctamente en la colección 'users'");
    } catch (e, st) {
      print("🔴 Error al guardar usuario en Firestore: $e");
      print('📄 Stacktrace: $st');
      rethrow;
    }
  }

  Future<domain.User> buscarUsuario(String email) async {
    print("🔎 Buscando usuario con email: $email");
    try {
      final snap = await usersRef.get();
      final lista = snap.docs.map((d) => d.data()).toList();
      print("📚 ${lista.length} usuarios obtenidos desde Firestore");

      final domain.User user = lista.firstWhere(
        (u) => u.email == email,
        orElse: () => domain.User(
          id: '',
          email: '',
          name: '',
          password: '',
          address: '',
        ),
      );

      if (user.email.isEmpty) {
        print("⚠️ No se encontró usuario con ese email.");
      } else {
        print("✅ Usuario encontrado: ${user.email}");
      }

      return user;
    } catch (e, st) {
      print("🔴 Error al buscar usuario en Firestore: $e");
      print('📄 Stacktrace: $st');
      return domain.User(
        id: '',
        email: '',
        name: '',
        password: '',
        address: '',
      );
    }
  }
}
