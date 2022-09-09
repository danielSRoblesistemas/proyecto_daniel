import 'package:flutter/cupertino.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveWrapperUtilsContext {
  static double determinarTamano(
    BuildContext context, {
    required double desktop,
    double? tablet,
    double? mobile,
    double? phone,
  }) {
    if (ResponsiveWrapper.of(context).isPhone) {
      return phone ?? desktop;
    }
    if (ResponsiveWrapper.of(context).isMobile) {
      return mobile ?? desktop;
    }
    if (ResponsiveWrapper.of(context).isTablet) {
      return tablet ?? desktop;
    }

    return desktop;
  }

  static bool mostrarCuando(
    BuildContext context, {
    bool? desktop,
    bool? tablet,
    bool? mobile,
    bool? phone,
  }) {
    bool defecto = false;
    if (ResponsiveWrapper.of(context).isPhone) {
      return phone ?? defecto;
    }
    if (ResponsiveWrapper.of(context).isMobile) {
      return mobile ?? defecto;
    }
    if (ResponsiveWrapper.of(context).isTablet) {
      return tablet ?? defecto;
    }
    if (ResponsiveWrapper.of(context).isDesktop) {
      return desktop ?? defecto;
    }

    return defecto;
  }

  // static double tamanoParaDispositivo({
  //   required double desktop,
  //   double? tablet,
  //   double? mobile,
  //   double? phone,
  // }) {
  //   double defecto = desktop;
  //   BuildContext context = NavigationService.navigatorKey.currentContext!;
  //   if (ResponsiveWrapper.of(context).isPhone) {
  //     return phone ?? mobile ?? tablet ?? desktop;
  //   }
  //   if (ResponsiveWrapper.of(context).isMobile) {
  //     return mobile ?? tablet ?? desktop;
  //   }
  //   if (ResponsiveWrapper.of(context).isTablet) {
  //     return tablet ?? desktop;
  //   }
  //   if (ResponsiveWrapper.of(context).isDesktop) {
  //     return desktop;
  //   }

  //   return defecto;
  // }
}