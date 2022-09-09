part of 'producto_bloc.dart';

class ProductoState extends Equatable {
  final bool isWorking;
  final String error;
  final String campoError;
  final String accion;
  final ProductoModel producto;

  ProductoState({
    this.isWorking = false,
    this.error = '',
    this.campoError = '',
    this.accion = '',
    ProductoModel? producto,
  }) : producto = producto ?? ProductoModel();

  ProductoState copyWith({ 
          bool? isWorking,
          String? error,
          String? campoError,
          String? msjStatus,
          String? accion,
          ProductoModel? producto,
          List<ProductoModel>? listaProducto,
          Map<String, dynamic>? data
  })=> ProductoState( 
      isWorking: isWorking ?? this.isWorking,
      error: error ?? this.error,
      campoError: campoError ?? this.campoError,
      accion: accion ?? this.accion,
      producto: producto ?? this.producto,
    );

  


  @override
  List<Object> get props => [isWorking, error, campoError, accion, producto];
}
