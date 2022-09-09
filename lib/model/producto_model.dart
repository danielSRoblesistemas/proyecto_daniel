class ProductoModel {
  final String id;
  final String descripcion;

  ProductoModel({this.id = '', this.descripcion = ''});

  ProductoModel copyWith({
    String? id,
    String? descripcion,
    Map<String, dynamic>? data,
  }) =>
      ProductoModel(
        id: id ?? this.id,
        descripcion: data?["descripcion"] ?? descripcion,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
      };

  List<Object?> get props => [
        id,
        descripcion,
      ];

  List<ProductoModel> obtenerListaEstatica() {
    List<ProductoModel> listaProducto = [];
    ProductoModel producto1 = ProductoModel(id: '1', descripcion: 'Pc');
    ProductoModel producto2 = ProductoModel(id: '2', descripcion: 'Monitor');
    ProductoModel producto3 = ProductoModel(id: '3', descripcion: 'Teclado/mouse');
    listaProducto.add(producto1);
    listaProducto.add(producto2);
    listaProducto.add(producto3);
    
    return listaProducto;
  }

  static Map<String, String> tituloFormulario = {
    'id':'Id Producto',
    'descripcion': 'Nombre de Categoria',
    };
}
