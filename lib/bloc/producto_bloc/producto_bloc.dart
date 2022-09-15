import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:proyecto_daniel/global/environment.dart';
import 'package:proyecto_daniel/model/producto_model.dart';

part 'producto_event.dart';
part 'producto_state.dart';

class ProductoBloc extends Bloc<ProductoEvent, ProductoState> {
  ProductoBloc() : super(ProductoState()) {
    on<OnNuevoProducto>(_onNuevoProducto);
    on<OnModificarProducto>(_onModificarProducto);
    on<OnValidarProducto>(_onValidarProducto);
    on<OnGuardarProducto>(_onGuardarProducto);
    on<OnOrdenarProductos>(_onOrdenarProductos);
    on<OnObtenerlstProducto>(_onObtenerlstProducto);
    on<OnEliminarProducto>(_onEliminarProducto);
  }

  Future<void> _onNuevoProducto(OnNuevoProducto event, Emitter emit) async {
    emit(
      state.copyWith(
        isWorking: true,
        producto: const ProductoModel(),
        error: '',
        accion: Environment.blocOnNuevoProducto,
      ),
    );

    emit(state.copyWith(
      isWorking: false,
      producto: const ProductoModel(),
      idProducto: '',
      error: '',
      accion: Environment.blocOnNuevoProducto,
    ));
  }

  Future<void> _onModificarProducto(OnModificarProducto event, Emitter emit) async {
    try {
      emit(state.copyWith(
        isWorking: true,
        error: '',
        campoError: '',
        accion: Environment.blocOnModificarProducto,
      ));

      String error = '';
      List<ProductoModel> listaProductosBloc = state.listaProductos;

      //funcional pero menos optima
      // ProductoModel producto = const ProductoModel();
      // state.listaProductos.forEach((element) {
      //   if (element.id.contains(event.idProducto)) {
      //     producto = element;
      //   }
      // });

      ProductoModel producto =
          listaProductosBloc.firstWhere((objeto) => objeto.id == event.idProducto); //me trae el primer valor q cumpla esa condicion
      // orElse:() => const ProductoModel()), esto no hace falta aca porque siempre me va a venir un id al tocar click
      // en un elemento de la tabla en la vista

      emit(state.copyWith(
        producto: producto,
        isWorking: false,
        idProducto: event.idProducto, // en este pundto cargi mi idProducto del state
        error: error,
        campoError: '',
        accion: Environment.blocOnModificarProducto,
      ));
    } catch (e) {
      emit(state.copyWith(
        isWorking: false,
        error: e.toString(),
        accion: Environment.blocOnModificarProducto,
      ));
    }
  }

  Future<void> _onObtenerlstProducto(OnObtenerlstProducto event, Emitter emit) async {
    try {
      emit(state.copyWith(
        isWorking: true,
        error: '',
        accion: Environment.blocOnObtenerlstProducto,
      ));

      emit(state.producto.obtenerListaEstatica());
    } catch (e) {}
  }

  Future<void> _onGuardarProducto(OnGuardarProducto event, Emitter emit) async {
    emit(state.copyWith(
      isWorking: true,
      error: '',
      accion: Environment.blocOnGuardarProducto,
    ));

    List<ProductoModel> listaProductosBloc = state.listaProductos;

    // ProductoModel producto = state.producto;
    // listaProductosBloc.removeWhere((element) => element.id == producto.id);
    // // ProductoModel producto = listaProductosBloc.firstWhere((objeto) => objeto.id ==)
    // listaProductosBloc.add(producto);

    //ACTUALIZA
    ProductoModel producto =
        listaProductosBloc.firstWhere((objeto) => objeto.id == state.idProducto, //el primer objeto q encuentre esa condicion
            orElse: () => const ProductoModel()); // sino encuenta nada, me devuelve un modelo vacio

    if (producto.id.isNotEmpty) {
      listaProductosBloc = listaProductosBloc.map((objeto) {
        // Para modificar ese elemento sin desordenal su index
        ProductoModel prod = objeto; // instancio prod
        if (objeto.id == state.idProducto) {
          prod = state.producto;
        }
        return prod;
      }).toList();
    } else {
      listaProductosBloc.add(state.producto); //CREA UNO NUEVO
    }

    emit(state.copyWith(
      listaProductos: listaProductosBloc,
      isWorking: false,
      error: '',
      accion: Environment.blocOnGuardarProducto,
    ));
    // listaProductosBloc.forEach((element) {

    // })
  }

  Future<void> _onValidarProducto(OnValidarProducto event, Emitter emit) async {
    try {
      emit(state.copyWith(
        isWorking: true,
        error: '',
        accion: Environment.blocOnValidaProducto,
      ));

      String error = '';
      ProductoModel producto = event.producto;
      List<ProductoModel> listaProductosBloc = state.listaProductos;

      if (producto.id.trim().isEmpty) {
        error = 'El id esta vacio';
      } else if (event.producto.descripcion.isEmpty) {
        error = 'La descripcion esta vacia';
      } 
      else {
        ProductoModel prod = listaProductosBloc.firstWhere((objeto) => objeto.id == producto.id, //el primer objeto q encuentre esa cond
            orElse: () => const ProductoModel());
        if (prod.id.isNotEmpty && state.producto.id.isEmpty) { 
          error = 'Ya existe un ID con ese valor';
        }
      }

      emit(state.copyWith(
        producto: producto,
        isWorking: false,
        error: error,
        accion: Environment.blocOnValidaProducto,
      ));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _onEliminarProducto(OnEliminarProducto event, Emitter emit) async {
    try {
      emit(state.copyWith(
        isWorking: true,
        error: '',
        accion: Environment.blocOnEliminarProducto,
      ));

      String error = '';

      List<ProductoModel> listaProductosBloc = state.listaProductos;
      listaProductosBloc.removeWhere((element) => element.id == event.idProducto);
      emit(state.copyWith(
        listaProductos: listaProductosBloc,
        isWorking: true,
        error: error,
        accion: Environment.blocOnEliminarProducto,
      ));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onOrdenarProductos(OnOrdenarProductos event, Emitter emit) async {
    try {
      emit(state.copyWith(
        isWorking: true,
        error: '',
        accion: Environment.blocOnEliminarProducto,
      ));

      String error = '';

      List<ProductoModel> listaProductosBloc = state.listaProductos;
      List<ProductoModel> listaLetras = [];

      listaLetras.addAll(listaProductosBloc.where((element) => int.tryParse(element.id) == null)); // no es un entero si es nulo no se puede parsear
      listaProductosBloc.retainWhere((element) => int.tryParse(element.id) != null); //si no es nuleo es un entero, si se puede parsear

      if (listaLetras.isNotEmpty) {
        listaLetras.sort((a, b) => a.id.compareTo(b.id));
      }
      if (listaProductosBloc.isNotEmpty) {
        listaProductosBloc.sort((a, b) => int.tryParse(a.id)!.compareTo(int.tryParse(b.id)!)); //esta te ordena los numeros
      }

      listaProductosBloc.addAll(listaLetras.where((element) => true)); // junto las listas

      emit(state.copyWith(
        isWorking: false,
        listaProductos: listaProductosBloc, //listaLetras,//listaProductosBloc
        error: error,
        accion: Environment.blocOnEliminarProducto,
      ));
    } catch (e) {
      print(e);
    }
  }
}
