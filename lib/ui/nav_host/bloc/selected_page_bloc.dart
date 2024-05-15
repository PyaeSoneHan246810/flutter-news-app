import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selected_page_event.dart';

class SelectedPageBloc extends Bloc<SelectedPageEvent, int> {
  SelectedPageBloc() : super(0) {
    on<SelectedPageChanged>((event, emit) {
      emit(event.selectedPageIndex);
    });
  }
}
