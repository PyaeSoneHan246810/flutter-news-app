import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'explore_error_status_bloc_event.dart';

class ExploreErrorStatusBloc extends Bloc<ExploreErrorStatusEvent, bool> {
  ExploreErrorStatusBloc() : super(false) {
    on<ExploreErrorStatusChanged>((event, emit) {
      emit(event.hasError);
    });
  }
}
