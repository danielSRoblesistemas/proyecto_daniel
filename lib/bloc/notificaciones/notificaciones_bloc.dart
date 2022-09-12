
// import 'package:cdm_genesis/model/notificacion.dart';
// import 'package:cdm_genesis/src/global/environment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:proyecto_daniel/global/environment.dart';
import 'package:proyecto_daniel/model/notificacion.dart';

part 'notificaciones_event.dart';
part 'notificaciones_state.dart';

class NotificacionesBloc
    extends Bloc<NotificacionesEvent, NotificacionesState> {
  NotificacionesBloc() : super(NotificacionesState()) {
    on<OnNuevaNotificacionEvent>(_onNuevaNotificacionEvent);
    on<OnEliminaNotificacionEvent>(_onEliminaNotificacionEvent);
  }

  ///Agrega una nueva notificacion al state
  Future<void> _onNuevaNotificacionEvent(
      OnNuevaNotificacionEvent event, Emitter emit) async {
    final Map<int, Notificacion> notificaciones = state.notificaciones;

    int ultimoIndice = 0;
    if (notificaciones.isNotEmpty) {
      ultimoIndice = notificaciones.keys.last + 1;
    }
    notificaciones.removeWhere((key, value) => key < ultimoIndice - 6);
    notificaciones.putIfAbsent(ultimoIndice, () => event.nuevaNotificacion);

    emit(state.copyWith(
        accion: Environment.blocOnNuevaNotificacion,
        notificaciones: notificaciones));
  }

  Future<void> _onEliminaNotificacionEvent(
      OnEliminaNotificacionEvent event, Emitter emit) async {
    final Map<int, Notificacion> notificaciones = state.notificaciones;
    Map<int, Notificacion> nuevaLista = {};
    for (var element in notificaciones.entries) {
      if (element.key > event.indice) nuevaLista.addEntries({element});
    }
    emit(state.copyWith(
        accion: Environment.blocOnEliminarNotificacion,
        notificaciones: nuevaLista));
  }
}
