import 'package:flutter/material.dart';
import 'package:uarc/src/pages/menuLateral.dart';
import 'package:uarc/src/widgets/insumos.dart';
import 'package:uarc/src/widgets/usuarios.dart';

class GrupoTrabajoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuLateral(),
              ),
            );
          },
          child: Text('UARC'),
        ),
        backgroundColor: const Color.fromARGB(255, 201, 223, 255),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Nombre de Usuario"),
              accountEmail: Text("usuario@correo.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "Nombre de Usuario".isNotEmpty ? "Nombre de Usuario"[0] : "",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 201, 223, 255),
              ),
            ),
            ListTile(
              title: Text("Administración Empresa"),
              onTap: () {
                Navigator.pop(context);
                // Lógica para navegar a la sección o pantalla de Administración Empresa
              },
            ),
            Divider(),
            ListTile(
              title: Text("Empleados"),
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text("Activos"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsumosCrud()),
                );
              },
              leading: Icon(Icons.business),
            ),
            Divider(),
            ListTile(
              title: Text("Administración Usuarios"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsuariosCrud()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text("Equipo de Trabajo"),
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.security),
            ),
            ListTile(
              title: Text("Usuarios"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsuariosCrud()),
                );
              },
              leading: Icon(Icons.person_add),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.white, // Color de fondo blanco
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Text(
                'EMPLEADOS', // Título 'EMPLEADOS'
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('images/oscar.jpg'),
                ),
                SizedBox(height: 20),
                Text(
                  'Oscar Nogales',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('images/sebas.jpg'),
                ),
                SizedBox(height: 20),
                Text(
                  'Sebastian Vaca',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('images/mateo.jpg'),
                ),
                SizedBox(height: 20),
                Text(
                  'Mateo Navas',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
