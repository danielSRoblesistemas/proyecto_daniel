
import 'package:flutter/material.dart';
import 'package:proyecto_daniel/model/producto_model.dart';
import 'package:proyecto_daniel/utils/responsive_con_context.dart';

import 'package:proyecto_daniel/widgets/textfield_widget.dart';

class ItemFormulario extends StatelessWidget { // ocupado en categorias view
  const ItemFormulario({
    Key? key,
    required this.titulo,
    required this.valor,
    required this.onChanged,
    this.nombreCampo = ''
  }) : super(key: key);
  final String? nombreCampo;
  final String titulo; 
  final String valor;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        if (titulo ==  ProductoModel.tituloFormulario.keys.elementAt(0)) 
          ...[ // desestructuro para poder agregar mas de un widget al if
              const SizedBox(width: 10),  
              TextfieldModelWidget.estandar(
                controller: TextEditingController(text: valor),
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 16, tablet: 12, mobile: 12, phone: 14))
                ) ,
                maxWidth: ResponsiveWrapperUtilsContext.determinarTamano(context, desktop: 360, tablet: 440, mobile: 360, phone: 190),
                labelTitulo: ProductoModel.tituloFormulario[titulo]!, // Nombre
                onChanged: (value) {
                  ///Se pasa al padre lo que se haya modificado
                  onChanged.call(value);
                },
            )
          ]
      ],
    );
  }
}