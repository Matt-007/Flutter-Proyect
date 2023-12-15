import 'package:flutter/material.dart';
import 'package:uarc/src/widgets/dashboard.dart';
import 'package:uarc/src/widgets/empleados.dart';
import 'package:uarc/src/widgets/insumos.dart';
import 'package:uarc/src/widgets/equipoDeTrabajo.dart';
import 'package:uarc/src/widgets/usuarios.dart';

class InsumosCrud extends StatefulWidget {
  @override
  _InsumosCrudState createState() => _InsumosCrudState();
}

class _InsumosCrudState extends State<InsumosCrud> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _vidaUtilController = TextEditingController();

  List<Map<String, String>> insumos = [];
  bool isEditing = false;
  int editingIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD de Insumos'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Lista de insumos
            Expanded(
              child: ListView.builder(
                itemCount: insumos.length,
                itemBuilder: (context, index) {
                  final insumo = insumos[index];
                  return ListTile(
                    title: Text('${insumo['nombre']}'),
                    subtitle: Text(
                        'Código: ${insumo['codigo']}, Descripción: ${insumo['descripcion']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Editar insumo
                            editInsumo(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Eliminar insumo
                            deleteInsumo(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Formulario para agregar o editar insumo
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _codigoController,
                    decoration: InputDecoration(labelText: 'Código'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa el código';
                      }
                      return null;
                    },
                  ),
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
                    controller: _descripcionController,
                    decoration: InputDecoration(labelText: 'Descripción'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa la descripción';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cedulaController,
                    decoration: InputDecoration(labelText: 'Asignado a'),
                  ),
                  TextFormField(
                    controller: _vidaUtilController,
                    decoration: InputDecoration(labelText: 'Vida útil'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa la vida útil';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Guardar insumo
                          saveInsumo();
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

  void saveInsumo() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (isEditing) {
        // Editar el insumo existente
        insumos[editingIndex] = {
          'codigo': _codigoController.text,
          'nombre': _nombreController.text,
          'descripcion': _descripcionController.text,
          'asignadoA': _cedulaController.text,
          'vidaUtil': _vidaUtilController.text,
        };
        // Resetear el estado de edición
        isEditing = false;
        editingIndex = -1;
      } else {
        // Agregar un nuevo insumo
        insumos.add({
          'codigo': _codigoController.text,
          'nombre': _nombreController.text,
          'descripcion': _descripcionController.text,
          'asignadoA': _cedulaController.text,
          'vidaUtil': _vidaUtilController.text,
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
    _codigoController.clear();
    _nombreController.clear();
    _descripcionController.clear();
    _cedulaController.clear();
    _vidaUtilController.clear();
    isEditing = false;
    editingIndex = -1;
  }

  void editInsumo(int index) {
    // Editar el insumo seleccionado
    isEditing = true;
    editingIndex = index;

    // Poblar el formulario con los datos del insumo seleccionado
    _codigoController.text = insumos[index]['codigo']!;
    _nombreController.text = insumos[index]['nombre']!;
    _descripcionController.text = insumos[index]['descripcion']!;
    _cedulaController.text = insumos[index]['asignadoA']!;
    _vidaUtilController.text = insumos[index]['vidaUtil']!;

    // Actualizar la interfaz
    setState(() {});
  }

  void deleteInsumo(int index) {
    // Eliminar el insumo seleccionado
    insumos.removeAt(index);
    // Resetear el estado de edición
    resetForm();
    // Actualizar la interfaz
    setState(() {});
  }
}
