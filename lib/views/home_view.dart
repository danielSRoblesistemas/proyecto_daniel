import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proyecto_daniel/bloc/notificaciones/notificaciones_bloc.dart';

import 'package:proyecto_daniel/global/colores.dart';
import 'package:proyecto_daniel/utils/responsive_con_context.dart';
import 'package:proyecto_daniel/utils/responsive_wrapper_utils.dart';
import 'package:proyecto_daniel/views/productos_view.dart';
import 'package:proyecto_daniel/widgets/notificacion_widget.dart';
import 'package:proyecto_daniel/utils/size.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ancho  = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Practica',
          style: TextStyle(
            fontSize: 27,
            color: Colores.letraGrisBlanca,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colores.verdeOscuroFondo,
        actions: [
          ClipRRect(
            child: Container(
              color: Colors.red,
            ),
          )
        ],
      ),
      body: Row(
        children: [
          if (ResponsiveWrapperUtils(context).mostrarCuando(mobile: true, tablet: true, desktop: true) )
            const _MenuLateral(),
          SizedBox(
              width: ResponsiveWrapperUtilsContext.determinarTamano(
            context,
            desktop: context.ancho * 18,
            tablet: context.ancho * 18,
            mobile: context.ancho * 8,
            phone: context.ancho * 1,
          )),
          Expanded(
              child: Stack(
            children: [
              const VistaPrimeraView(),
              BlocBuilder<NotificacionesBloc, NotificacionesState>(
                builder: (context, state) {
                  return Positioned(
                    left: context.ancho * 15,
                    child: Column(
                      children: state.notificaciones.entries
                          .map((e) => NotificacionWidget.agregaNotificacion(indice: e.key, notificacion: e.value))
                          .toList(),
                    ),
                  );
                },
              ),
            ],
          )), //VistaPrimeraView
          SizedBox(
              width: ResponsiveWrapperUtilsContext.determinarTamano(
            context,
            desktop: context.ancho * 5,
            tablet: context.ancho * 5,
            mobile: context.ancho * 1,
            phone: context.ancho * 1,
          ))
        ],
      ),
    );
  }
}

class _MenuLateral extends StatelessWidget {
  const _MenuLateral({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            height: 600,
            width: 150,
            color: Colors.teal,
            child: Column(
              children: [
                const Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  height: 35,
                ),
                ItemMenu(
                    titulo: 'Producto',
                    icono: Icons.shop_outlined,
                    onTap: () {
                      log('Producto');
                    }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    Key? key,
    required this.titulo,
    required this.icono,
    required this.onTap,
  }) : super(key: key);

  final String titulo;
  final IconData icono;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 15,
            color: Colores.letraGrisBlanca,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(icono, color: Colors.white)
      ]),
    );
  }
}
