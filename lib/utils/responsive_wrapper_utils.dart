import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension ResponsiveWrapperUtils on BuildContext {
  double determinarTamano({
    required double desktop,
    double? tablet,
    double? mobile,
    double? phone,
  }) {
    if (ResponsiveWrapper.of(this).isPhone) {
      return phone ?? desktop;
    }
    if (ResponsiveWrapper.of(this).isMobile) {
      return mobile ?? desktop;
    }
    if (ResponsiveWrapper.of(this).isTablet) {
      return tablet ?? desktop;
    }
    return desktop;
  }

  bool mostrarCuando({
    bool? desktop,
    bool? tablet,
    bool? mobile,
    bool? phone,
  }) {
    bool defecto = false;
    if (ResponsiveWrapper.of(this).isPhone) {
      return phone ?? defecto;
    }
    if (ResponsiveWrapper.of(this).isMobile) {
      return mobile ?? defecto;
    }
    if (ResponsiveWrapper.of(this).isTablet) {
      return tablet ?? defecto;
    }
    if (ResponsiveWrapper.of(this).isDesktop) {
      return desktop ?? defecto;
    }

    return defecto;
  }

  double tamanoParaDispositivo({
    required double desktop,
      double? tablet,     
      double? mobile, 
      double? phone, 
  }){
    double defecto = desktop;
    if (ResponsiveWrapper.of(this).isPhone) {
      return phone ?? mobile ?? tablet ?? desktop;
    }
    if (ResponsiveWrapper.of(this).isMobile) {
      return mobile ?? tablet ?? desktop;
    }
    if (ResponsiveWrapper.of(this).isTablet) {
      return tablet ?? desktop;
    }
    if (ResponsiveWrapper.of(this).isDesktop) {
      return desktop;
    }

    return defecto;
  }


}
