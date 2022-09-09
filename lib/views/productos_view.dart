import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:proyecto_daniel/bloc/producto_bloc/producto_bloc.dart';
import 'package:proyecto_daniel/global/colores.dart';
import 'package:proyecto_daniel/global/environment.dart';
import 'package:proyecto_daniel/utils/size.dart';
import 'package:proyecto_daniel/utils/responsive_wrapper_utils.dart';
import 'package:proyecto_daniel/views/ficha_producto_view.dart';
import 'package:proyecto_daniel/widgets/data_cell_model_widget.dart';

import 'package:proyecto_daniel/widgets/text_widget.dart';


class VistaPrimeraView extends StatelessWidget {
  const VistaPrimeraView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductoBloc, ProductoState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
        if (state.error.isEmpty) {
          if (state.accion == Environment.blocOnNuevoProducto ||state.accion == Environment.blocOnModificarProducto){
             Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FichaProductoView()));
             //esta navegacion no va a funcar esta solo de referencia
          } 

        }

      },
      builder: (context, state) {
        return Container(
          height: double.infinity,
          padding: const EdgeInsets.only(top: 20, ),
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
                                 Expanded(child: const SizedBox(height: 30)),
                           const Icon(Icons.add,
                                color: Colors.orange,
                                size: 20),
                            TextModelWidget.titulo(
                                texto: 'Nuevo Producto',
                                tamanioTexto: 15,
                                colorTexto: Colors.orange),
                           const SizedBox(width: 30)
                          ],
                        ),),


                   DataTable(
                        horizontalMargin: 0,
                        columnSpacing: 0,
                        headingRowHeight: 25,
                        dataRowHeight: 30,
                        headingRowColor: MaterialStateProperty.all<Color>( Colores.grisFondo),
                    columns:[
                           DataColumn(
                            label: Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                alignment: Alignment.centerLeft,
                                height: 25,
                                width: context.ancho * 20,
                                child: TextModelWidget.titulo(
                                  tamanioTexto: 12,
                                  tipoFuente: FontWeight.w600,
                                  texto: 'Descripcion',
                                ),
                              ),
                            ),
                          ),
                    ],
                     rows: state.producto.obtenerListaEstatica().map(
                      (e) => DataRow(
                        cells: [
                          DataCellModelWidget.modelo(
                            anchoCampo: context.tamanoParaDispositivo(
                                    desktop: context.ancho * 35,
                                    phone: context.ancho * 50),
                                    padding: const EdgeInsets.only(left: 5),
                                    valor: e.id,
                                    ontap: () {
                                      
                                    },),
                          DataCellModelWidget.modelo(
                            anchoCampo: context.tamanoParaDispositivo(
                                    desktop: context.ancho * 35,
                                    phone: context.ancho * 50),
                                    padding: const EdgeInsets.only(left: 5),
                                    valor: e.descripcion,
                                    ontap: () {
                                      
                                    },),          
                        
                      ]
                      )
                      ) .toList(),
                     
                     
                     )
                // Container(
                //   padding: const EdgeInsets.only(top: 20),
                //   width: context.ancho * 60,
                //   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                //   child: Column(
                //     children: [
                //       Text(
                //         'Producto',
                //         style: GoogleFonts.montserratAlternates(
                //           //prompt, roboto
                //           fontSize: 25,
                //           color: Colors.black54,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       Text('aca va ir mi tabla de producto recorrida por el toJson del modelo producto'),
                //       // FloatingActionButton(onPressed: (() {   
                //       // }))
                //       // const _ProductoVista()
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}


