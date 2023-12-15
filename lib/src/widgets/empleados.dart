import 'package:flutter/material.dart';
import 'package:uarc/src/widgets/insumos.dart';
import 'package:uarc/src/widgets/usuarios.dart';

class EmpleadosCrud extends StatefulWidget {
  const EmpleadosCrud({Key? key}) : super(key: key);

  @override
  State<EmpleadosCrud> createState() => _EmpleadosCrudState();
}

class _EmpleadosCrudState extends State<EmpleadosCrud> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  List<Map<String, String>> empleados = [];
  bool isEditing = false;
  int editingIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD de Empleados'),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Lista de empleados
            Expanded(
              child: ListView.builder(
                itemCount: empleados.length,
                itemBuilder: (context, index) {
                  final empleado = empleados[index];
                  return ListTile(
                    title:
                        Text('${empleado['nombre']} ${empleado['apellido']}'),
                    subtitle: Text(
                        'Cédula: ${empleado['cedula']}, Correo: ${empleado['correo']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Editar empleado
                            editEmpleado(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Eliminar empleado
                            deleteEmpleado(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Formulario para agregar o editar empleado
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
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
                    controller: _apellidoController,
                    decoration: InputDecoration(labelText: 'Apellido'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa el apellido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cedulaController,
                    decoration: InputDecoration(labelText: 'Cédula'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa la cédula';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _correoController,
                    decoration: InputDecoration(labelText: 'Correo'),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Por favor, ingresa un correo válido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Guardar empleado
                          saveEmpleado();
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
          ],
        ),
      ),
    );
  }

  void saveEmpleado() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (isEditing) {
        // Editar el empleado existente
        empleados[editingIndex] = {
          'nombre': _nombreController.text,
          'apellido': _apellidoController.text,
          'cedula': _cedulaController.text,
          'correo': _correoController.text,
        };
        // Resetear el estado de edición
        isEditing = false;
        editingIndex = -1;
      } else {
        // Agregar un nuevo empleado
        empleados.add({
          'nombre': _nombreController.text,
          'apellido': _apellidoController.text,
          'cedula': _cedulaController.text,
          'correo': _correoController.text,
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
    _apellidoController.clear();
    _cedulaController.clear();
    _correoController.clear();
    isEditing = false;
    editingIndex = -1;
  }

  void editEmpleado(int index) {
    // Editar el empleado seleccionado
    isEditing = true;
    editingIndex = index;

    // Poblar el formulario con los datos del empleado seleccionado
    _nombreController.text = empleados[index]['nombre']!;
    _apellidoController.text = empleados[index]['apellido']!;
    _cedulaController.text = empleados[index]['cedula']!;
    _correoController.text = empleados[index]['correo']!;

    // Actualizar la interfaz
    setState(() {});
  }

  void deleteEmpleado(int index) {
    // Eliminar el empleado seleccionado
    empleados.removeAt(index);
    // Resetear el estado de edición
    resetForm();
    // Actualizar la interfaz
    setState(() {});
  }
}
