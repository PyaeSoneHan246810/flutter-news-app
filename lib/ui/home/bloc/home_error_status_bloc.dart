import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_error_status_event.dart';

class HomeErrorStatusBloc extends Bloc<HomeErrorStatusEvent, bool> {
  HomeErrorStatusBloc() : super(false) {
    on<HomeErrorStatusChanged>((event, emit) {
      emit(event.hasError);
    });
  }
}
