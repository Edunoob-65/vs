import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recetariopersonal/databases/database.dart';
import 'package:recetariopersonal/modelos/receta.dart';
import 'package:recetariopersonal/pantallas/editarReceta.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Receta receta;
  final int usuarioId;

  RecipeDetailScreen({required this.receta, required this.usuarioId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receta.titulo),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditRecipeScreen(
                            usuarioId: usuarioId, receta: receta)));
              },
              icon: Icon(Icons.edit)),
             /* IconButton(
              onPressed: () async {
                bool confirmarEliminar = await _dialogoConfirmacionEliminacion(context);
                if (confirmarEliminar){
                  final dbHelper = DatabaseHelper();
                  await dbHelper.eliminarReceta(receta.id!);
                  Navigator.pop(context);
                }
               
              },
              icon: Icon(Icons.delete))*/
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (receta.rutaImagen.isNotEmpty)
              Image.file(
                File(receta.rutaImagen),
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16.0),
            Text(
              'Ingredientes:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(receta.ingredientes),
            SizedBox(height: 16.0),
            Text(
              'Pasos:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(receta.pasos),
            SizedBox(height: 16.0),
            Text(
              'Categoría:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(receta.categoria),
          ],
        ),
      ),
    );
  }

//Confirmacion Eliminar

Future <bool> _dialogoConfirmacionEliminacion(BuildContext context) async{
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context){
      return AlertDialog( 
        title: Text('Confirmar eliminacion'),
        content: Text('¿Estas seguro que deseas eliminar esta receta?'),
        actions:<Widget> [ 
          TextButton(onPressed: (){
            Navigator.of(context).pop(false);
          }, 
          child: Text('Cancelar'),
          ),
        ],
      );
    },
  )?? false;
}

}
