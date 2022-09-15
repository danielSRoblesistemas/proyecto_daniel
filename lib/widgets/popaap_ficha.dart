import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:proyecto_daniel/utils/size.dart';
import 'package:proyecto_daniel/widgets/text_widget.dart';


class PopAppSolicitudes extends StatelessWidget {
  final Widget child;
  final double? altoPorc;
  final double? ancho;
  final String? titulo;
  final EdgeInsets? paddingTitulo;
  final EdgeInsets? paddingContenido;
  final bool? isBotonSalir;
  const PopAppSolicitudes({
    Key? key,
    required this.child,
    this.altoPorc = 60,
    this.ancho,
    this.titulo = '',
    this.paddingTitulo,
    this.paddingContenido, 
    this.isBotonSalir = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return AlertDialog(

          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          actionsPadding: EdgeInsets.zero,
          titlePadding: paddingTitulo ?? const EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 5),
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: Colors.teal[50],
          scrollable: true,
          title: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: TextModelWidget.titulo(
                  colorTexto: const Color(0xff757575),
                  texto: titulo!,
                  tamanioTexto: ResponsiveWrapper.of(context).isPhone ? 12 : 18,
                  tipoFuente: FontWeight.w600,
                ),
              ),
              if (isBotonSalir!)
                Positioned(
                  top: 5,
                  right: 5,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.close,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          contentPadding: paddingContenido ?? const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          content: Container(
            constraints: BoxConstraints(
              maxHeight: context.alto * altoPorc!,
              maxWidth: ancho ?? 900//ResponsiveWrapperUtils.tamanoParaDispo(desktop: 900, tablet: 800, mobile: 1000, phone: 1000),
            ),
            child: child,
          ),
        );
  }
}
