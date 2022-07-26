import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hecbox/ConfigGenerales.dart';
import 'package:hecbox/Modelos/piqModelos.dart';
import 'package:hecbox/Vistas/psqVista.dart';
import 'package:http/http.dart' as http;

class PiqVista extends StatefulWidget {
  String paciente;
  PiqVista({Key? key, required this.paciente}) : super(key: key);

  @override
  State<PiqVista> createState() => _PiqVistaState();
}

class _PiqVistaState extends State<PiqVista> {
/////// especialidad ////////
  List<NombreModel> dataEspecialidad = <NombreModel>[];
  Future<void> getEspecialidad() async {
    http.Response res = await http.get(Uri.parse("$serverUrl/especialidads"));

    var jsonData = jsonDecode(res.body);
    List<NombreModel> resultList = List<NombreModel>.from(
        json.decode(res.body).map((x) => NombreModel.fromMap(x)));

    setState(() {
      dataEspecialidad = resultList;
    });
  }

  /////// procedimiento ////////
  List<NombreModel> dataProcedimiento = <NombreModel>[];
  Future<void> getProcedimiento() async {
    http.Response res =
        await http.get(Uri.parse("$serverUrl/procedimiento-tipos"));

    var jsonData = jsonDecode(res.body);
    List<NombreModel> resultList = List<NombreModel>.from(
        json.decode(res.body).map((x) => NombreModel.fromMap(x)));

    setState(() {
      dataProcedimiento = resultList;
    });
  }

  ////// anestesia /////
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

  ////// hemoterapia /////
  List<NombreModel> dataHemoterapia = <NombreModel>[];
  Future<void> getHemoterapia() async {
    http.Response res =
        await http.get(Uri.parse("$serverUrl/hemoterapia-tipos"));

    var jsonData = jsonDecode(res.body);
    List<NombreModel> resultList = List<NombreModel>.from(
        json.decode(res.body).map((x) => NombreModel.fromMap(x)));

    setState(() {
      dataHemoterapia = resultList;
    });
  }

  ////// equipo /////
  List<NombreModel> dataEquipo = <NombreModel>[];
  Future<void> getEquipo() async {
    http.Response res = await http.get(Uri.parse("$serverUrl/profesionales"));

    var jsonData = jsonDecode(res.body);
    List<NombreModel> resultList = List<NombreModel>.from(
        json.decode(res.body).map((x) => NombreModel.fromMap(x)));

    setState(() {
      dataEquipo = resultList;
    });
  }

  ////// instrumental /////
  List<NombreModel> dataInstrumental = <NombreModel>[];
  Future<void> getInstrumental() async {
    http.Response res =
        await http.get(Uri.parse("$serverUrl/instrumental-tipos"));

    var jsonData = jsonDecode(res.body);
    List<NombreModel> resultList = List<NombreModel>.from(
        json.decode(res.body).map((x) => NombreModel.fromMap(x)));

    setState(() {
      dataInstrumental = resultList;
    });
  }

  ////// Pouch /////
  List<NombreModel> dataPouch = <NombreModel>[];
  Future<void> getPouch() async {
    http.Response res =
        await http.get(Uri.parse("$serverUrl/instrumental-tipos"));

    var jsonData = jsonDecode(res.body);
    List<NombreModel> resultList = List<NombreModel>.from(
        json.decode(res.body).map((x) => NombreModel.fromMap(x)));

    setState(() {
      dataPouch = resultList;
    });
  }

