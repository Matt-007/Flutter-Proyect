import 'package:flutter/material.dart';

class InsumosCrud extends StatefulWidget {
  @override
  _InsumosCrudState createState() => _InsumosCrudState();
}

class _InsumosCrudState extends State<InsumosCrud> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _codigo = '';
  String _nombre = '';
  String _descripcion = '';
  //fechaasignación
  //cedula
  String _cedula = '';
  String _vidaUtil = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD de Insumos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Código'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el código';
                  }
                  return null;
                },
                onSaved: (value) {
                  _codigo = value!;
                },
              ),
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
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la descripción';
                  }
                  return null;
                },
                onSaved: (value) {
                  _descripcion = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Asignado a'),
                onSaved: (value) {
                  _cedula = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Vida útil'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la vida útil';
                  }
                  return null;
                },
                onSaved: (value) {
                  _vidaUtil = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aquí puedes implementar la lógica para guardar los datos
                    // Por ejemplo, enviar los datos a un servicio o base de datos
                    // _codigo, _nombre, _descripcion, _asignadoA, _vidaUtil contienen los valores
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
