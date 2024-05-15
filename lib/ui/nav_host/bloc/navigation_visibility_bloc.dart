import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_visibility_event.dart';

class NavigationVisibilityBloc extends Bloc<NavigationVisibilityEvent, bool> {
  NavigationVisibilityBloc() : super(true) {
    on<NavigationVisibilityChanged>((event, emit) {
      emit(event.isVisible);
    });
  }
}
