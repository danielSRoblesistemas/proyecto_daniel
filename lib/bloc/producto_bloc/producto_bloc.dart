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
    on<OnGuardarProducto>(_onGuardarBotCategoria);
    // on<OnActualizaProducto>();
    on<OnObtenerlstProducto>(_onObtenerlstProducto);
  }

  Future<void> _onNuevoProducto(OnNuevoProducto event, Emitter emit) async {
    emit(
      state.copyWith(
        isWorking: true,
        producto: ProductoModel(),
        error: '',
        accion: Environment.blocOnNuevoProducto,
      ),
    );

    emit(state.copyWith(isWorking: false, producto: ProductoModel(), error: '', accion: Environment.blocOnNuevoProducto));
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
      ProductoModel producto = ProductoModel();

      state.listaProductos.forEach((element) {
        if (element.id.contains(event.idProducto)) {
          producto = element;
        }
      });

      emit(state.copyWith(
        producto: producto,
        isWorking: false,
        error: '',
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

      String error = '';

      emit(state.producto.obtenerListaEstatica());
    } catch (e) {}
  }

  Future<void> _onGuardarBotCategoria(OnGuardarProducto event, Emitter emit) async {
    emit(state.copyWith(
      isWorking: true,
      error: '',
      accion: Environment.blocOnGuardarProducto,
    ));

    List<ProductoModel> listaProductosBloc = state.listaProductos;
    ProductoModel producto = state.producto;
    listaProductosBloc.removeWhere((element) => element.id == producto.id);
    producto = producto.copyWith(id: listaProductosBloc.length.toString());

    // ProductoModel productoFinal = state.producto;
    listaProductosBloc.add(producto);

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
    emit(state.copyWith(
      isWorking: true,
      error: '',
      accion: Environment.blocOnValidaProducto,
    ));

    String error = '';
    ProductoModel producto = event.producto;

    if (producto.id.isEmpty) {
      error = 'El id esta vacio';
    } else if (event.producto.descripcion.isEmpty) {
      error = 'la descripcion esta vacia';
    }

    emit(state.copyWith(
      producto: producto,
      isWorking: false,
      error: error,
      accion: Environment.blocOnValidaProducto,
    ));
  }
}
