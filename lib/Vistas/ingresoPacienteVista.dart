import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hecbox/Servicios/BuscadorServicio.dart';
import 'package:hecbox/Vistas/inicioVista.dart';

class IngresoPacienteVista extends StatefulWidget {
  const IngresoPacienteVista({Key? key}) : super(key: key);

  @override
  State<IngresoPacienteVista> createState() => _IngresoPacienteVistaState();
}

class _IngresoPacienteVistaState extends State<IngresoPacienteVista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ingresar paciente'),
            SizedBox(
              height: 100,
              child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.qr_code,
                    size: 60,
                  ),
                  label: const Text(' escanear pulsera')),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 100,
              child: ElevatedButton.icon(
                  onPressed: () {
                    showSearch(context: context, delegate: DataSearch());
                  },
                  icon: const Icon(
                    Icons.numbers,
                    size: 60,
                  ),
                  label: const Text('Buscar Paciente')),
            )
          ],
        ),
      ),
    );
  }
}
