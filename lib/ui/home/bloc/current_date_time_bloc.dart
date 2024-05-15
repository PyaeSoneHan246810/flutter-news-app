import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'current_date_time_event.dart';
part 'current_date_time_state.dart';

class CurrentDateTimeBloc
    extends Bloc<CurrentDateTimeEvent, CurrentDateTimeState> {
  CurrentDateTimeBloc()
      : super(
          CurrentDateTimeState(
            greetingMessage: "",
            dayOfWeek: "",
            formattedDate: "",
          ),
        ) {
    on<CurrentDateTimeFetched>(_getCurrentDateTime);
  }

  void _getCurrentDateTime(
    CurrentDateTimeFetched event,
    Emitter<CurrentDateTimeState> emit,
  ) {
    final currentDateTime = DateTime.now();
    final currentHour = currentDateTime.hour;

    String greetingMessage;
    if (currentHour >= 4 && currentHour < 12) {
      greetingMessage = 'Good Morning,';
    } else if (currentHour >= 12 && currentHour < 17) {
      greetingMessage = 'Good Afternoon,';
    } else if (currentHour >= 17 && currentHour < 21) {
      greetingMessage = 'Good Evening,';
    } else {
      greetingMessage = 'Good Night,';
    }

    String dayOfWeek = DateFormat.E('en_US').format(currentDateTime);

    String formattedDate = DateFormat.yMMMMd('en_US').format(currentDateTime);

    emit(
      CurrentDateTimeState(
        greetingMessage: greetingMessage,
        dayOfWeek: dayOfWeek,
        formattedDate: formattedDate,
      ),
    );
  }
}
