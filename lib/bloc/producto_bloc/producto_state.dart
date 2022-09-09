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


  @override
  List<Object> get props => [isWorking, error, campoError, accion, producto];
}
