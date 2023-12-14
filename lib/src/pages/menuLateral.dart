import 'package:flutter/material.dart';
import 'package:uarc/src/widgets/dashboard.dart';
import 'package:uarc/src/widgets/empleados.dart';
import 'package:uarc/src/widgets/insumos.dart';
// ignore: unused_import
import 'package:uarc/src/widgets/equipoDeTrabajo.dart';
import 'package:uarc/src/widgets/usuarios.dart';

class MenuLateral extends StatelessWidget {
  final String nombreUsuario =
      "Nombre de Usuario"; // Simulación del nombre de usuario
  final String correoUsuario =
      "usuario@correo.com"; // Simulación del correo de usuario

  const MenuLateral({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UARC"),
        backgroundColor: Color.fromARGB(255, 201, 223, 255),
      ),
      drawer: Drawer(
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
                // Acción al seleccionar Administración Empresa
                Navigator.pop(
                    context); // Cerrar el menú lateral si es necesario
                // Lógica para navegar a la sección o pantalla de Administración Empresa
              },
            ),
            Divider(), // Separador entre secciones
            ListTile(
              title: Text("Empleados"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmpleadosCrud()),
                );
              },
              leading: Icon(Icons.person), // Icono para Empleados
            ),
            ListTile(
              title: Text("Activos"),
              onTap: () {
                // Acción al seleccionar Activos
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            InsumosCrud())); // Cerrar el menú lateral si es necesario
                // Lógica para navegar a la pantalla de Activos
              },
              leading: Icon(Icons.business), // Icono para Activos
            ),
            Divider(), // Separador entre secciones
            ListTile(
              title: Text("Administración Usuarios"),
              onTap: () {
                // Cerrar el menú lateral si es necesario
                // Lógica para navegar a la sección o pantalla de Administración Usuarios
              },
            ),
            Divider(), // Separador entre secciones
            ListTile(
              title: Text("Equipo de Trabajo"),
              onTap: () {
                // Acción al seleccionar Roles
                Navigator.pop(context);
                // Cerrar el menú lateral si es necesario
                // Lógica para navegar a la pantalla de Roles
              },
              leading: Icon(Icons.security), // Icono para Roles
            ),
            ListTile(
              title: Text("Usuarios"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsuariosCrud()),
                );
                // Cerrar el menú lateral si es necesario
                // Lógica para navegar a la pantalla de Usuarios
              },
              leading: Icon(Icons.person_add), // Icono para Usuarios
            ),
          ],
        ),
      ),
      body: StatisticChart(),
        // Lógica para manejar la selección de las secciones rápidas
        // Puedes implementar la lógica de navegación aquí si es necesario
      
    );
  }
}
