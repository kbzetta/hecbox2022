import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hecbox/ConfigGenerales.dart';
import 'package:hecbox/Modelos/modelos.dart';
import 'package:hecbox/Modelos/piqModelos.dart';
import 'package:hecbox/Vistas/piqVista.dart';
import 'package:simple_timeline/entity/timeline_entity.dart';
import 'package:simple_timeline/presenter/simple_timeline_impl.dart';
import 'package:http/http.dart' as http;

class InicioVista extends StatefulWidget {
  final Operacion paciente;
  const InicioVista({Key? key, required, required this.paciente})
      : super(key: key);

  @override
  State<InicioVista> createState() => _InicioVistaState();
}

class _InicioVistaState extends State<InicioVista> {
  /////// internacion ////////
  List<NombreModel> dataInternacion = <NombreModel>[];
  Future<void> getInternacion() async {
    http.Response res = await http.get(Uri.parse("$serverUrl/especialidads"));

    var jsonData = jsonDecode(res.body);
    List<NombreModel> resultList = List<NombreModel>.from(
        json.decode(res.body).map((x) => NombreModel.fromMap(x)));

    setState(() {
      dataInternacion = resultList;
    });
  }

  /////// anestesia ////////
  List<NombreModel> dataAnestesia = <NombreModel>[];
  Future<void> getAnestesia() async {
    http.Response res = await http.get(Uri.parse("$serverUrl/anestesia-tipos"));

    var jsonData = jsonDecode(res.body);
    List<NombreModel> resultList = List<NombreModel>.from(
        json.decode(res.body).map((x) => NombreModel.fromMap(x)));

    setState(() {
      dataAnestesia = resultList;
    });
  }

  /////// Anestesiologo ////////
  List<NombreModel> dataAnestesiologo = <NombreModel>[];
  Future<void> getAnestesiologo() async {
    http.Response res = await http.get(Uri.parse("$serverUrl/profesionales"));

    var jsonData = jsonDecode(res.body);
    List<NombreModel> resultList = List<NombreModel>.from(
        json.decode(res.body).map((x) => NombreModel.fromMap(x)));

    setState(() {
      dataAnestesiologo = resultList;
    });
  }

  /////// Anestesiologo ////////
  List<NombreModel> dataAsaTipo = <NombreModel>[];
  Future<void> getAsaTipo() async {
    http.Response res = await http.get(Uri.parse("$serverUrl/asa-tipos"));

    var jsonData = jsonDecode(res.body);
    List<NombreModel> resultList = List<NombreModel>.from(
        json.decode(res.body).map((x) => NombreModel.fromMap(x)));

    setState(() {
      dataAsaTipo = resultList;
    });
  }

