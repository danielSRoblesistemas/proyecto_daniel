import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_daniel/bloc/producto_bloc/producto_bloc.dart';
import 'package:proyecto_daniel/views/home_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => ProductoBloc()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ResponsiveWrapper.builder(
                child,
                maxWidth: 1200,
                minWidth: 480,
                defaultScale: true,
                breakpoints: const [
                  ResponsiveBreakpoint.autoScale(260, name: PHONE),
                  ResponsiveBreakpoint.autoScale(500, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(780, name: TABLET),
                  ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
                ],
              ),
        home: const HomeView()            
      ),
    );
  }
}