  @override
  void initState() {
    getEspecialidad();
    getAnestesia();
    getInstrumental();
    getHemoterapia();
    getEquipo();
    getProcedimiento();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String operacionId = widget.paciente;
    String diagnostico;
    String creadoPor;

    String rayos;
    String equipo = '';
    String especialidad = '';
    String pouch = '';
    String anestesia = '';
    String procedimiento = '';
    String hemoterapia = '';
    var hemoterapiaCantidad = '';

    final NombreMedicoController = TextEditingController();
    final MatriculaMedicoController = TextEditingController();

    final hemoCantController = TextEditingController();

    String? rolMedico = 'Elegir Rol';
    String rolTecnico = 'Elegir Rol';

    bool esdelhospitalMedico = false;
    bool esdelHospitalTecnico = false;

    // List of items in our dropdown menu

    String dropdownValue = 'Elegir Rol';

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                Get.to(const Psq());
              },
              icon: const Icon(Icons.ac_unit),
              label: const Text('PSQ'))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
              height: 600,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      width: 250,
                      child: ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                                enableDrag: true,
                                context: context,
                                builder: (BuildContext context) {
                                  bool rayo = false;
                                  bool bomba = false;
                                  return StatefulBuilder(builder:
                                      (BuildContext context, setState) {
                                    return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10.0, 20.0, 20.0, 20.0),
                                        child: Card(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                  'PROCEDIMIENTO',
                                                  style: GoogleFonts.encodeSans(
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Card(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              'Elegir Especialidad: '),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          especialidad),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataEspecialidad
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
                                                                  especialidad =
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
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              'Elegir Anestesia: '),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          anestesia),
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
                                                                  anestesia =
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
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextFormField(
                                                          maxLines: 6,
                                                          maxLength: 250,
                                                          decoration:
                                                              const InputDecoration(
                                                                  hintText:
                                                                      'diagnostico'),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            const Text('Rayos'),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Switch(
                                                                  value: rayo,
                                                                  onChanged:
                                                                      (val) {
                                                                    setState(
                                                                        () {
                                                                      rayo =
                                                                          val;
                                                                    });
                                                                    print(rayo);
                                                                  },
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Bomba Extracorporea'),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Switch(
                                                                  value: bomba,
                                                                  onChanged:
                                                                      (val) {
                                                                    setState(
                                                                        () {
                                                                      bomba =
                                                                          val;
                                                                    });
                                                                    print(rayo);
                                                                  },
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                  });
                                });
                          },
                          icon: const Icon(
                            Icons.abc_sharp,
                            size: 60,
                          ),
                          label: const Text('PROCEDIMIENTO')),
                    ),
                  ),
                  ///// SAMO //////
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
                                      return SizedBox(
                                        height: 400,
                                        child: Column(
                                          children: [
                                            Text(
                                              'SAMO',
                                              style: GoogleFonts.encodeSans(
                                                fontSize: 35,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                    'Elegir Procedimiento Quirurgico: '),
                                                Expanded(
                                                  child:
                                                      Autocomplete<NombreModel>(
                                                    initialValue:
                                                        TextEditingValue(
                                                            text:
                                                                procedimiento),
                                                    optionsBuilder:
                                                        (TextEditingValue
                                                            textEditingValue) {
                                                      return dataProcedimiento
                                                          .where((NombreModel
                                                                  continent) =>
                                                              continent.nombre
                                                                  .toLowerCase()
                                                                  .startsWith(
                                                                      textEditingValue
                                                                          .text
                                                                          .toLowerCase()))
                                                          .toList();
                                                    },
                                                    displayStringForOption:
                                                        (NombreModel option) =>
                                                            option.nombre,
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
                                                    onSelected: (NombreModel
                                                        selection) {
                                                      setState(() {
                                                        procedimiento =
                                                            selection.nombre;
                                                      });
                                                      print(
                                                          'Selected: ${selection.nombre}');
                                                    },
                                                    optionsViewBuilder:
                                                        (BuildContext context,
                                                            AutocompleteOnSelected<
                                                                    NombreModel>
                                                                onSelected,
                                                            Iterable<
                                                                    NombreModel>
                                                                options) {
                                                      return Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Material(
                                                          child: SizedBox(
                                                            width: 300,
                                                            child: ListView
                                                                .builder(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              itemCount: options
                                                                  .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                final NombreModel
                                                                    option =
                                                                    options.elementAt(
                                                                        index);

                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    onSelected(
                                                                        option);
                                                                  },
                                                                  child:
                                                                      ListTile(
                                                                    title: Text(
                                                                        option
                                                                            .nombre,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colores.secundario)),
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
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(Icons.add))
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.abc_sharp,
                            size: 60,
                          ),
                          label: const Text('SAMO')),
                    ),
                  ),

                  //// HEMOTERAPIA ////
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
                                      return SizedBox(
                                        height: 400,
                                        child: Column(
                                          children: [
                                            Text(
                                              'HEMOTERAPIA',
                                              style: GoogleFonts.encodeSans(
                                                fontSize: 35,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                    'Elegir Tipo Hemoterapia: '),
                                                Expanded(
                                                  child:
                                                      Autocomplete<NombreModel>(
                                                    initialValue:
                                                        TextEditingValue(
                                                            text: hemoterapia),
                                                    optionsBuilder:
                                                        (TextEditingValue
                                                            textEditingValue) {
                                                      return dataHemoterapia
                                                          .where((NombreModel
                                                                  continent) =>
                                                              continent.nombre
                                                                  .toLowerCase()
                                                                  .startsWith(
                                                                      textEditingValue
                                                                          .text
                                                                          .toLowerCase()))
                                                          .toList();
                                                    },
                                                    displayStringForOption:
                                                        (NombreModel option) =>
                                                            option.nombre,
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
                                                    onSelected: (NombreModel
                                                        selection) {
                                                      setState(() {
                                                        hemoterapia =
                                                            selection.nombre;
                                                      });
                                                      print(
                                                          'Selected: ${selection.nombre}');
                                                    },
                                                    optionsViewBuilder:
                                                        (BuildContext context,
                                                            AutocompleteOnSelected<
                                                                    NombreModel>
                                                                onSelected,
                                                            Iterable<
                                                                    NombreModel>
                                                                options) {
                                                      return Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Material(
                                                          child: SizedBox(
                                                            width: 300,
                                                            child: ListView
                                                                .builder(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              itemCount: options
                                                                  .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                final NombreModel
                                                                    option =
                                                                    options.elementAt(
                                                                        index);

                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    onSelected(
                                                                        option);
                                                                  },
                                                                  child:
                                                                      ListTile(
                                                                    title: Text(
                                                                        option
                                                                            .nombre,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colores.secundario)),
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
                                            TextField(
                                                controller: hemoCantController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            'Colocar Cantidad'))
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.abc_sharp,
                            size: 60,
                          ),
                          label: const Text('HEMOTERAPIA')),
                    ),
                  ),
                  ///////// EQUIPO //////
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
                                      return SizedBox(
                                        height: 400,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Text(
                                                'EQUIPO',
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
                                                      const Text('Cirujano'),
                                                      const Divider(),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.person),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          equipo),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataEquipo
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
                                                                  equipo =
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
                                                      const Text('1ª Ayudante'),
                                                      const Divider(),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.person),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          equipo),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataEquipo
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
                                                                  equipo =
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
                                                      const Text('2ª Ayudante'),
                                                      const Divider(),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.person),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          equipo),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataEquipo
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
                                                                  equipo =
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
                                                      const Text(
                                                          'Anestesiologo'),
                                                      const Divider(),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.person),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          equipo),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataEquipo
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
                                                                  equipo =
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
                                                      const Text(
                                                          '1ª Instrumentador Aseptico'),
                                                      const Divider(),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.person),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          equipo),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataEquipo
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
                                                                  equipo =
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
                                                      const Text(
                                                          '2ª Instrumentador Aseptico'),
                                                      const Divider(),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.person),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          equipo),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataEquipo
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
                                                                  equipo =
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
                                                      const Text(
                                                          '3ª Instrumentador Aseptico'),
                                                      const Divider(),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.person),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          equipo),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataEquipo
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
                                                                  equipo =
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
                                                      const Text(
                                                          '1ª Instrumentador Circulante'),
                                                      const Divider(),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.person),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          equipo),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataEquipo
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
                                                                  equipo =
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
                                                      const Text(
                                                          '2ª Instrumentador Circulante'),
                                                      const Divider(),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.person),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          equipo),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataEquipo
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
                                                                  equipo =
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
                                                      const Text(
                                                          '3ª Instrumentador Circulante'),
                                                      const Divider(),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.person),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          equipo),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataEquipo
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
                                                                  equipo =
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
                                                    ],
                                                  ),
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
                          icon: const Icon(
                            Icons.abc_sharp,
                            size: 60,
                          ),
                          label: const Text('EQUIPO')),
                    ),
                  ),

                  //////   MEDICO/ TECNICO /////

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
                                      return SizedBox(
                                        height: 400,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Text(
                                                'AÑADIR MEDICO/TECNICO',
                                                style: GoogleFonts.encodeSans(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Card(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    children: [
                                                      const Text('Otro Medico'),
                                                      const Divider(),
                                                      DropDown(
                                                        initialValue: rolMedico,
                                                        isExpanded: true,
                                                        items: const [
                                                          '2ª Ayudante',
                                                          '3ª Ayudante',
                                                          '4ª Ayudante',
                                                          'Anatomopatologo',
                                                          'Cardiologo',
                                                          'Cirijano',
                                                        ],
                                                        hint: const Text(
                                                            "Elegir Rol"),
                                                        icon: const Icon(
                                                          Icons.expand_more,
                                                          color: Colors.blue,
                                                        ),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            rolMedico =
                                                                newValue!;
                                                          });
                                                        },
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              'Es del Hospital?'),
                                                          Switch(
                                                            value:
                                                                esdelhospitalMedico,
                                                            onChanged: (bool?
                                                                newValue) {
                                                              setState(() {
                                                                esdelhospitalMedico =
                                                                    newValue!;
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                      TextField(
                                                        controller:
                                                            NombreMedicoController,
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    ' Colocar Nombre Completo'),
                                                      ),
                                                      TextField(
                                                        controller:
                                                            MatriculaMedicoController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    ' Colocar Nª Matricula'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                          'Otro Tecnico'),
                                                      const Divider(),
                                                      DropDown(
                                                        isExpanded: true,
                                                        items: const [
                                                          'Radiologo',
                                                        ],
                                                        hint: const Text(
                                                            "Elegir Rol"),
                                                        icon: const Icon(
                                                          Icons.expand_more,
                                                          color: Colors.blue,
                                                        ),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            rolMedico =
                                                                newValue!;
                                                          });
                                                        },
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              'Es del Hospital?'),
                                                          Switch(
                                                            value:
                                                                esdelhospitalMedico,
                                                            onChanged: (bool?
                                                                newValue) {
                                                              setState(() {
                                                                esdelhospitalMedico =
                                                                    newValue!;
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                      TextField(
                                                        controller:
                                                            NombreMedicoController,
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    ' Colocar Nombre Completo'),
                                                      ),
                                                      TextField(
                                                        controller:
                                                            MatriculaMedicoController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    ' Colocar Nª Matricula'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.abc_sharp,
                            size: 60,
                          ),
                          label: const Text(
                            'AÑADIR MEDICO/TECNICO',
                          )),
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
                                      return SizedBox(
                                        height: 400,
                                        child: Column(
                                          children: [
                                            Text(
                                              'MUESTRAS',
                                              style: GoogleFonts.encodeSans(
                                                fontSize: 35,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    const Text(
                                                        'Añadir Muestra'),
                                                    const Divider(),
                                                    DropDown(
                                                      isExpanded: true,
                                                      items: const [
                                                        'Anatomia Patologica',
                                                        'Laboratorio',
                                                        'Pericial',
                                                      ],
                                                      hint: const Text(
                                                          "Elegir Tipo"),
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
                                                    const TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              hintText: ' ATB'),
                                                    ),
                                                    const TextField(
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              ' Material Remitido'),
                                                    ),
                                                    const TextField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              ' Cantidad de Frascos'),
                                                    )
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
                          icon: const Icon(
                            Icons.abc_sharp,
                            size: 60,
                          ),
                          label: const Text('MUESTRAS')),
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
                                      return SizedBox(
                                        height: 400,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Text(
                                                'IMPLANTES',
                                                style: GoogleFonts.encodeSans(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Card(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                          'Añadir Muestra'),
                                                      const Divider(),
                                                      DropDown(
                                                        isExpanded: true,
                                                        items: const [
                                                          'Implante',
                                                          'Protesis',
                                                        ],
                                                        hint: const Text(
                                                            "Elegir Familia"),
                                                        icon: const Icon(
                                                          Icons.expand_more,
                                                          color: Colors.blue,
                                                        ),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            rolMedico =
                                                                newValue!;
                                                          });
                                                        },
                                                      ),
                                                      const TextField(
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    ' ATB'),
                                                      ),
                                                      const TextField(
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    ' Material'),
                                                      ),
                                                      const TextField(
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    ' Tipo'),
                                                      ),
                                                      const TextField(
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    ' Material'),
                                                      ),
                                                      const TextField(
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    ' Modelo'),
                                                      ),
                                                      const TextField(
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    ' Serie'),
                                                      ),
                                                      const TextField(
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                ' Proveedores'),
                                                      ),
                                                      const TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    ' Cantidad'),
                                                      )
                                                    ],
                                                  ),
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
                          icon: const Icon(
                            Icons.abc_sharp,
                            size: 60,
                          ),
                          label: const Text('IMPLANTES')),
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
                                      return SizedBox(
                                        height: 400,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Text(
                                                'CONSUMIBLES',
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
                                                      const Text(
                                                          'Agujas Atraumanticas'),
                                                      const Divider(),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Inicio')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(
                                                                  Icons.stop),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Fin')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
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
                                                      const Text('Agujas Ojo'),
                                                      const Divider(),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Inicio')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(
                                                                  Icons.stop),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Fin')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
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
                                                      const Text('Camisolines'),
                                                      const Divider(),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Inicio')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(
                                                                  Icons.stop),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Fin')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
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
                                                      const Text(
                                                          'Campos Chicos'),
                                                      const Divider(),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Inicio')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(
                                                                  Icons.stop),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Fin')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
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
                                                      const Text(
                                                          'Campos Fenestrados'),
                                                      const Divider(),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Inicio')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(
                                                                  Icons.stop),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Fin')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
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
                                                      const Text(
                                                          'Campos Grandes'),
                                                      const Divider(),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Inicio')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(
                                                                  Icons.stop),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Fin')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
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
                                                      const Text('Compresas'),
                                                      const Divider(),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Inicio')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(
                                                                  Icons.stop),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Fin')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
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
                                                      const Text(
                                                          'Gasas Chicas'),
                                                      const Divider(),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Inicio')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(
                                                                  Icons.stop),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Fin')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
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
                                                      const Text(
                                                          'Gasas Grandes'),
                                                      const Divider(),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Inicio')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(
                                                                  Icons.stop),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Fin')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
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
                                                      const Text(
                                                          'Gasas Piramidales'),
                                                      const Divider(),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Inicio')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(
                                                                  Icons.stop),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Fin')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
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
                                                      const Text(
                                                          'Gasas Radiolucidas'),
                                                      const Divider(),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Inicio')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(
                                                                  Icons.stop),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Fin')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
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
                                                      const Text('Hisopos'),
                                                      const Divider(),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Inicio')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(
                                                                  Icons.stop),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Fin')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
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
                                                      const Text('Pinzas'),
                                                      const Divider(),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Inicio')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(
                                                                  Icons.stop),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Fin')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
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
                                                      const Text('Saleas'),
                                                      const Divider(),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Inicio')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 400,
                                                        child: Row(
                                                          children: const [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Icon(
                                                                  Icons.stop),
                                                            ),
                                                            SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                    'Fin')),
                                                            Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            SizedBox(
                                                              width: 50,
                                                              child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          hintText:
                                                                              'Cant')),
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
                                        ),
                                      );
                                    },
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.abc_sharp,
                            size: 60,
                          ),
                          label: const Text('CONSUMIBLES')),
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
                                      return SizedBox(
                                        height: 400,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Text(
                                                'INSTRUMENTAL',
                                                style: GoogleFonts.encodeSans(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Card(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                          ' Añadir Instrumental'),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              'Elegir Tipo Instrumental: '),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          hemoterapia),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataInstrumental
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
                                                                  hemoterapia =
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
                                                          IconButton(
                                                              onPressed: () {},
                                                              icon: const Icon(
                                                                  Icons.add))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.abc_sharp,
                            size: 60,
                          ),
                          label: const Text('INSTRUMENTAL')),
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
                                      return SizedBox(
                                        height: 400,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Text(
                                                'POUCH',
                                                style: GoogleFonts.encodeSans(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Card(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                          ' Añadir Instrumental'),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              'Elegir Tipo Instrumental: '),
                                                          Expanded(
                                                            child: Autocomplete<
                                                                NombreModel>(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text:
                                                                          pouch),
                                                              optionsBuilder:
                                                                  (TextEditingValue
                                                                      textEditingValue) {
                                                                return dataPouch
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
                                                                  pouch =
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
                                                          IconButton(
                                                              onPressed: () {},
                                                              icon: const Icon(
                                                                  Icons.add))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.abc_sharp,
                            size: 60,
                          ),
                          label: const Text('POUCH')),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
