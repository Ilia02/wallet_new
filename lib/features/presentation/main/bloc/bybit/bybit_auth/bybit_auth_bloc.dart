import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bybit_auth_event.dart';
part 'bybit_auth_state.dart';

class BybitAuthBloc extends Bloc<BybitAuthEvent, BybitAuthState> {
  BybitAuthBloc() : super(BybitAuthInitial()) {
    on<BybitAuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
