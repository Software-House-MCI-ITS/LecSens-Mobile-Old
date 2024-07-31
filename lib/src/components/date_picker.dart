import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChange,
    this.restorationId,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChange;
  final String? restorationId;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _DatePickerState extends State<DatePicker> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  late final RestorableDateTime _selectedDate =
      RestorableDateTime(widget.selectedDate);

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    final DateTime initialDate = DateTime.fromMillisecondsSinceEpoch(arguments! as int);
    final DateTime firstDate = DateTime(2021);
    final DateTime lastDate = DateTime(2024, 12, 31); // Ensure this is after the initialDate

    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        widget.onDateChange(newSelectedDate); // Notify parent widget
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${DateFormat('EEEE, d MMMM yyyy').format(_selectedDate.value)}'),
        ));
      });
    }
  }

  @override
  void didUpdateWidget(covariant DatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      _selectedDate.value = widget.selectedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _restorableDatePickerRouteFuture.present();
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.only(left: 15),
        minimumSize: Size(50, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Colors.transparent,
        overlayColor: Colors.transparent,
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: Colors.black),
          SizedBox(width: 8),
          Text(
            DateFormat('EEEE, d MMMM yyyy').format(_selectedDate.value),
            style: TextStyle(color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }
}
