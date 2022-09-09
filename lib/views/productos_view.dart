import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_daniel/global/colores.dart';
import 'package:proyecto_daniel/utils/size.dart';
import 'package:proyecto_daniel/widgets/button_widget.dart';
import 'package:proyecto_daniel/widgets/textfield_widget.dart';


class VistaPrimeraView extends StatelessWidget {
  
  const VistaPrimeraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(top: 20),
      color: Colores.grisFondo,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: context.ancho * 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              children:  [
                Text(
                  'Producto',
                  style: GoogleFonts.montserratAlternates( //prompt, roboto
                    fontSize: 25,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('aca va ir mi tabla de producto recorrida por el toJson del modelo producto'),
                const _ProductoVista()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductoVista extends StatelessWidget {
  const _ProductoVista({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
        child: Column(
          children: [
            TextfieldModelWidget(
              maxWidth: 600,
              controller: TextEditingController(),
              labelTitulo: 'Id Producto',
              obscureText: false,
              decoration: const InputDecoration(),
              desactivarCampo: false, // textInputAction: TextInputAction.go,
            ),


            //esto era de prueba no mas tengo que hacer mi tabla con el toJson
            const SizedBox(height: 20),
            TextfieldModelWidget.estandar(maxWidth: 600,labelTitulo: 'Descripcion de Producto'),
            const SizedBox(height: 40),
            ButtonModeWidget.botonSimple(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colores.botonVerde)),
                titulo: 'Guardar',
                onPressed: () {
                  log('onPressed de Boton Guardar Producto, pero no va porque primero la vista,');
                }),
            const SizedBox(height: 30),
          ],
        ));
  }
}