import 'package:flutter/material.dart';
import 'package:uarc/src/pages/menuLateral.dart';
import 'package:uarc/src/widgets/empleados.dart';
import 'package:uarc/src/widgets/insumos.dart';

class UsuariosCrud extends StatefulWidget {
  @override
  _UsuariosCrudState createState() => _UsuariosCrudState();
}

class _UsuariosCrudState extends State<UsuariosCrud> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final TextEditingController _rolController = TextEditingController();

  List<Map<String, String>> usuarios = [];
  bool isEditing = false;
  int editingIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MenuLateral()), // Navega a StatisticChart()
            );
          },
          child: Text('UARC'), // Cambia el título del AppBar a "UARC"
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmpleadosCrud()),
                );
              },
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text("Insumos"),
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
                // Lógica para navegar a la sección o pantalla de Administración Usuarios
              },
            ),
            Divider(),
            ListTile(
              title: Text("Equipo de Trabajo"),
              onTap: () {
                Navigator.pop(context);
                // Lógica para navegar a la pantalla de Roles
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                                Container(
        color: Colors.white, // Color de fondo blanco
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Text(
            'USUARIOS ADMIN',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
              // Lista de usuarios
              Expanded(
                child: ListView.builder(
                  itemCount: usuarios.length,
                  itemBuilder: (context, index) {
                    final usuario = usuarios[index];
                    return ListTile(
                      title: Text('${usuario['nombre']}'),
                      subtitle: Text(
                          'Correo: ${usuario['correo']}, Rol: ${usuario['rol']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Editar usuario
                              editUsuario(index);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Eliminar usuario
                              deleteUsuario(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Formulario para agregar o editar usuario
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _correoController,
                decoration: InputDecoration(labelText: 'Correo'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Por favor, ingresa un correo válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contrasenaController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la contraseña';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _rolController,
                decoration: InputDecoration(labelText: 'Rol'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el rol';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Guardar usuario
                      saveUsuario();
                    },
                    child: Text('Guardar'),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      // Limpiar formulario
                      resetForm();
                    },
                    child: Text('Limpiar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveUsuario() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (isEditing) {
        // Editar el usuario existente
        usuarios[editingIndex] = {
          'nombre': _nombreController.text,
          'correo': _correoController.text,
          'contrasena': _contrasenaController.text,
          'rol': _rolController.text,
        };
        // Resetear el estado de edición
        isEditing = false;
        editingIndex = -1;
      } else {
        // Agregar un nuevo usuario
        usuarios.add({
          'nombre': _nombreController.text,
          'correo': _correoController.text,
          'contrasena': _contrasenaController.text,
          'rol': _rolController.text,
        });
      }

      // Limpiar el formulario
      resetForm();

      // Actualizar la interfaz
      setState(() {});
    }
  }

  void resetForm() {
    _formKey.currentState?.reset();
    _nombreController.clear();
    _correoController.clear();
    _contrasenaController.clear();
    _rolController.clear();
    isEditing = false;
    editingIndex = -1;
  }

  void editUsuario(int index) {
    // Editar el usuario seleccionado
    isEditing = true;
    editingIndex = index;

    // Poblar el formulario con los datos del usuario seleccionado
    _nombreController.text = usuarios[index]['nombre']!;
    _correoController.text = usuarios[index]['correo']!;
    _contrasenaController.text = usuarios[index]['contrasena']!;
    _rolController.text = usuarios[index]['rol']!;

    // Actualizar la interfaz
    setState(() {});
  }

  void deleteUsuario(int index) {
    // Eliminar el usuario seleccionado
    usuarios.removeAt(index);
    // Resetear el estado de edición
    resetForm();
    // Actualizar la interfaz
    setState(() {});
  }
}
