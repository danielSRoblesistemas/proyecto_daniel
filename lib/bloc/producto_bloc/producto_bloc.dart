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
    // on<OnValidarProducto>(_onValidarProducto);
    // on<OnGuardarProducto>();
    // on<OnActualizaProducto>();
    on<OnObtenerlstProducto>(_onObtenerlstProducto);
  }

  Future<void> _onNuevoProducto(OnNuevoProducto event, Emitter emit) async {
    emit(
      state.copyWith(isWorking: true, producto: ProductoModel(), error: '', accion: Environment.blocOnNuevoProducto),
    );
  }

  Future<void> _onModificarProducto(OnModificarProducto event, Emitter emit) async {
    try {
      emit(state.copyWith(isWorking: true, error: '', campoError: '', accion: Environment.blocOnModificarProducto));
    } catch (e) {
      emit(state.copyWith(isWorking: false, error: e.toString(), accion: Environment.blocOnModificarProducto));
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

    } catch (e) {
      
    }
  }
}
