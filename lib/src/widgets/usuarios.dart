import 'package:flutter/material.dart';

class UsuariosCrud extends StatefulWidget {
  @override
  _UsuariosCrudState createState() => _UsuariosCrudState();
}

class _UsuariosCrudState extends State<UsuariosCrud> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _nombre = '';
  String _correo = '';
  String _contrasena = '';
  String _rol = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD de Usuarios'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nombre = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Correo'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Por favor, ingresa un correo válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _correo = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la contraseña';
                  }
                  return null;
                },
                onSaved: (value) {
                  _contrasena = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rol'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el rol';
                  }
                  return null;
                },
                onSaved: (value) {
                  _rol = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aquí puedes implementar la lógica para guardar los datos
                    // Por ejemplo, enviar los datos a un servicio o base de datos
                    // _nombre, _correo, _contrasena, _rol contienen los valores
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
