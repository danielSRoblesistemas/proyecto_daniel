import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:proyecto_daniel/utils/responsive_wrapper_utils.dart';

class TextfieldModelWidget extends StatelessWidget {
  const TextfieldModelWidget(
      {super.key,
      required this.controller,
      required this.labelTitulo,
      required this.obscureText,
      required this.decoration,
      this.maxWidth,
      this.onChanged,
      this.margin,
      this.msjError,
      required this.desactivarCampo,
      this.onSubmitted,
      this.textInputAction,
      this.hintText});
  final TextEditingController? controller;
  final String labelTitulo;
  final String? hintText;
  final bool obscureText;
  final InputDecoration decoration;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final EdgeInsets? margin;
  final double? maxWidth;
  final String? msjError;
  final bool desactivarCampo;
  final TextInputAction? textInputAction;
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: desactivarCampo,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? MediaQuery.of(context).size.width,
        ),
        margin: margin,                           
        height: ResponsiveWrapperUtils(context).mostrarCuando(phone: true) ? 30 : 37,
        color: desactivarCampo ? Colors.grey[400] : Colors.transparent,
        child: TextFormField(
            textInputAction: textInputAction,
            autofocus: false,
            controller: controller,
            obscureText: obscureText,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: desactivarCampo ? Colors.white : null, fontSize: context.determinarTamano(desktop: 15, phone: 9)),
            textCapitalization: TextCapitalization.sentences,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            decoration: decoration.copyWith(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(3), borderSide: BorderSide(width: desactivarCampo ? 0 : 0.1)),
                contentPadding: EdgeInsets.only(left: context.determinarTamano(desktop: 10, phone: 5), bottom: 15),
                //label: TextModelWidget.texto(texto: labelTitulo),
                labelText: labelTitulo,
                hintText: hintText)),
      ),
    );
  }

factory TextfieldModelWidget.contrasena(
      {Key key,
      required Function() ontap,
      TextEditingController? controller,
      required String labelTitulo,
      bool obscureText,
      Function(String)? onChanged,
      EdgeInsets? margin,
      InputDecoration decoration,
      double? maxWidth,
      String? msjError,
      bool? desactivarCampo,
      Function(String)? onSubmitted,
      TextInputAction? textInputAction,
      String? hintText}) = _TextfieldContrasenaModelWidget;

factory TextfieldModelWidget.estandar(
      {Key key,
      TextEditingController? controller,
      required String labelTitulo,
      bool obscureText,
      Function(String)? onChanged,
      Function(String)? onSubmitted,
      EdgeInsets? margin,
      String? tooltipMessage,
      IconData? suffixIcon,
      InputDecoration decoration,
      double? maxWidth,
      bool? desactivarCampo,
      TextInputAction? textInputAction,
      String? msjError,
      String? hintText}) = _TextfieldEstandarModelWidget;
}

class _TextfieldContrasenaModelWidget extends TextfieldModelWidget {
  final Function() ontap;
  _TextfieldContrasenaModelWidget(
      {super.key,
      required this.ontap,
      super.controller,
      required super.labelTitulo,
      super.onChanged,
      super.onSubmitted,
      super.obscureText = true,
      InputDecoration? decoration,
      super.maxWidth,
      EdgeInsets? margin,
      String? msjError,
      bool? desactivarCampo,
      String? hintText,
      TextInputAction? textInputAction = TextInputAction.next})
      : super(
            decoration: decoration ??
                InputDecoration(
                    errorText: msjError,
                    suffixIcon: GestureDetector(
                        onTap: ontap,
                        child: (obscureText)
                            ? const Icon(
                                FontAwesomeIcons.eye,
                                size: 14,
                              )
                            : const Icon(
                                FontAwesomeIcons.eyeSlash,
                                size: 14,
                              ))),
            margin: margin,
            textInputAction: textInputAction,
            desactivarCampo: desactivarCampo ?? false,
            hintText: hintText);
}

class _TextfieldEstandarModelWidget extends TextfieldModelWidget {
  _TextfieldEstandarModelWidget(
      {super.key,
      super.controller,
      required super.labelTitulo,
      super.onChanged,
      super.obscureText = false,
      InputDecoration? decoration,
      String? tooltipMessage,
      IconData? suffixIcon = Icons.lightbulb_outline,
      EdgeInsets? margin,
      super.maxWidth,
      String? msjError,
      bool? desactivarCampo,
      super.onSubmitted,
      TextInputAction? textInputAction = TextInputAction.next,
      String? hintText})
      : super(
            decoration: decoration ??
                InputDecoration(
                  errorText: msjError,
                  suffixIcon: Visibility(
                    visible:
                        tooltipMessage != null && tooltipMessage.isNotEmpty,
                    child: Tooltip(
                        message: tooltipMessage ?? '',
                        child: Icon(
                          suffixIcon,
                          size: 14,
                        )),
                  ),
                ),
            margin: margin,
            textInputAction: textInputAction,
            desactivarCampo: desactivarCampo ?? false,
            hintText: hintText);
}