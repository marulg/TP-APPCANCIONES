import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clases/domain/users.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clases/presentation/providers/user_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController textoUsuario = TextEditingController();
  final TextEditingController textoContra = TextEditingController();

  bool ocultarContra = true;
  String resultado = "";
  Color colorRespuesta = Colors.white;

  @override
  void initState() {
    super.initState();
    ref.read(userProvider.notifier).getAllUsers();
  }

  void enviar() {
    final users = ref.read(userProvider);

    String email = textoUsuario.text.trim();
    String pass = textoContra.text.trim();

    setState(() {
      if (email.isEmpty || pass.isEmpty) {
        resultado = "Por favor, complete ambos campos.";
        colorRespuesta = Colors.red;
        return;
      }

      User? user = users.firstWhere(
        (u) => u.email == email,
        orElse: () => User("", "", "", ""),
      );

      if (user.email == "") {
        resultado = "Email no registrado.";
        colorRespuesta = Colors.red;
      } else if (user.password != pass) {
        resultado = "Contraseña incorrecta.";
        colorRespuesta = Colors.red;
      } else {
        resultado = "Bienvenido!";
        colorRespuesta = Colors.green;

        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            context.go('/home');
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Ingrese email y contraseña.",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 200,
              child: TextField(
                controller: textoUsuario,
                decoration: const InputDecoration(labelText: "Email"),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: TextField(
                controller: textoContra,
                obscureText: ocultarContra,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  suffixIcon: IconButton(
                    icon: Icon(
                      ocultarContra ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        ocultarContra = !ocultarContra;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: enviar, child: const Text("LOG IN")),
            const SizedBox(height: 20),
            Text(
              resultado,
              style: TextStyle(fontSize: 18, color: colorRespuesta),
            ),
          ],
        ),
      ),
    );
  }
}
