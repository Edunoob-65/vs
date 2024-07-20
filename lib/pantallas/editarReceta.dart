import 'package:flutter/material.dart';
import 'package:recetariopersonal/databases/database.dart';
import 'package:recetariopersonal/modelos/receta.dart';

class EditRecipeScreen extends StatefulWidget {
  final int usuarioId;
  final Receta receta;

  EditRecipeScreen({required this.usuarioId, required this.receta});

  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _ingredientesController = TextEditingController();
  final TextEditingController _pasosController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _tituloController.text = widget.receta.titulo;
    _ingredientesController.text = widget.receta.ingredientes;
    _pasosController.text = widget.receta.pasos;
    _categoriaController.text = widget.receta.categoria;
  }

  void _actualizarReceta() async {
    String titulo = _tituloController.text.trim();
    String ingredientes = _ingredientesController.text.trim();
    String pasos = _pasosController.text.trim();
    String categoria = _categoriaController.text.trim();

    if (titulo.isEmpty ||
        ingredientes.isEmpty ||
        pasos.isEmpty ||
        categoria.isEmpty) {
      _mostrarError('Por favor, complete todos los campos');
      return;
    }

    Receta recetaActualizada = Receta(
      id: widget.receta.id,
      usuarioId: widget.usuarioId,
      titulo: titulo,
      ingredientes: ingredientes,
      pasos: pasos,
      categoria: categoria,
      rutaImagen: widget.receta.rutaImagen,
    );

    await _databaseHelper.actualizarReceta(recetaActualizada);

    _mostrarMensaje('Receta actualizada exitosamente');

    // navegar de regreso a la pantalla anterior
    Navigator.pop(context);
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.red),
    );
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Receta'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _ingredientesController,
              decoration: InputDecoration(labelText: 'Ingredientes'),
              maxLines: 4,
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _pasosController,
              decoration: InputDecoration(labelText: 'Pasos'),
              maxLines: 4,
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _categoriaController,
              decoration: InputDecoration(labelText: 'Categoría'),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _actualizarReceta,
              child: Text('Actualizar Receta'),
            ),
          ],
        ),
      ),
    );
  }
}
