import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clases/entities/users.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // controladores para leer lo q se escribe en los textfields
  final TextEditingController textoUsuario = TextEditingController();
  final TextEditingController textoContra = TextEditingController();

  bool ocultarContra = true;

  // para mostrar mensajes abajo del botón 
  String resultado = "";
  Color colorRespuesta = Colors.white;

  void enviar() {
    // agarramos lo q se escribió y sacamos espacios
    String email = textoUsuario.text.trim();
    String pass = textoContra.text.trim();

    setState(() {
      // si falta alguno de los campos, tira error
      if (email.isEmpty || pass.isEmpty) {
        resultado = "Por favor, complete ambos campos.";
        colorRespuesta = Colors.red;
        return;
      }

      // buscamos el usuario por email (si no existe, devolvemos uno vacío)
      User user = User("","","","");
      for(var u in users){
        if(u.email == email){
          user = u;
          break;
        }
      }

      // validamos el usuario y la contraseña
      if (user.email == "") {
        resultado = "Email no registrado.";
        colorRespuesta = Colors.red;
      } else if (user.password != pass) {
        resultado = "Contraseña incorrecta.";
        colorRespuesta = Colors.red;
      } else {
        // si todo ok, mostramos bienvenida
        resultado = "Bienvenido, ${user.name}!";
        colorRespuesta = Colors.green;

        // esperamos 1 seg y vamos a la pantalla de home
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
