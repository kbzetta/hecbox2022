import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Psq extends StatefulWidget {
  const Psq({Key? key}) : super(key: key);

  @override
  _PsqState createState() => _PsqState();
}

class _PsqState extends State<Psq> {
  //EN EL INGRESO//
  bool ficha = false;
  bool protesis = false;
  bool lentes = false;
  bool objetos = false;
  bool confirmado = false;
  bool identidad = false;
  bool procedimiento = false;
  bool consentimiento = false;
  bool esmalte = false;
  //TIENE EL PACIENTE//
  bool alergias = false;
  bool tipoalergia = false;
  bool dificultad = false;
  bool equipos = false;
  bool riesgo = false;
  bool accesos = false;

  // ANTES DE LA INDUCCION ANESTESICA//

  bool identificacion = false;
  bool marca = false;
  bool control = false;
  bool pulximetro = false;
  bool profilaxis = false;
  bool horaaplicacion = false;
  bool dosis = false;
  bool corrugado = false;
  bool filtro = false;

  // ANTES DE LA INCICION//

  // ANTES DEL CIERRE//

  // ANTES DE SALIR DEL  QUIROFANO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff00AFEF),
        centerTitle: true,
        title:
            Image.asset('assets/img/logo.png', width: 200, fit: BoxFit.cover),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                'En el Ingreso',
                textAlign: TextAlign.center,
                style: GoogleFonts.encodeSans(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('aplica ficha preoperatoria'.toUpperCase()),
                      trailing: Switch(
                        value: ficha,
                        onChanged: (value) {
                          setState(() {
                            ficha = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('prótesis odontológica'.toUpperCase()),
                      trailing: Switch(
                        value: protesis,
                        onChanged: (value) {
                          setState(() {
                            protesis = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('lentes'.toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('objetos de valor'.toUpperCase()),
                      trailing: Switch(
                        value: objetos,
                        onChanged: (value) {
                          setState(() {
                            objetos = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('paciente confirmado'.toUpperCase()),
                      trailing: Switch(
                        value: confirmado,
                        onChanged: (value) {
                          setState(() {
                            confirmado = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('identidad'.toUpperCase()),
                      trailing: Switch(
                        value: identidad,
                        onChanged: (value) {
                          setState(() {
                            identidad = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('procedimiento'.toUpperCase()),
                      trailing: Switch(
                        value: procedimiento,
                        onChanged: (value) {
                          setState(() {
                            procedimiento = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('consentimiento informado'.toUpperCase()),
                      trailing: Switch(
                        value: consentimiento,
                        onChanged: (value) {
                          setState(() {
                            consentimiento = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('esmalte de uñas'.toUpperCase()),
                      trailing: Switch(
                        value: esmalte,
                        onChanged: (value) {
                          setState(() {
                            esmalte = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Text(
                'Tiene el Paciente',
                textAlign: TextAlign.center,
                style: GoogleFonts.encodeSans(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('alergia conocidas'.toUpperCase()),
                      trailing: Switch(
                        value: alergias,
                        onChanged: (value) {
                          setState(() {
                            alergias = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('tipo alergia'.toUpperCase()),
                      trailing: Switch(
                        value: tipoalergia,
                        onChanged: (value) {
                          setState(() {
                            tipoalergia = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('dificultad vía aérea/riesgo de aspiración'
                          .toUpperCase()),
                      trailing: Switch(
                        value: dificultad,
                        onChanged: (value) {
                          setState(() {
                            dificultad = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('equipos/ ayuda disponible'.toUpperCase()),
                      trailing: Switch(
                        value: equipos,
                        onChanged: (value) {
                          setState(() {
                            equipos = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('riesgo perdida de sangre'.toUpperCase()),
                      trailing: Switch(
                        value: riesgo,
                        onChanged: (value) {
                          setState(() {
                            riesgo = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title:
                          Text('se disponen accesos y fluidos'.toUpperCase()),
                      trailing: Switch(
                        value: accesos,
                        onChanged: (value) {
                          setState(() {
                            accesos = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Text(
                'Antes de la inducción anestésica',
                textAlign: TextAlign.center,
                style: GoogleFonts.encodeSans(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title:
                          Text('identificación sitio quirúrgico'.toUpperCase()),
                      trailing: Switch(
                        value: identificacion,
                        onChanged: (value) {
                          setState(() {
                            identificacion = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title:
                          Text('marca localización quirúrgico'.toUpperCase()),
                      trailing: Switch(
                        value: marca,
                        onChanged: (value) {
                          setState(() {
                            marca = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(' control seguridad anestésica por protocolo'
                          .toUpperCase()),
                      trailing: Switch(
                        value: control,
                        onChanged: (value) {
                          setState(() {
                            control = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('pulsioxímetro funcionando'.toUpperCase()),
                      trailing: Switch(
                        value: pulximetro,
                        onChanged: (value) {
                          setState(() {
                            pulximetro = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('profilaxis antibiótica'.toUpperCase()),
                      trailing: Switch(
                        value: profilaxis,
                        onChanged: (value) {
                          setState(() {
                            profilaxis = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('hora aplicación'.toUpperCase()),
                      trailing: Switch(
                        value: horaaplicacion,
                        onChanged: (value) {
                          setState(() {
                            horaaplicacion = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('dosis aplicación profilaxis'.toUpperCase()),
                      trailing: Switch(
                        value: dosis,
                        onChanged: (value) {
                          setState(() {
                            dosis = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title:
                          Text(' corrugado de mesa primer uso'.toUpperCase()),
                      trailing: Switch(
                        value: corrugado,
                        onChanged: (value) {
                          setState(() {
                            corrugado = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('filtro vía aérea primer uso'.toUpperCase()),
                      trailing: Switch(
                        value: filtro,
                        onChanged: (value) {
                          setState(() {
                            filtro = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Text(
                'Antes de la incisión',
                textAlign: TextAlign.center,
                style: GoogleFonts.encodeSans(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('revisión indicadores ante esterilización'
                          .toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('revisión aspecto material'.toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('revisión acondicionamiento de posición'
                          .toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('revisión  acondicionamiento de cubitos'
                          .toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('revisión acondicionamientos de equipos'
                          .toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('imágenes a la vista'.toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                          'correcta colocación placa paciente'.toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Text(
                'Antes del cierre',
                textAlign: TextAlign.center,
                style: GoogleFonts.encodeSans(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                          'cambio diagnostico pre operatorio'.toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                          'conteo/registros de  gasas correcto'.toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('conteo / registro instrumental correcto'
                          .toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                          'conteo/ registros de agujas correcto'.toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Text(
                'Antes de salir del quirófano',
                textAlign: TextAlign.center,
                style: GoogleFonts.encodeSans(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title:
                          Text(' se tomaron muestras biológicas'.toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('cantidad  de muestras anatomía patológica'
                          .toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title:
                          Text('cantidad  muestras laboratorio'.toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('acondicionamiento muestras biológicas'
                          .toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                          ' identificación muestras biológicas'.toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('se colocaron drenajes'.toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(' acondicionamiento drenajes'.toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('acondicionamiento heridas  quirúrgicas'
                          .toUpperCase()),
                      trailing: Switch(
                        value: lentes,
                        onChanged: (value) {
                          setState(() {
                            lentes = value;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