  @override
  void initState() {
    getInternacion();
    getAnestesia();
    getAnestesiologo();
    getAsaTipo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? rolMedico = 'Elegir Rol';
    bool entradaquirofano = false;
    bool salidaquirofano = false;
    bool entradaZonaquirofano = false;
    bool salidazONAquirofano = false;
    String internacion = '';

    var demos = "";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colores.secundario,
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.to(PiqVista(paciente: widget.paciente.id_operacion));
              },
              child: const Text('Nuevo PIQ'))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Image.asset('assets/img/hecbox.jpg')),
            const ListTile(
              title: Text('Listado P.I.Q'),
            ),
            ListTile(
                title: const Text('Puntos de Control'),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (BuildContext context, setState) {
                            return SizedBox(
                              width: 400,
                              child: Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: SimpleTimeLine(timelineList: [
                                        TimelineEntity(
                                            enable: entradaZonaquirofano,
                                            title: "Entrada zona quirurgica"),
                                        TimelineEntity(
                                            enable: entradaquirofano,
                                            title: "Entrada quirofano"),
                                        TimelineEntity(
                                            enable: salidaquirofano,
                                            title: "Salida quirofano"),
                                        TimelineEntity(
                                            enable: salidazONAquirofano,
                                            title: "Salida zona quirurgica"),
                                      ]),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 60,
                                          width: 300,
                                          child: SwitchListTile(
                                            value: entradaZonaquirofano,
                                            onChanged: (bool newValue) {
                                              setState(() {
                                                entradaZonaquirofano = newValue;
                                              });
                                            },
                                            title: const Text(
                                                'Entrada Zona Quirofano'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 60,
                                          width: 300,
                                          child: SwitchListTile(
                                            value: entradaquirofano,
                                            onChanged: (bool newValue) {
                                              setState(() {
                                                entradaquirofano = newValue;
                                              });
                                            },
                                            title:
                                                const Text('Entrada Quirofano'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 60,
                                          width: 300,
                                          child: SwitchListTile(
                                            value: salidaquirofano,
                                            onChanged: (bool newValue) {
                                              setState(() {
                                                salidaquirofano = newValue;
                                              });
                                            },
                                            title:
                                                const Text('Salida  Quirofano'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 60,
                                          width: 300,
                                          child: SwitchListTile(
                                            value: salidazONAquirofano,
                                            onChanged: (bool newValue) {
                                              setState(() {
                                                salidazONAquirofano = newValue;
                                              });
                                            },
                                            title: const Text(
                                                'Salida Zona Quirofano'),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      });
                })
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Datos Paciente'),
                        SizedBox(
                          width: 400,
                          child: Card(
                            elevation: 5,
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.numbers),
                                  title: const Text('ID PACIENTE'),
                                  subtitle: Text(
                                      widget.paciente.paciente.id_paciente),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.numbers),
                                  title: const Text('NOMBRE APELLIDO'),
                                  subtitle: Text(
                                      "${widget.paciente.paciente.nombre}  ${widget.paciente.paciente.apellido}"),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.numbers),
                                  title: const Text('EDAD'),
                                  subtitle: Text(widget.paciente.paciente.edad),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.numbers),
                                  title: const Text('HISTORIA CLINICA'),
                                  subtitle: Text(widget
                                      .paciente.paciente.historia_clinica),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.numbers),
                                  title: const Text('SEXO'),
                                  subtitle: Text(widget.paciente.paciente.sexo),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.numbers),
                                  title: const Text('N° DNI'),
                                  subtitle: Text(widget.paciente.paciente.dni),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Datos Operación'),
                        SizedBox(
                          width: 400,
                          child: Card(
                            elevation: 5,
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.numbers),
                                  title: const Text('ID OPERACION'),
                                  subtitle: Text(widget.paciente.id_operacion),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.numbers),
                                  title: const Text('FECHA PROGRAMADA'),
                                  subtitle: Text(widget
                                      .paciente.fecha_programada_operacion),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.numbers),
                                  title: const Text('TIPO PROCEDIMIENTO'),
                                  subtitle:
                                      Text(widget.paciente.procedimiento_tipo),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.numbers),
                                  title: const Text('QUIROFANO RESERVADO'),
                                  subtitle:
                                      Text(widget.paciente.quirofano_reservado),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.numbers),
                                  title: const Text('QUIROFANO REAL'),
                                  subtitle:
                                      Text(widget.paciente.quirofano_real),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.numbers),
                                  title: const Text('MOTIVO DE CAMBIO QX'),
                                  subtitle: Text(rolMedico),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      width: 250,
                      child: ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context, setState) {
                                      String valueChanged4;
                                      String valueSaved4;
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Tabla de Tiempos',
                                                      style: GoogleFonts
                                                          .encodeSans(
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Fecha Inicio Anestesia'),
                                                        SizedBox(
                                                          width: 300,
                                                          child: DateTimePicker(
                                                            type:
                                                                DateTimePickerType
                                                                    .time,
                                                            //timePickerEntryModeInput: true,
                                                            //controller: _controller4,
                                                            initialValue:
                                                                '', //_initialValue,
                                                            icon: const Icon(Icons
                                                                .access_time),
                                                            timeLabelText:
                                                                "Seleccionar",
                                                            use24HourFormat:
                                                                false,

                                                            onChanged: (val) =>
                                                                setState(() =>
                                                                    valueChanged4 =
                                                                        val),
                                                            validator: (val) {
                                                              String
                                                                  valueToValidate4;
                                                              setState(() =>
                                                                  valueToValidate4 =
                                                                      val ??
                                                                          '');
                                                              return null;
                                                            },
                                                            onSaved: (val) =>
                                                                setState(() =>
                                                                    valueSaved4 =
                                                                        val ??
                                                                            ''),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Fecha Inicio Cirugía'),
                                                        SizedBox(
                                                          width: 300,
                                                          child: DateTimePicker(
                                                            type:
                                                                DateTimePickerType
                                                                    .time,
                                                            //timePickerEntryModeInput: true,
                                                            //controller: _controller4,
                                                            initialValue:
                                                                '', //_initialValue,
                                                            icon: const Icon(Icons
                                                                .access_time),
                                                            timeLabelText:
                                                                "Seleccionar",
                                                            use24HourFormat:
                                                                false,

                                                            onChanged: (val) =>
                                                                setState(() =>
                                                                    valueChanged4 =
                                                                        val),
                                                            validator: (val) {
                                                              String
                                                                  valueToValidate4;
                                                              setState(() =>
                                                                  valueToValidate4 =
                                                                      val ??
                                                                          '');
                                                              return null;
                                                            },
                                                            onSaved: (val) =>
                                                                setState(() =>
                                                                    valueSaved4 =
                                                                        val ??
                                                                            ''),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Fecha Fin Cirugía'),
                                                        SizedBox(
                                                          width: 300,
                                                          child: DateTimePicker(
                                                            type:
                                                                DateTimePickerType
                                                                    .time,
                                                            //timePickerEntryModeInput: true,
                                                            //controller: _controller4,
                                                            initialValue:
                                                                '', //_initialValue,
                                                            icon: const Icon(Icons
                                                                .access_time),
                                                            timeLabelText:
                                                                "Seleccionar",
                                                            use24HourFormat:
                                                                false,

                                                            onChanged: (val) =>
                                                                setState(() =>
                                                                    valueChanged4 =
                                                                        val),
                                                            validator: (val) {
                                                              String
                                                                  valueToValidate4;
                                                              setState(() =>
                                                                  valueToValidate4 =
                                                                      val ??
                                                                          '');
                                                              return null;
                                                            },
                                                            onSaved: (val) =>
                                                                setState(() =>
                                                                    valueSaved4 =
                                                                        val ??
                                                                            ''),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Fecha Fin Anestesia'),
                                                        SizedBox(
                                                          width: 300,
                                                          child: DateTimePicker(
                                                            type:
                                                                DateTimePickerType
                                                                    .time,
                                                            //timePickerEntryModeInput: true,
                                                            //controller: _controller4,
                                                            initialValue:
                                                                '', //_initialValue,
                                                            icon: const Icon(Icons
                                                                .access_time),
                                                            timeLabelText:
                                                                "Seleccionar",
                                                            use24HourFormat:
                                                                false,

                                                            onChanged: (val) =>
                                                                setState(() =>
                                                                    valueChanged4 =
                                                                        val),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                });
                          },
                          icon: Image.asset(
                            'assets/img/tiempos.png',
                            color: Colors.white,
                            width: 40,
                          ),
                          label: const Text('TIEMPOS')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      width: 250,
                      child: ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context, setState) {
                                      return Column(
                                        children: [
                                          Text(
                                            'Internacion',
                                            style: GoogleFonts.encodeSans(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          StatefulBuilder(
                                            builder: (BuildContext context,
                                                setState) {
                                              return SingleChildScrollView(
                                                child: SizedBox(
                                                  height: 400,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 500,
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Elegir Sector Recuperación: '),
                                                            Expanded(
                                                              child: Autocomplete<
                                                                  NombreModel>(
                                                                initialValue:
                                                                    TextEditingValue(
                                                                        text:
                                                                            internacion),
                                                                optionsBuilder:
                                                                    (TextEditingValue
                                                                        textEditingValue) {
                                                                  return dataInternacion
                                                                      .where((NombreModel continent) => continent
                                                                          .nombre
                                                                          .toLowerCase()
                                                                          .startsWith(textEditingValue
                                                                              .text
                                                                              .toLowerCase()))
                                                                      .toList();
                                                                },
                                                                displayStringForOption:
                                                                    (NombreModel
                                                                            option) =>
                                                                        option
                                                                            .nombre,
                                                                fieldViewBuilder: (BuildContext context,
                                                                    TextEditingController
                                                                        fieldTextEditingController,
                                                                    FocusNode
                                                                        fieldFocusNode,
                                                                    VoidCallback
                                                                        onFieldSubmitted) {
                                                                  return TextField(
                                                                    controller:
                                                                        fieldTextEditingController,
                                                                    focusNode:
                                                                        fieldFocusNode,
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  );
                                                                },
                                                                onSelected:
                                                                    (NombreModel
                                                                        selection) {
                                                                  setState(() {
                                                                    internacion =
                                                                        selection
                                                                            .nombre;
                                                                  });
                                                                  print(
                                                                      'Selected: ${selection.nombre}');
                                                                },
                                                                optionsViewBuilder: (BuildContext context,
                                                                    AutocompleteOnSelected<
                                                                            NombreModel>
                                                                        onSelected,
                                                                    Iterable<
                                                                            NombreModel>
                                                                        options) {
                                                                  return Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        Material(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            300,
                                                                        child: ListView
                                                                            .builder(
                                                                          padding:
                                                                              const EdgeInsets.all(10.0),
                                                                          itemCount:
                                                                              options.length,
                                                                          itemBuilder:
                                                                              (BuildContext context, int index) {
                                                                            final NombreModel
                                                                                option =
                                                                                options.elementAt(index);

                                                                            return GestureDetector(
                                                                              onTap: () {
                                                                                onSelected(option);
                                                                              },
                                                                              child: ListTile(
                                                                                title: Text(option.nombre, style: const TextStyle(color: Colores.secundario)),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                });
                          },
                          icon: Image.asset(
                            'assets/img/cama.png',
                            color: Colors.white,
                            width: 40,
                          ),
                          label: const Text('INTERNACIÓN')),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      width: 250,
                      child: ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context, setState) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Anestesia',
                                              style: GoogleFonts.encodeSans(
                                                fontSize: 35,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      color: Colores.secundario,
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          'Anestesia',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 500,
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                              'Tipo de Anestesia: '),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          internacion),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataAnestesia
                                                                    .where((NombreModel continent) => continent
                                                                        .nombre
                                                                        .toLowerCase()
                                                                        .startsWith(textEditingValue
                                                                            .text
                                                                            .toLowerCase()))
                                                                    .toList();
                                                              },
                                                              displayStringForOption:
                                                                  (NombreModel
                                                                          option) =>
                                                                      option
                                                                          .nombre,
                                                              fieldViewBuilder: (BuildContext
                                                                      context,
                                                                  TextEditingController
                                                                      fieldTextEditingController,
                                                                  FocusNode
                                                                      fieldFocusNode,
                                                                  VoidCallback
                                                                      onFieldSubmitted) {
                                                                return TextField(
                                                                  controller:
                                                                      fieldTextEditingController,
                                                                  focusNode:
                                                                      fieldFocusNode,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                );
                                                              },
                                                              onSelected:
                                                                  (NombreModel
                                                                      selection) {
                                                                setState(() {
                                                                  internacion =
                                                                      selection
                                                                          .nombre;
                                                                });
                                                                print(
                                                                    'Selected: ${selection.nombre}');
                                                              },
                                                              optionsViewBuilder: (BuildContext
                                                                      context,
                                                                  AutocompleteOnSelected<
                                                                          NombreModel>
                                                                      onSelected,
                                                                  Iterable<
                                                                          NombreModel>
                                                                      options) {
                                                                return Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child:
                                                                      Material(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          300,
                                                                      child: ListView
                                                                          .builder(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        itemCount:
                                                                            options.length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          final NombreModel
                                                                              option =
                                                                              options.elementAt(index);

                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              onSelected(option);
                                                                            },
                                                                            child:
                                                                                ListTile(
                                                                              title: Text(option.nombre, style: const TextStyle(color: Colores.secundario)),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Divider(),
                                                    SizedBox(
                                                      width: 500,
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                              'Tipo de Asa: '),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          internacion),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataAsaTipo
                                                                    .where((NombreModel continent) => continent
                                                                        .nombre
                                                                        .toLowerCase()
                                                                        .startsWith(textEditingValue
                                                                            .text
                                                                            .toLowerCase()))
                                                                    .toList();
                                                              },
                                                              displayStringForOption:
                                                                  (NombreModel
                                                                          option) =>
                                                                      option
                                                                          .nombre,
                                                              fieldViewBuilder: (BuildContext
                                                                      context,
                                                                  TextEditingController
                                                                      fieldTextEditingController,
                                                                  FocusNode
                                                                      fieldFocusNode,
                                                                  VoidCallback
                                                                      onFieldSubmitted) {
                                                                return TextField(
                                                                  controller:
                                                                      fieldTextEditingController,
                                                                  focusNode:
                                                                      fieldFocusNode,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                );
                                                              },
                                                              onSelected:
                                                                  (NombreModel
                                                                      selection) {
                                                                setState(() {
                                                                  internacion =
                                                                      selection
                                                                          .nombre;
                                                                });
                                                                print(
                                                                    'Selected: ${selection.nombre}');
                                                              },
                                                              optionsViewBuilder: (BuildContext
                                                                      context,
                                                                  AutocompleteOnSelected<
                                                                          NombreModel>
                                                                      onSelected,
                                                                  Iterable<
                                                                          NombreModel>
                                                                      options) {
                                                                return Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child:
                                                                      Material(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          300,
                                                                      child: ListView
                                                                          .builder(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        itemCount:
                                                                            options.length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          final NombreModel
                                                                              option =
                                                                              options.elementAt(index);

                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              onSelected(option);
                                                                            },
                                                                            child:
                                                                                ListTile(
                                                                              title: Text(option.nombre, style: const TextStyle(color: Colores.secundario)),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      color: Colores.secundario,
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          'Anestesiologo',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 500,
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                              'Buscar Nombre Anestesiologo: '),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          internacion),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataAnestesiologo
                                                                    .where((NombreModel continent) => continent
                                                                        .nombre
                                                                        .toLowerCase()
                                                                        .startsWith(textEditingValue
                                                                            .text
                                                                            .toLowerCase()))
                                                                    .toList();
                                                              },
                                                              displayStringForOption:
                                                                  (NombreModel
                                                                          option) =>
                                                                      option
                                                                          .nombre,
                                                              fieldViewBuilder: (BuildContext
                                                                      context,
                                                                  TextEditingController
                                                                      fieldTextEditingController,
                                                                  FocusNode
                                                                      fieldFocusNode,
                                                                  VoidCallback
                                                                      onFieldSubmitted) {
                                                                return TextField(
                                                                  controller:
                                                                      fieldTextEditingController,
                                                                  focusNode:
                                                                      fieldFocusNode,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                );
                                                              },
                                                              onSelected:
                                                                  (NombreModel
                                                                      selection) {
                                                                setState(() {
                                                                  internacion =
                                                                      selection
                                                                          .nombre;
                                                                });
                                                                print(
                                                                    'Selected: ${selection.nombre}');
                                                              },
                                                              optionsViewBuilder: (BuildContext
                                                                      context,
                                                                  AutocompleteOnSelected<
                                                                          NombreModel>
                                                                      onSelected,
                                                                  Iterable<
                                                                          NombreModel>
                                                                      options) {
                                                                return Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child:
                                                                      Material(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          300,
                                                                      child: ListView
                                                                          .builder(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        itemCount:
                                                                            options.length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          final NombreModel
                                                                              option =
                                                                              options.elementAt(index);

                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              onSelected(option);
                                                                            },
                                                                            child:
                                                                                ListTile(
                                                                              title: Text(option.nombre, style: const TextStyle(color: Colores.secundario)),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      color: Colores.secundario,
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          'Tecnico Anestesia',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 500,
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                              'Buscar Nombre Tecnico Anestesia: '),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          internacion),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataAnestesiologo
                                                                    .where((NombreModel continent) => continent
                                                                        .nombre
                                                                        .toLowerCase()
                                                                        .startsWith(textEditingValue
                                                                            .text
                                                                            .toLowerCase()))
                                                                    .toList();
                                                              },
                                                              displayStringForOption:
                                                                  (NombreModel
                                                                          option) =>
                                                                      option
                                                                          .nombre,
                                                              fieldViewBuilder: (BuildContext
                                                                      context,
                                                                  TextEditingController
                                                                      fieldTextEditingController,
                                                                  FocusNode
                                                                      fieldFocusNode,
                                                                  VoidCallback
                                                                      onFieldSubmitted) {
                                                                return TextField(
                                                                  controller:
                                                                      fieldTextEditingController,
                                                                  focusNode:
                                                                      fieldFocusNode,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                );
                                                              },
                                                              onSelected:
                                                                  (NombreModel
                                                                      selection) {
                                                                setState(() {
                                                                  internacion =
                                                                      selection
                                                                          .nombre;
                                                                });
                                                                print(
                                                                    'Selected: ${selection.nombre}');
                                                              },
                                                              optionsViewBuilder: (BuildContext
                                                                      context,
                                                                  AutocompleteOnSelected<
                                                                          NombreModel>
                                                                      onSelected,
                                                                  Iterable<
                                                                          NombreModel>
                                                                      options) {
                                                                return Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child:
                                                                      Material(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          300,
                                                                      child: ListView
                                                                          .builder(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        itemCount:
                                                                            options.length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          final NombreModel
                                                                              option =
                                                                              options.elementAt(index);

                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              onSelected(option);
                                                                            },
                                                                            child:
                                                                                ListTile(
                                                                              title: Text(option.nombre, style: const TextStyle(color: Colores.secundario)),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                });
                          },
                          icon: Image.asset(
                            'assets/img/anestesia.png',
                            color: Colors.white,
                            width: 40,
                          ),
                          label: const Text('ANESTESIA')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      width: 250,
                      child: ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context, setState) {
                                      return SingleChildScrollView(
                                        child: SizedBox(
                                          height: 400,
                                          child: Column(
                                            children: [
                                              Text(
                                                'Motivo de Retraso',
                                                style: GoogleFonts.encodeSans(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 500,
                                                child: DropDown(
                                                  isExpanded: true,
                                                  items: const [
                                                    'ANESTESIOLOGO',
                                                    'ARMADO DE MESA QUIRURGICA',
                                                    'CAMA PARA POST OPERATORIO',
                                                    'CAMBIO DE HORARIO',
                                                    'CIRUGIA ANTERIOR (TIEMPO)',
                                                    'CIRUGIA ANTERIOR (URGENCIA)',
                                                    'CIRUJANO',
                                                    'CIRUJANO Y ANESTESIOLOGO',
                                                    'FALTA DE MEDICO PARA TRASLADO',
                                                    'FALTA DE MEDICO RECUPERADOR',
                                                    'HORARIO DE PEDIDO',
                                                    'INCONVENIENTES TECNICOS CON MATERIAL ESTERIL',
                                                    'INCONVENIENTES TECNICOS DE EQUIPAMIENTO',
                                                    'MATERIAL DE ORTOPEDIA',
                                                    'PACIENTE (ESTUDIO PREVIO)',
                                                    'PACIENTE (INTERNACION)',
                                                    'PACIENTE (PREPARACION)',
                                                    'POR FALTA DE PERSONAL DE INSTRUMENTACIÓN',
                                                    'PREPARACION DE QUIROFANO',
                                                    'SIN CONSENTIMIENTO',
                                                    'TRASLADO',
                                                    'PERFUSIONISTA',
                                                  ],
                                                  hint:
                                                      const Text("Elegir Rol"),
                                                  icon: const Icon(
                                                    Icons.expand_more,
                                                    color: Colors.blue,
                                                  ),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      rolMedico = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                });
                          },
                          icon: Image.asset(
                            'assets/img/retraso.png',
                            color: Colors.white,
                            width: 40,
                          ),
                          label: const Text('RETRASO')),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
