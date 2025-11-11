import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clases/presentation/providers/user_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool ocultarContra = true;

  bool _camposVacios(String email, String password) {
    return email.trim().isEmpty || password.trim().isEmpty;
  }

  void enviar() async {
    FocusScope.of(context).unfocus();

    final email = emailController.text.trim();
    final pass = passwordController.text.trim();

    if (_camposVacios(email, pass)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, complete ambos campos."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final mensaje = await ref
        .read(userProvider.notifier)
        .signInWithEmailPassword(email, pass);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor:
            mensaje.contains("exitoso") ? Colors.green : Colors.red,
      ),
    );

    if (mensaje.contains("exitoso") && mounted) {
      Future.delayed(const Duration(seconds: 1), () {
        context.go('/home');
      });
    }
  }

  void mostrarDialogoRegistro() {
    final regEmail = TextEditingController();
    final regPass = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Registrar nuevo usuario"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: regEmail,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: regPass,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Contraseña"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                final email = regEmail.text.trim();
                final pass = regPass.text.trim();

                if (_camposVacios(email, pass)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Complete ambos campos"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                final mensaje = await ref
                    .read(userProvider.notifier)
                    .createWithPassword(email, pass);

                if (!mounted) return;
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(mensaje),
                    backgroundColor: mensaje.contains("exitosamente")
                        ? Colors.green
                        : Colors.red,
                  ),
                );
              },
              child: const Text("Registrar"),
            ),
          ],
        );
      },
    );
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
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: TextField(
                controller: passwordController,
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
            ElevatedButton(onPressed: enviar, child: const Text("Log In")),
            const SizedBox(height: 20),
            TextButton(
              onPressed: mostrarDialogoRegistro,
              child: const Text("Registrar"),
            ),
          ],
        ),
      ),
    );
  }
}
