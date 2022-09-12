import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:proyecto_daniel/bloc/producto_bloc/producto_bloc.dart';
import 'package:proyecto_daniel/global/colores.dart';
import 'package:proyecto_daniel/global/environment.dart';
import 'package:proyecto_daniel/model/producto_model.dart';
import 'package:proyecto_daniel/utils/size.dart';
import 'package:proyecto_daniel/utils/responsive_wrapper_utils.dart';
import 'package:proyecto_daniel/widgets/button_widget.dart';
import 'package:proyecto_daniel/widgets/data_cell_model_widget.dart';
import 'package:proyecto_daniel/widgets/item_formulario.dart';
import 'package:proyecto_daniel/widgets/popaap_ficha.dart';

import 'package:proyecto_daniel/widgets/text_widget.dart';

import '../utils/responsive_con_context.dart';

class VistaPrimeraView extends StatelessWidget {
  const VistaPrimeraView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductoBloc, ProductoState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
        if (state.error.isEmpty) {
          if (state.accion == Environment.blocOnNuevoProducto || state.accion == Environment.blocOnModificarProducto) {
            showDialog<String>(
                context: context,
                builder: (context) => PopAppSolicitudes(
                    titulo: (state.producto.id.isNotEmpty) ? 'Ficha Categoria' : 'Alta Categoria', //state.chatbot.nombre
                    altoPorc: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 40, tablet: 30, mobile: 30, phone: 35),
                    isBotonSalir: true,
                    // ancho: 1000,
                    paddingContenido: const EdgeInsets.symmetric(horizontal: 10),
                    paddingTitulo: const EdgeInsets.only(top: 0),
                    child: _ProductoModal()));
            // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FichaProductoView()));
            //esta navegacion no va a funcar esta solo de referencia
          }
          if (state.accion == Environment.blocOnValidaProducto) {
            context.read<ProductoBloc>().add(const OnGuardarProducto());
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        return Container(
          height: double.infinity,
          padding: const EdgeInsets.only(
            top: 20,
          ),
          color: Colores.grisFondo,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Productos',
                  style: GoogleFonts.roboto(
                    fontSize: 25,
                    color: Colores.verdeOscuroFondo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<ProductoBloc>().add(const OnNuevoProducto());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Expanded(child: const SizedBox(height: 30)),
                      const Icon(Icons.add, color: Colors.orange, size: 20),
                      TextModelWidget.titulo(texto: 'Nuevo Producto', tamanioTexto: 15, colorTexto: Colors.orange),
                      const SizedBox(width: 30)
                    ],
                  ),
                ),
                DataTable(
                    horizontalMargin: 0,
                    columnSpacing: 0,
                    headingRowHeight: 25,
                    dataRowHeight: 30,
                    headingRowColor: MaterialStateProperty.all<Color>(Colores.grisFondo),
                    columns: [
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            alignment: Alignment.centerLeft,
                            height: 25,
                            width: context.ancho * 20,
                            child: TextModelWidget.titulo(
                              tamanioTexto: 12,
                              tipoFuente: FontWeight.w600,
                              texto: 'ID Producto',
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            alignment: Alignment.centerLeft,
                            height: 25,
                            width: context.ancho * 20,
                            child: TextModelWidget.titulo(
                              tamanioTexto: 12,
                              tipoFuente: FontWeight.w600,
                              texto: 'Descripcion',//state.listaProductos.length.toString()
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      ...state.listaProductos
                          .map((e) => DataRow(cells: [
                                DataCellModelWidget.modelo(
                                  anchoCampo: context.tamanoParaDispositivo(desktop: context.ancho * 45, phone: context.ancho * 50),
                                  padding: const EdgeInsets.only(left: 5),
                                  valor: e.id,
                                  ontap: () {
                                    context.read<ProductoBloc>().add( OnModificarProducto(idProducto: e.id));
                                  },
                                ),
                                DataCellModelWidget.modelo(
                                  anchoCampo: context.tamanoParaDispositivo(desktop: context.ancho * 35, phone: context.ancho * 50),
                                  padding: const EdgeInsets.only(left: 5),
                                  valor: e.descripcion,
                                  ontap: () {
                                    // context.read<ProductoBloc>().add(const OnNuevoProducto());
                                    context.read<ProductoBloc>().add( OnModificarProducto(idProducto: e.id));
                                    // showDialog<String>(
                                    //     context: context,
                                    //     builder: (context) => PopAppSolicitudes(
                                    //         titulo: (state.producto.id.isNotEmpty)
                                    //             ? 'Ficha Categoria'
                                    //             : 'Alta Categoria', //state.chatbot.nombre
                                    //         altoPorc: ResponsiveWrapperUtilsContext.determinarTamano(context,
                                    //             desktop: 25, tablet: 30, mobile: 30, phone: 35),
                                    //         isBotonSalir: true,
                                    //         // ancho: 1000,
                                    //         paddingContenido: const EdgeInsets.symmetric(horizontal: 10),
                                    //         paddingTitulo: const EdgeInsets.only(top: 0),
                                    //         child: _ProductoModal()));

                                  },
                                ),
                              ]))
                          .toList(),
                    ]
                    //quede en el modal
                    )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProductoModal extends StatefulWidget {
  @override
  State<_ProductoModal> createState() => _ProductoModalState();
}

class _ProductoModalState extends State<_ProductoModal> {
  late ProductoModel producto;

  @override
  void initState() {
    producto = context.read<ProductoBloc>().state.producto;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final bool isPhone = (ResponsiveWrapper.of(context).isPhone) ? true : false;

    return Container(
      // padding: const EdgeInsets.only(top: 0),
      margin: EdgeInsets.symmetric(
          horizontal: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 10, tablet: 5, mobile: 10, phone: 5)),
      width: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 380, tablet: 465, mobile: 465, phone: 465),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Column(children: [
            ...producto.toJson().entries.map(
                  (item) => ItemFormulario(
                    titulo: item.key, // esto me sirve para poder detectar que campo es en el mapa util
                    valor: item.key.contains('id') ? producto.id : producto.descripcion,
                    onChanged: (value) {
                      // print(item.key);
                      // print(value);
                      producto = (item.key.contains('id'))
                       ? producto.copyWith(id: value) 
                       : producto.copyWith(data: {'descripcion': value});

                    },
                  ),
                )
          ]),
          SizedBox(height: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 20, tablet: 15, mobile: 10, phone: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonModeWidget.botonSimple(
                titulo: (producto.id.isEmpty) ? 'Guardar' : 'Atualizar',
                tamanioTexto: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 16, tablet: 14, mobile: 14, phone: 12),
                onPressed: () {
                  context.read<ProductoBloc>().add(OnValidarProducto(producto: producto));
                },
              ),
              ButtonModeWidget.botonSimple(
                // ancho: 100,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black54),
                ),
                titulo: 'Salir',
                tamanioTexto: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 16, tablet: 14, mobile: 14, phone: 12),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(height: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 20, tablet: 0, mobile: 5, phone: 5))
        ],
      ),
    );
  }
}
