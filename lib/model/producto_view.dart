

class Producto {

  final String id;
  final String descripcion;

  Producto({
    this.id = '', 
    this.descripcion= ''
    });

  Producto copyWith({ 
    String? id,
    String? descripcion,
    Map<String, dynamic>? data,
  }) => Producto( 
      id: id ?? this.id,
      descripcion: data?["descripcion"] ?? descripcion,
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
      };


}