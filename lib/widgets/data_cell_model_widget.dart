import 'package:proyecto_daniel/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_daniel/widgets/text_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DataCellModelWidget extends DataCell {
  const DataCellModelWidget({
    required Widget child,
    this.anchoCampo,
    this.padding,
    this.ontap,
  }) : super(child);

  final double? anchoCampo;
  final EdgeInsets? padding;
  final Function()? ontap;

  factory DataCellModelWidget.modelo({
    Widget? child,
    String? valor,
    double? anchoCampo,
    EdgeInsets? padding,
    Function()? ontap,
  }) = _ChildModelWidget;
}

class _ChildModelWidget extends DataCellModelWidget {
  _ChildModelWidget({
    Widget? child,
    String? valor,
    double? anchoCampo,
    EdgeInsets? padding,
    Function()? ontap,
  }) : super(child: child ?? _Child(valor: valor, anchoCampo: anchoCampo, ontap: ontap, padding: padding));
}

class _Child extends StatelessWidget {
  const _Child({
    Key? key,
    this.valor,
    this.anchoCampo,
    this.padding,
    this.ontap,
  }) : super(key: key);
  final String? valor;
  final double? anchoCampo;
  final EdgeInsets? padding;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: ontap,
      child: Container(
        constraints: BoxConstraints(maxWidth: context.ancho * 100, minWidth: 0, maxHeight: 70, minHeight: 0),
        width: anchoCampo ?? context.ancho * 100,
        alignment: Alignment.centerLeft,
        height: 40,
        padding: padding,
        child: TextModelWidget.titulo(
          texto: valor ?? '',
          tamanioTexto: (ResponsiveWrapper.of(context).isLargerThan(TABLET))
              ? 13
              : ResponsiveWrapper.of(context).isPhone
                  ? 11
                  : 12,
          tipoFuente: FontWeight.w500,
        ),
      ),
    );
  }
}
