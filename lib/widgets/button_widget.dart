import 'package:flutter/material.dart';

import 'package:proyecto_daniel/utils/size.dart';
import 'package:proyecto_daniel/widgets/text_widget.dart';
import 'package:proyecto_daniel/utils/responsive_wrapper_utils.dart';

class ButtonModeWidget extends StatelessWidget {
  const ButtonModeWidget({
    Key? key,
    required this.child,
    this.onPressed,
    required this.padding,
    required this.style,
    required this.width ,
    required this.height,
  }) : super(key: key);

  final Widget child;
  final Function()? onPressed;
  final EdgeInsets? padding;
  final ButtonStyle style;
  final double? width;
  final double? height;

  factory ButtonModeWidget.botonSimple(
      {Key key,
      required String titulo,
      EdgeInsets? padding,
      required Function() onPressed,
      double? tamanioTexto,
      double? width,
      double? height,
      ButtonStyle? style}) = _CustomButtonSimple;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width, //?? 100, //aca quede 400
      height: height, //?? 30,
      constraints: BoxConstraints(
        maxHeight: context.alto * 500,
        maxWidth: context.ancho * 500,
      ),
      child: ElevatedButton(onPressed: onPressed, style: style, child: child),
    );
  }
}

class _CustomButtonSimple extends ButtonModeWidget {
  _CustomButtonSimple({
    super.key,
    required String titulo,
    super.onPressed,
    EdgeInsets? padding,
    ButtonStyle? style,
    double? tamanioTexto,
    double? width,
    double? height,
  }) : super(
            child: _CustomChildButtonSimple(titulo: titulo, tamanioTexto: tamanioTexto),
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            width:  width ?? 120,
            height: height ?? 30,
            style: style ??  ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
              overlayColor: MaterialStateProperty.all<Color>(Color.fromARGB(208, 255, 153, 0)),
              shadowColor: MaterialStateProperty.all<Color>(Colors.white),

            ));
}

class _CustomChildButtonSimple extends StatelessWidget {
  const _CustomChildButtonSimple({Key? key, required this.titulo, this.tamanioTexto}) : super(key: key);
  final String titulo;
  final double? tamanioTexto;
  @override
  Widget build(BuildContext context) {
    return
        // TextModelWidget(texto: '34', estilo: TextStyle()); // esto no va, va el de abajo
        TextModelWidget.titulo(
      colorTexto: Colors.white,
      tipoFuente: FontWeight.w600,
      tamanioTexto: tamanioTexto ?? context.determinarTamano(desktop: 13, phone: 10),
      texto: titulo,
    );
  }
}
