import 'package:flutter/material.dart';
import '../sidebar/sidebar.dart';
import '../screens/dashboard/dashboard.dart';
import '../screens/doctor/doctors.dart';
import '../screens/settings/settings.dart';
// Appointment Screens
import '../screens/appointment/appointment.dart';
import '../screens/appointment/create_appointment.dart';
import '../screens/appointment/confirm_appointment.dart';
// Profile Scren
import '../screens/profile/profile.dart';
// Doctors Report
import '../screens/doctor/doctors_report.dart';
// Doctor Favorite
import '../screens/doctor/doctors_favorite.dart';
// Document View
import '../screens/document/documents.dart';


class MainTabView extends StatefulWidget {
  @override
  _MainTabViewState createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> with SingleTickerProviderStateMixin {
  Color hex(String hexColor) {
          final hexCode = hexColor.replaceAll('#', '');
          return Color(int.parse('FF$hexCode', radix: 16));
        }
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(elevation: 0, toolbarOpacity: 0, backgroundColor: hex('#1A1CF8'),),
       drawer: SideNavDrawer(),
       body: TabBarView(
                children: <Widget>[ 
                  Home(), 
                  Appointment(), 
                  // CreateAppointment(),
                  // ConfirmAppointment(),
                  // Doctors(), 
                  DoctorsReport(),
                  // FavoriteDoctor(),
                  // Settings() 
                  Profile()
                  // Document()
                  ],
                  controller: controller,
              ),
            
      bottomNavigationBar: Material(
        color: hex("#FAF9F9"),
        child: TabBar(
          tabs: <Widget>[
            Tab(
              icon: Image.asset("images/home.png"),
              child: Text('home', style: TextStyle(color: hex("1A1CF8"), fontSize: 10)),
            ),
            Tab(
              icon: Image.asset("images/calendar.png"),
              child: Text('Appointment', style: TextStyle(color: hex("1A1CF8"), fontSize: 10.0)),
            ),
            Tab(
              icon: Image.asset("images/doctor.png"), 
              child: Text('Medical \n history', style: TextStyle(color: hex("1A1CF8"), fontSize: 10.0)),
            ),
            Tab(
              // Image.asset("images/settings.png"),
              icon: Icon(Icons.person_pin, color: hex("#1A1CF8"),),
              child: Text('Profile', style: TextStyle(color: hex("1A1CF8"), fontSize: 10.0)),
            ),
          ],
          controller: controller,
          ),
      ),
    );
  }
}



// class MainTabView extends StatefulWidget {
//   @override
//   _MainTabViewState createState() => _MainTabViewState();
// }

// class _MainTabViewState extends State<MainTabView> {
//   Color hex(String hexColor) {
//           final hexCode = hexColor.replaceAll('#', '');
//           return Color(int.parse('FF$hexCode', radix: 16));
//         }
//   int _currentIndex = 0;
//   List tabs = [Home(), Appointment(), Doctors(), Settings()];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             title: Text('home'),
//             backgroundColor: hex("FAF9F9")
//             ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             title: Text('Appointment'),
//             backgroundColor: hex("FAF9F9")
//             ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             title: Text('Doctors'),
//             backgroundColor: hex("FAF9F9")
//             ),
//           BottomNavigationBarItem(
          
//             icon: Icon(Icons.settings),
//             title: Text('Settings'),
//             backgroundColor: hex("FAF9F9")
//             ),
//         ],
//         onTap: (index){
//           setState((){
//               _currentIndex = index;
//           });
//         },
//         ),

//         body: tabs[_currentIndex],
//     );
//   }
// }