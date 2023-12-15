import 'package:flutter/material.dart';
import 'package:uarc/src/widgets/dashboard.dart';
import 'package:uarc/src/widgets/empleados.dart';
import 'package:uarc/src/widgets/insumos.dart';
import 'package:uarc/src/widgets/equipoDeTrabajo.dart';
import 'package:uarc/src/widgets/usuarios.dart';

class MenuLateral extends StatelessWidget {
  final String nombreUsuario =
      "Nombre de Usuario"; // Simulación del nombre de usuario
  final String correoUsuario =
      "usuario@correo.com"; // Simulación del correo de usuario

  const MenuLateral({Key? key});

  Widget buildMenuLateral(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(nombreUsuario),
            accountEmail: Text(correoUsuario),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                nombreUsuario.isNotEmpty ? nombreUsuario[0] : "",
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
            },
          ),
          Divider(),
          ListTile(
            title: Text("Empleados"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmpleadosCrud()),
              );
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
            },
          ),
          Divider(),
          ListTile(
            title: Text("Equipo de Trabajo"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GrupoTrabajoWidget())
                );
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UARC"),
        backgroundColor: Color.fromARGB(255, 201, 223, 255),
      ),
      drawer: buildMenuLateral(context),
      body: StatisticChart(),
      // Lógica para manejar la selección de las secciones rápidas
      // Puedes implementar la lógica de navegación aquí si es necesario
    );
  }
}
