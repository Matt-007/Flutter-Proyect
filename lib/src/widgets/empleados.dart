import 'package:flutter/material.dart';

class EmpleadosCrud extends StatefulWidget {
  @override
  _EmpleadosCrudState createState() => _EmpleadosCrudState();
}

class _EmpleadosCrudState extends State<EmpleadosCrud> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _nombre = '';
  String _apellido = '';
  String _cedula = '';
  String _correo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD de Empleados'),
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
                decoration: InputDecoration(labelText: 'Apellido'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el apellido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _apellido = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cédula'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la cédula';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cedula = value!;
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
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aquí puedes implementar la lógica para guardar los datos
                    // Por ejemplo, enviar los datos a un servicio o base de datos
                    // _nombre, _apellido, _cedula, _correo contienen los valores
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
