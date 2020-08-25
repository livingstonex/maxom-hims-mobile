import 'package:device_calendar/device_calendar.dart';

var calendars;
List<String> calendarNames = [];

DeviceCalendarPlugin _deviceCalendarPlugin = new DeviceCalendarPlugin();

retrieveCalendars() async{
  try {
    var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
    if (permissionsGranted.isSuccess && !permissionsGranted.data){

        permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess || permissionsGranted.data) {
          return;
        }
    }

    final calendarsResult = _deviceCalendarPlugin.retrieveCalendars();
    calendars = calendarsResult?.asStream();
    print(calendars);
    print(calendarNames);
  } catch (e) {
    print(e);
  }
}

addCalendars() async{
  try {
    var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
    if (permissionsGranted.isSuccess && !permissionsGranted.data){

        permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess || permissionsGranted.data) {
          return;
        }
    }

    final calendarsResult = _deviceCalendarPlugin.retrieveCalendars();
    calendars = calendarsResult?.asStream();
    print(calendars);
    print(calendarNames);
  } catch (e) {
    print(e);
  }
}