import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../utils/responsive_con_context.dart';

import 'package:proyecto_daniel/bloc/notificaciones/notificaciones_bloc.dart';
import 'package:proyecto_daniel/bloc/producto_bloc/producto_bloc.dart';

import 'package:proyecto_daniel/global/colores.dart';
import 'package:proyecto_daniel/global/environment.dart';
import 'package:proyecto_daniel/model/notificacion.dart';
import 'package:proyecto_daniel/model/producto_model.dart';
import 'package:proyecto_daniel/utils/size.dart';
import 'package:proyecto_daniel/utils/responsive_wrapper_utils.dart';
import 'package:proyecto_daniel/widgets/button_widget.dart';
import 'package:proyecto_daniel/widgets/data_cell_model_widget.dart';
import 'package:proyecto_daniel/widgets/item_formulario.dart';
import 'package:proyecto_daniel/widgets/popaap_ficha.dart';
import 'package:proyecto_daniel/widgets/text_widget.dart';

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
              barrierDismissible: true,
                context: context,
                barrierColor: Colors.transparent,
                builder: (context) => Stack(
                  children: [
                    Positioned(
                      top: context.alto * 40,
                      left: context.ancho * 37,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: PopAppSolicitudes(
                            titulo: (state.producto.id.isNotEmpty) ? 'Ficha Producto' : 'Alta Producto', //state.chatbot.nombre
                            altoPorc: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 40, tablet: 40, mobile: 50, phone: 40),
                            isBotonSalir: true,
                            // ancho: 1000,
                            paddingContenido: const EdgeInsets.symmetric(horizontal: 10),
                            paddingTitulo: const EdgeInsets.only(top: 0),
                            child: _ProductoModal()),
                      ),
                    ),
                  ],
                ));
            // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FichaProductoView()));
            //esta navegacion no va a funcar esta solo de referencia
          }
          if (state.accion == Environment.blocOnValidaProducto) {
            context.read<ProductoBloc>().add(const OnGuardarProducto());

            Navigator.pop(context);
          }
          if (state.accion == Environment.blocOnGuardarProducto) {
            context.read<NotificacionesBloc>().add(OnNuevaNotificacionEvent(
                  const Notificacion(
                    descripcion: 'Producto guardado con exito',
                    tipoNotificacion: TipoNotificacion.confirmacion,
                    titulo: 'Éxito',
                  ),
                ));
          }
        } else {
          context.read<NotificacionesBloc>().add(OnNuevaNotificacionEvent(
                Notificacion(
                  descripcion: state.error,
                  tipoNotificacion: TipoNotificacion.error,
                  titulo: 'Error',
                ),
              ));
        }
      },
      builder: (context, state) {
        final bool isPhone = (ResponsiveWrapper.of(context).isPhone) ? true : false;
        final bool isMobile = (ResponsiveWrapper.of(context).isMobile) ? true : false;
        return Container(
          height: double.infinity,
          width: ResponsiveWrapperUtilsContext.determinarTamano(context,
              desktop: context.ancho * 50,
              tablet: context.ancho * 50,
              mobile: context.ancho * 60,
              phone: context.ancho * 99), //context.ancho * 50,
          padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
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
                SizedBox(height: context.alto * 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                          // String n = 'a';
                          // print(int.tryParse(n)); 

                        context.read<ProductoBloc>().add(const OnNuevoProducto());
                      },
                      child: Row(
                        children: [
                          SizedBox(width: context.ancho * 1),
                          const Icon(Icons.add, color: Colors.green, size: 20),
                          TextModelWidget.titulo(texto: 'Nuevo Producto', tamanioTexto: 15, colorTexto: Colors.green),
                        ],
                      ),
                    ),
                    SizedBox(width: context.ancho * 3),
                    const Expanded(
                        child: SizedBox(
                      height: 40,
                    )),
                    if (!isPhone && !isMobile)
                      InkWell(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.list_rounded,
                              color: Colors.orange,
                              size: 15,
                            ),
                            TextModelWidget.titulo(
                              texto: 'Ordenar',
                              tamanioTexto: 13,
                              colorTexto: Colors.orange,
                              tipoFuente: FontWeight.bold,
                            ),
                          ],
                        ), // refresh.
                       
                        onTap: () => context.read<ProductoBloc>().add(const OnOrdenarProductos())
                      ),
                    SizedBox(width: context.ancho * 5)
                  ],
                ),
                if (isPhone || isMobile)
                  InkWell(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.list_rounded,
                            color: Colors.orange,
                            size: 15,
                          ),
                          TextModelWidget.titulo(
                            texto: 'Ordenar',
                            tamanioTexto: 13,
                            colorTexto: Colors.orange,
                            tipoFuente: FontWeight.bold,
                          ),
                        ],
                      ), // refresh
                      onTap: () => context.read<ProductoBloc>().add(const OnOrdenarProductos())),
                const Divider(color: Colors.grey),
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
                            // padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            // padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            height: 25,
                            width: context.ancho * 18,
                            child: TextModelWidget.titulo(
                              tamanioTexto: 12,
                              tipoFuente: FontWeight.w600,
                              texto: 'Descripcion', //state.listaProductos.length.toString()
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            alignment: Alignment.centerLeft,
                            height: 20,
                            width: context.ancho * 20,
                            child: TextModelWidget.titulo(
                              tamanioTexto: 12,
                              tipoFuente: FontWeight.w600,
                              texto: 'Eliminar', //state.listaProductos.length.toString()
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      ...state.listaProductos
                          .map((e) => DataRow(cells: [
                                DataCellModelWidget.modelo(
                                  anchoCampo: context.tamanoParaDispositivo(desktop: context.ancho * 20, phone: context.ancho * 10),
                                  padding: const EdgeInsets.only(left: 30),
                                  valor: e.id,
                                  ontap: () {
                                    context.read<ProductoBloc>().add(OnModificarProducto(idProducto: e.id));
                                  },
                                ),
                                DataCellModelWidget.modelo(
                                  anchoCampo: context.tamanoParaDispositivo(desktop: context.ancho * 20, phone: context.ancho * 10),
                                  padding: const EdgeInsets.only(left: 15),
                                  valor: e.descripcion,
                                  ontap: () {
                                    // context.read<ProductoBloc>().add(const OnNuevoProducto());
                                    context.read<ProductoBloc>().add(OnModificarProducto(idProducto: e.id));
                                  },
                                ),
                                DataCellModelWidget.modelo(
                                  anchoCampo: context.tamanoParaDispositivo(desktop: context.ancho * 22, phone: context.ancho * 10),
                                  padding: const EdgeInsets.only(left: 35, right: 5),
                                  // valor: e.descripcion,
                                  child: IconButton(
                                      onPressed: () {
                                        showDialog<String>(
                                            context: context,
                                            builder: (context) => PopAppSolicitudes(
                                                titulo: 'Seguro desea eliminar?', //state.chatbot.nombre
                                                altoPorc: ResponsiveWrapperUtilsContext.determinarTamano(context,
                                                    desktop: 40, tablet: 20, mobile: 30, phone: 35),
                                                isBotonSalir: true,
                                                // ancho: 1000,
                                                paddingContenido: const EdgeInsets.symmetric(horizontal: 10),
                                                paddingTitulo: const EdgeInsets.only(top: 0),
                                                child: _EliminarModal(producto: e)));
                                      },
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colores.eliminar,
                                        size: 20,
                                      )),
                                  ontap: () {},
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
      width: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 380, tablet: 350, mobile: 250, phone: 465),
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
                      producto = (item.key.contains('id')) ? producto.copyWith(id: value) : producto.copyWith(data: {'descripcion': value});
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

class _EliminarModal extends StatelessWidget {
  final ProductoModel producto;
  const _EliminarModal({required this.producto});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonModeWidget.botonSimple(
            // ancho: 100,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colores.eliminar),
            ),
            titulo: 'Eliminar',
            tamanioTexto: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 16, tablet: 14, mobile: 14, phone: 12),
            onPressed: () {
              context.read<ProductoBloc>().add(OnEliminarProducto(idProducto: producto.id));
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            width: 10,
          ),
          ButtonModeWidget.botonSimple(
            // ancho: 100,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black54),
            ),
            titulo: 'Cancelar',
            tamanioTexto: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 16, tablet: 14, mobile: 14, phone: 12),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
