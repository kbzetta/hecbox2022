import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hecbox/Vistas/ingresoPacienteVista.dart';

import 'package:http/http.dart' as http;
import '../ConfigGenerales.dart';

class IngresoVista extends StatefulWidget {
  const IngresoVista({Key? key}) : super(key: key);

  @override
  State<IngresoVista> createState() => _IngresoVistaState();
}

class _IngresoVistaState extends State<IngresoVista> {
  final TextEditingController _usuario = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();
  bool _passwordVisible = false;
  @override
  void initState() {
    _passwordVisible = false;
  }

  Future<http.Response> crearUsuario(String nombre, mail) {
    return http.post(
      Uri.parse('http://localhost:1337/api/auth/local/register'),
      body: jsonEncode(<String, String>{
        'username': nombre,
        'password': mail,
        'email': 'user@strapi.io',
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                logo(),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: SizedBox(
                    width: 400,
                    child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(30, 3, 20, 0),
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colores.secundario),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: _usuario,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colores.secundario,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.person),
                              color: Colors.grey,
                            ),
                            hintText: 'Usuario',
                            hintStyle:
                                const TextStyle(color: Colores.secundario),
                          ),
                          style: const TextStyle(color: Colors.black),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 400,
                    child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(30, 3, 20, 0),
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colores.secundario),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          obscureText:
                              !_passwordVisible, //This will obscure text dynamically
                          controller: _contrasena,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colores.secundario,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            hintText: 'Contraseña',
                            hintStyle:
                                const TextStyle(color: Colores.secundario),
                          ),
                          style: const TextStyle(color: Colors.black),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                      width: 380,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          final response = await http.post(
                            Uri.parse(usuarioApiUrl),
                            headers: {
                              'Content-Type':
                                  'application/x-www-form-urlencoded',
                            },
                            encoding: Encoding.getByName('utf-8'),
                            body: {
                              'usuario': _usuario.text,
                              'password': _contrasena.text,
                            },
                          );

                          if (response.statusCode == 200) {
                            // If the server did return a 201 CREATED response,
                            // then parse the JSON.
                            Get.to(const IngresoPacienteVista());
                            print(response.body);
                          }

                          if (response.statusCode == 400) {
                            return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        Colors.yellowAccent.shade100,
                                    content: Row(
                                      children: const [
                                        Text(
                                            'Usuario y/o contraseña invalidos'),
                                        Icon(Icons.warning)
                                      ],
                                    ),
                                  );
                                });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colores.secundario,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(7), // <-- Radius
                          ),
                        ),
                        child: const Text('Ingresar'),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
