import 'package:flutter/material.dart';
import 'package:proyecto_daniel/utils/size.dart';
import 'package:proyecto_daniel/widgets/text_widget.dart';
import 'package:proyecto_daniel/utils/responsive_wrapper_utils.dart';


class ButtonModeWidget extends StatelessWidget {
  const ButtonModeWidget({Key? key, required this.child, this.onPressed, required this.padding, required this.style}) : super(key: key);

  final Widget child;
  final Function()? onPressed;
  final EdgeInsets? padding;
  final ButtonStyle style;

  factory ButtonModeWidget.botonSimple(
      {Key key,
      required String titulo,
      EdgeInsets? padding,
      required Function() onPressed,
      double? tamanioTexto,
      ButtonStyle? style}) = _CustomButtonSimple;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      constraints: BoxConstraints(
        maxHeight: context.alto * 100,
        maxWidth: context.ancho * 100,
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
  }) : super(
            child: _CustomChildButtonSimple(titulo: titulo, tamanioTexto: tamanioTexto),
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            style: style ?? const ButtonStyle());
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
      tamanioTexto:
          tamanioTexto ?? context.determinarTamano(desktop: 13, phone: 10),
      texto: titulo,
    );
  }
}
