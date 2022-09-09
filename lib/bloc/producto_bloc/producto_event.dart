part of 'producto_bloc.dart';

abstract class ProductoEvent extends Equatable {
  const ProductoEvent();

  @override
  List<Object> get props => [];
}

class OnNuevoProducto extends ProductoEvent {
  const OnNuevoProducto();
}

class OnModificarProducto extends ProductoEvent {
  final String idProducto;
  const OnModificarProducto({required this.idProducto});
}

class OnValidarProducto extends ProductoEvent {
  final ProductoModel producto;
  final int pagina;
  const OnValidarProducto(
      {required this.producto, required this.pagina});
}

class OnActualizaProducto extends ProductoEvent {
  final Map<String, dynamic> data;
  const OnActualizaProducto({required this.data});
}

class OnObtenerlstProducto extends ProductoEvent {
  const OnObtenerlstProducto();
}






