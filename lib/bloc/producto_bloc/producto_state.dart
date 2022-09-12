part of 'producto_bloc.dart';

class ProductoState extends Equatable {
  final bool isWorking;
  final String error;
  final String campoError;
  final String accion;
  final ProductoModel producto;
  final List<ProductoModel> listaProductos;

  ProductoState({

    this.isWorking = false,
    this.error = '',
    this.campoError = '',
    this.accion = '', 
    List<ProductoModel>? listaProductos,
    ProductoModel? producto,}) : producto = producto ?? ProductoModel(), listaProductos = listaProductos ?? []; 

  ProductoState copyWith(
          { //segun el modelo nuevo no va mas data el mapa
          bool? isWorking,
          String? error,
          String? campoError,
          String? msjStatus,
          String? accion,
          ProductoModel? producto,
          List<ProductoModel>? listaProductos,
          Map<String, dynamic>? data}) =>
      ProductoState(
        isWorking: isWorking ?? this.isWorking,
        error: error ?? this.error,
        campoError: campoError ?? this.campoError,
        accion: accion ?? this.accion,
        producto: producto ?? this.producto,
        listaProductos: listaProductos ?? this.listaProductos
      );

  @override
  List<Object> get props => [isWorking, error, campoError, accion, producto, listaProductos];
}
