import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selected_category_event.dart';

class SelectedCategoryBloc extends Bloc<SelectedCategoryEvent, int> {
  SelectedCategoryBloc() : super(0) {
    on<SelectedCategoryChanged>((event, emit) {
      emit(event.selectedCategoryIndex);
    });
  }
}
