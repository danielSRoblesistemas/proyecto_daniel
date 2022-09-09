import 'package:flutter/material.dart';
import 'package:proyecto_daniel/global/theme.dart';

class TextModelWidget extends StatelessWidget {
  final String texto;
  final double? tamanioTexto;
  final Color? colorTexto;
  final TextStyle estilo;
  final int? maxlineas;
  final TextOverflow? overflow;
  final TextAlign? alineacion;
  final FontWeight? tipoFuente;

  const TextModelWidget({
    super.key,
    required this.texto,
    this.tamanioTexto,
    this.colorTexto,
    required this.estilo,
    this.maxlineas,
    this.overflow = TextOverflow.ellipsis,
    this.alineacion,
    this.tipoFuente,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      maxLines: maxlineas,
      overflow: overflow,
      textAlign: alineacion,
      style: estilo.copyWith(color: colorTexto, fontSize: tamanioTexto, fontWeight: tipoFuente),
    );
  }

  factory TextModelWidget.titulo(
      {double tamanioTexto,
      required String texto,
      Color colorTexto,
      FontWeight tipoFuente,
      TextStyle? estilo,
      int? maxlineas}) = _TextTituloModelWidget;
}

class _TextTituloModelWidget extends TextModelWidget {
  _TextTituloModelWidget({
    required super.texto,
    super.tamanioTexto = 15,
    super.maxlineas,
    super.colorTexto = Colors.black87,
    super.tipoFuente = FontWeight.w500,
    TextStyle? estilo,
  }) : super(estilo: estilo 
  ??
      fuentePrincipal.copyWith(
        color: colorTexto,
        fontSize: tamanioTexto,
        fontWeight: tipoFuente,
      ));

}
