import 'package:flutter/material.dart';
import 'package:uarc/src/pages/signIn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //Crear rutas de navegacion
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 27, 142, 236),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/SignIn", // Ruta inicial corregida
      routes: <String, WidgetBuilder>{
        "/SignIn": (BuildContext context) => const SignIn(), // Clave corregida
      },
    );
  }
}
