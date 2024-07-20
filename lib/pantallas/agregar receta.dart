import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recetariopersonal/databases/database.dart';
import 'package:recetariopersonal/modelos/receta.dart';

class AddRecipeScreen extends StatefulWidget {
  final int usuarioId;
  AddRecipeScreen({required this.usuarioId});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _ingredientesController = TextEditingController();
  final TextEditingController _pasosController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  File? _imagenReceta;

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagenReceta = File(pickedFile.path);
      });
    }
  }

  void _agregarReceta() async {
    String titulo = _tituloController.text.trim();
    String ingredientes = _ingredientesController.text.trim();
    String pasos = _pasosController.text.trim();
    String categoria = _categoriaController.text.trim();

    // Validar que los campos no estén vacíos
    if (titulo.isEmpty ||
        ingredientes.isEmpty ||
        pasos.isEmpty ||
        categoria.isEmpty) {
      _mostrarError('Por favor, complete todos los campos');
      return;
    }

    // Crear el objeto Receta
    Receta nuevaReceta = Receta(
      id: 0, // El ID se asignará automáticamente en la base de datos
      usuarioId: widget.usuarioId,
      titulo: titulo,
      ingredientes: ingredientes,
      pasos: pasos,
      categoria: categoria,
      rutaImagen: _imagenReceta?.path ?? '',
    );

    // Insertar la receta en la base de datos
    await _databaseHelper.insertarReceta(nuevaReceta);

    // Mostrar un mensaje o navegar a otra pantalla
    _mostrarMensaje('Receta agregada exitosamente');

    // Opcional: navegar de regreso a la pantalla anterior
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
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            "assets/Imagenes/fondo.png",
            fit: BoxFit.cover,
          )),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: 740,
                            child: Container(
                              padding: EdgeInsets.all(40),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.zero,
                                    topRight: Radius.zero,
                                  )),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Título: ",
                                      style: TextStyle(
                                        fontFamily: "PlayfairDisplay",
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 21,
                                  ),
                                  Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                      ),
                                      TextField(
                                        controller: _tituloController,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.title_outlined,
                                              color: Colors.black),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                          ),
                                          labelText: "Type here",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 21,
                                  ),
                                  Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Ingredientes: ",
                                          style: TextStyle(
                                            fontFamily: "PlayfairDisplay",
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 21,
                                      ),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                          ),
                                          TextField(
                                            controller: _ingredientesController,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                  Icons.food_bank_outlined,
                                                  color: Colors.black),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.horizontal(),
                                                borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                              ),
                                              labelText: "Type here",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 21,
                                      ),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              "Pasos: ",
                                              style: TextStyle(
                                                fontFamily: "PlayfairDisplay",
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 21,
                                          ),
                                          Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                              ),
                                              TextField(
                                                controller: _pasosController,
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                      Icons.do_not_step_sharp,
                                                      color: Colors.black),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .horizontal(),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  labelText: "Type here",
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 21,
                                          ),
                                          Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              "Categoría: ",
                                              style: TextStyle(
                                                fontFamily: "PlayfairDisplay",
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 21,
                                          ),
                                          Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                              ),
                                              TextField(
                                                controller: _categoriaController,
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                      Icons.category_outlined,
                                                      color: Colors.black),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .horizontal(),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  labelText: "Type here",
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ],
                                          ),
                                          
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ],
                            ),
                          ),
                        ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: _seleccionarImagen,
                      child: Text('Seleccionar Imagen'),
                    ),
                    SizedBox(height: 12.0),
                    _imagenReceta != null
                        ? Image.file(
                            _imagenReceta!,
                            height: 400.0,
                            width: 400.0,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                    SizedBox(height: 12.0),
                    ElevatedButton(
                      onPressed: _agregarReceta,
                      child: Text('Agregar Receta'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
