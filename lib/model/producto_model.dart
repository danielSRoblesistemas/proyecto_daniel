import 'package:equatable/equatable.dart';

class ProductoModel extends Equatable{
  final String id;
  final String descripcion;

 const ProductoModel({this.id = '', this.descripcion = ''});

  ProductoModel copyWith({
    String? id,
    Map<String, dynamic>? data,
  }) =>
      ProductoModel(
        id:id ?? this.id,//data?["id"] ?? id,// id ?? this.id,
        descripcion: data?["descripcion"] ?? descripcion,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
      };


  @override
  List<Object?> get props => [
        id,
        descripcion,
      ];

  List<ProductoModel> obtenerListaEstatica() {
    List<ProductoModel> listaProducto = [];
    ProductoModel producto1 = const ProductoModel(id: '1', descripcion: 'Pc');
    ProductoModel producto2 = const ProductoModel(id: '2', descripcion: 'Monitor');
    ProductoModel producto3 = const ProductoModel(id: '3', descripcion: 'Teclado/mouse');
    listaProducto.add(producto1);
    listaProducto.add(producto2);
    listaProducto.add(producto3);
    
    return listaProducto;
  }

  static Map<String, String> tituloFormulario = {
    'id':'Id Producto',
    'descripcion': 'Nombre de Producto',
    };
}
