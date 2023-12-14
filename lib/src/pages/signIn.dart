import 'package:flutter/material.dart';
import 'package:uarc/src/pages/menuLateral.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/login.jpg'), // Ruta de tu imagen
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'UARC', // Título UARC
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa un usuario';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa una contraseña';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Lógica para manejar inicio de sesión
                      // Si los campos son válidos, proceder con el inicio de sesión
                      final route = MaterialPageRoute(builder: ((context) => const MenuLateral()));
                      Navigator.push(context, route);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 88, 143, 206), // Color de fondo del botón
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Espaciado interno del botón
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Bordes redondeados del botón
                    ),
                  ),
                  child: Text(
                    "Iniciar Sesión",
                    style: TextStyle(
                      color: Colors.white, // Color del texto
                      fontFamily: "FredokaOne",
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
