import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xff121111),
  secondaryHeaderColor: const Color(0xff2D2D2D),
  primaryColor: const Color(0xff2D2D2D),
  colorScheme: const ColorScheme.dark().copyWith(
      secondary: const Color(0xff4285F4), primary: const Color(0xff4285F4)),
  focusColor: const Color(0xffE1E1E1),
  iconTheme: const IconThemeData(color: Color(0xff4285F4)),
  textTheme: TextTheme(
      headline6: estiloTitulo2Dark,
      headline5: estiloSubTituloDark,
      headline4: estiloTitulo1Dark),
);

final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffF1F2F7),
    secondaryHeaderColor: Colors.white,
    primaryColor: const Color(0xff3367D6),
    colorScheme: const ColorScheme.light().copyWith(
        secondary: const Color(0xff3367D6), primary: const Color(0xff3367D6)),
    iconTheme: const IconThemeData(color: Color(0xff10B285)),
    textTheme: TextTheme(
        headline6: estiloTitulo2Ligth,
        headline5: estiloSubTituloLigth,
        headline4: estiloTitulo1Ligth));

final estiloTitulo1Dark = fuentePrincipal.copyWith(color: Colors.white);
final estiloTitulo2Dark =
    fuentePrincipal.copyWith(color: const Color(0xff3367D6), fontSize: 12);
final estiloSubTituloDark = GoogleFonts.roboto()
    .copyWith(color: const Color(0xffE1E1E1).withOpacity(0.5));

final estiloTitulo1Ligth = fuentePrincipal.copyWith(color: Colors.black87);
final estiloTitulo2Ligth = fuentePrincipal.copyWith(
    color: const Color(0xff4285F4).withOpacity(0.7), fontSize: 12);
final estiloSubTituloLigth =
    fuentePrincipal.copyWith(color: Colors.black.withOpacity(0.35));
final TextStyle fuentePrincipal = GoogleFonts.workSans();
