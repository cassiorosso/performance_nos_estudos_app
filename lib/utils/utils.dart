// import 'dart:collection';

// import 'package:get_it/get_it.dart';
// import 'package:table_calendar/table_calendar.dart';

// import '../controllers/revisoes_controller.dart';

// /// Example event class.
// class Event {
//   final String title;

//   const Event(this.title);

//   @override
//   String toString() => title;
// }

// final revisoesController = GetIt.I<RevisoesController>();

// /// Example events.
// ///
// /// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
// final kEvents = LinkedHashMap<DateTime, List<Event>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(revisoesController.calendarRevisoesFormat());


// int getHashCode(DateTime key) {
//   return key.day * 1000000 + key.month * 10000 + key.year;
// }


// final kToday = DateTime.now();
// final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
// final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
