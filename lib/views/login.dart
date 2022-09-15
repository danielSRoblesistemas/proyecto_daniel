import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_daniel/global/colores.dart';
import 'package:proyecto_daniel/views/home_view.dart';
import 'package:proyecto_daniel/widgets/button_widget.dart';
import 'package:proyecto_daniel/widgets/popaap_ficha.dart';
import 'package:proyecto_daniel/widgets/textfield_widget.dart';
import '../utils/responsive_con_context.dart';
import 'package:proyecto_daniel/utils/size.dart';

// import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            //  decoration: boxde,
            child: Row(
      children: [const _ColumnaTeal(), const _ColumnaLogin()],
    )));
  }
}

class _ColumnaTeal extends StatelessWidget {
  const _ColumnaTeal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.ancho * 40,
      color: Colors.teal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(children: [
            const SizedBox(width: 20),
            const Icon(Icons.home, color: Colors.orange, size: 35),
            Text(
              'Practica',
              style: GoogleFonts.balooDa2(
                fontSize: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 20, tablet: 20, mobile: 20, phone: 10),
                color: Colores.letraGrisBlanca,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          SizedBox(height: context.alto * 25),
          Text(
            'Bienvenido al Sistema',
            style: GoogleFonts.balooDa2(
              fontSize: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 35, tablet: 30, mobile: 20, phone: 20),
              color: Colores.letraGrisBlanca,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Un Sistema únicamente de practica Introductoria',
            style: GoogleFonts.roboto(
              fontSize: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 13, tablet: 13, mobile: 11, phone: 11),
              color: Colores.letraGrisBlanca,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Para ponerse a la altura',
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: Colores.letraGrisBlanca,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 35),
          ButtonModeWidget.botonSimple(
            width: 150,
            height: 40,
            titulo: 'Registrarme',
            tamanioTexto: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 16, tablet: 14, mobile: 14, phone: 12),
            onPressed: () {
              showDialog<String>(
                  barrierDismissible: true,
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (context) => BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: PopAppSolicitudes(
                            titulo: 'Iniciar sesion',
                            altoPorc:
                                ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 50, tablet: 40, mobile: 50, phone: 40),
                            isBotonSalir: true,
                            paddingContenido: const EdgeInsets.symmetric(horizontal: 10),
                            paddingTitulo: const EdgeInsets.only(top: 0),
                            child: const _PopAppRegistro()), // _ProductoModal()
                      ));
            },
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }
}

class _ColumnaLogin extends StatefulWidget {
  const _ColumnaLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<_ColumnaLogin> createState() => _ColumnaLoginState();
}

class _ColumnaLoginState extends State<_ColumnaLogin> {
  bool ocultarTexto = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.ancho * 60,
      color: Colores.grisFondo,
      child: Column(
        children: [
          SizedBox(height: context.alto * 15),
          Text(
            'Iniciar Sesion',
            style: GoogleFonts.balooDa2(
              fontSize: 40,
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.whatsapp, color: Colors.black),
              SizedBox(width: context.ancho * 2),
              const Icon(Icons.mail, color: Colors.black),
              SizedBox(width: context.ancho * 2),
              const Icon(Icons.help, color: Colors.black),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            'Inicie sesion con una cuenta ya existente',
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextfieldModelWidget.estandar(labelTitulo: 'Nombre Usuario', maxWidth: context.ancho * 30),
          const SizedBox(height: 10),
          TextfieldModelWidget.contrasena(
            maxWidth: context.ancho * 30,
            obscureText: ocultarTexto,
            ontap: () => setState(() => ocultarTexto = !ocultarTexto) , 
            labelTitulo: 'Contraseña',
            
             ),
          const SizedBox(height: 30),
          ButtonModeWidget.botonSimple(
            width: 150,
            height: 40,
            titulo: 'Entrar',
            tamanioTexto: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 16, tablet: 14, mobile: 14, phone: 12),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home'); //(context, HomeView());
            },
          )
        ],
      ),
    );
  }
}

class _PopAppRegistro extends StatelessWidget {
  const _PopAppRegistro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colores.grisFondo,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            'Cree una nueva cuenta de inicio',
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextfieldModelWidget.estandar(labelTitulo: 'Nombre de Usuario', maxWidth: context.ancho * 20),
          const SizedBox(height: 10),
          TextfieldModelWidget.contrasena(
            maxWidth: context.ancho * 20,
            labelTitulo: 'Contraseña',
            ontap: () {},
              ),
          const SizedBox(height: 10),
          TextfieldModelWidget.contrasena(maxWidth: context.ancho * 20, ontap: () {}, labelTitulo: 'Repetir Contraseña'),
          const SizedBox(height: 30),
          ButtonModeWidget.botonSimple(
            width: 125,
            height: 30,
            onPressed: () {},
            titulo: 'Registrarme',
            tamanioTexto: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 14, tablet: 14, mobile: 14, phone: 12),
          )
        ],
      ),
    );
  }
}
