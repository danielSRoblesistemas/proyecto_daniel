import 'package:flutter/material.dart';
import 'package:proyecto_daniel/views/login.dart';

import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proyecto_daniel/bloc/notificaciones/notificaciones_bloc.dart';
import 'package:proyecto_daniel/bloc/producto_bloc/producto_bloc.dart';

import 'package:proyecto_daniel/views/home_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => ProductoBloc())),
        BlocProvider(create: ((context) => NotificacionesBloc()))
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
                  ResponsiveBreakpoint.autoScale(480, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(780, name: TABLET),
                  ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
                ],
              ),
        // home: const LoginPage(), //HomeView(),  LoginPage()        
        initialRoute: '/login',
        routes: {
          '/login':(context) => const LoginPage(),
          '/home':(context) => const HomeView()
        },
        theme: ThemeData(
          primarySwatch: Colors.orange
        )
      ),
    );
  }
}