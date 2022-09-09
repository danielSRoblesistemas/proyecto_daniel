import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:proyecto_daniel/global/colores.dart';
import 'package:proyecto_daniel/utils/responsive_wrapper_utils.dart';
import 'package:proyecto_daniel/views/productos_view.dart';



class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          if (ResponsiveWrapperUtils(context).mostrarCuando(mobile: true, tablet: true, desktop: true)) const _MenuLateral(),
           const Expanded(child: VistaPrimeraView()) //VistaPrimeraView
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
