import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

/// Type of date picker for [FlutterDatePicker] to use.
///
/// This is primarily used as an internal mechanism for the various accessors
/// ([showYearPicker], [showMonthPicker], [showDayPicker]) to signal their
/// required picker type, but is exposed to support direct instantiation of
/// [FlutterDatePicker], where desired.
enum FlutterDatePickerMode {
  /// Show a date picker for choosing a year.
  year,
}

Future<DateTime> showYearPicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  required Widget title,
  required EdgeInsetsGeometry titlePadding,
}) async {
  assert(context != null);
  assert(initialDate != null);

  return await showDialog(
    context: context,
    builder: (context) => FlutterDatePicker(
      mode: FlutterDatePickerMode.year,
      selectedDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      title: title,
      titlePadding: titlePadding,
    ),
  );
}

/// A non-cascading [SimpleDialog] view of a [FlutterDatePickerMode] picker.
///
/// In general this class does not need to be used directly, and should
/// be primarily accessed through the [showYearPicker], [showMonthPicker]
/// and [showDayPicker] convenience wrappers.
class FlutterDatePicker extends StatefulWidget {
  final FlutterDatePickerMode mode;
  final EdgeInsetsGeometry titlePadding;
  final Widget title;
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;

  FlutterDatePicker(
      {Key? key,
      required this.mode,
      required this.title,
      required this.titlePadding,
      required this.selectedDate,
      required this.firstDate,
      required this.lastDate})
      : assert(!firstDate.isAfter(lastDate)),
        assert(
            selectedDate.isAfter(firstDate) && selectedDate.isBefore(lastDate)),
        super(key: key);

  @override
  _FlutterDatePickerState createState() => _FlutterDatePickerState();
}

class _FlutterDatePickerState extends State<FlutterDatePicker> {
  final GlobalKey _pickerKey = GlobalKey();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        // titlePadding: widget.titlePadding ?? widget.title == null
        //     ? EdgeInsets.all(0)
        //     : EdgeInsets.all(20.0),
        title: widget.title,
        titleTextStyle:
            GoogleFonts.mcLaren(color: Color(0xFF546E7A), fontSize: 20),
        children: <Widget>[
          Container(
              height: 300,
              width: double.maxFinite,
              // ignore: deprecated_member_use
              child: YearPicker(
                key: _pickerKey,
                firstDate: widget.firstDate,
                selectedDate: _selectedDate,
                lastDate: widget.lastDate,
                onChanged: (DateTime selected) {
                  setState(() {
                    _selectedDate = selected;
                  });
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('CANCELAR',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Color(0xFF546E7A),
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(_selectedDate);
                },
                child: Text('OK',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Color(0xFF546E7A),
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ]);
  }
}
