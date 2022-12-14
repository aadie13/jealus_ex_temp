import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/screens/show_pending_bookings_temp.dart';
//************************************************************//
import 'history_view.dart';
import 'messages_view.dart';
import 'profle_view.dart';
import 'home_view.dart';

class TabBarScreen extends HookWidget {
  List<Widget> _pageList = [HomeView(),PendingBookingsList(), HistoryView(), MessagesView(), ProfileView()];
  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider.state);
    final navigationIndex = useState(0);
    return Scaffold(
      appBar: AppBar(
        title: new Text('Mobile Mechanic',style: TextStyle(fontSize: 25.0),),
        // leading: IconButton(icon: const Icon(Icons.logout),
        //   onPressed: () {
        //     context.read(authControllerProvider).signOut();
        //   },),
        leading: authControllerState != null ? IconButton(icon: const Icon(Icons.logout),
          onPressed: () {
            context.read(authControllerProvider).signOut();
            //var user = context.read(authControllerS)
            Navigator.of(context).pushReplacementNamed('/logIn');

          },):null,
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: _pageList[navigationIndex.value],
      bottomNavigationBar: new BottomNavigationBar(
        onTap: (int index) => navigationIndex.value =index,
        currentIndex: navigationIndex.value,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_outlined),//.timeline_rounded),//.pending_actions_sharp),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// class TabBarScreen extends StatefulWidget {
//   @override
//   _TabBarScreenState createState() => _TabBarScreenState();
// }
//
// class _TabBarScreenState extends State<TabBarScreen> {
//   List<Widget> pageList = [];
//   int _currentIndex = 0;
//   @override
//   void initState(){
//     pageList.add(HomeView());
//     pageList.add(HistoryView());
//     pageList.add(MessagesView());
//     pageList.add(ProfileView());
//     mustCallSuper;
//   }
//   @override
//   Widget build(BuildContext context) {
//     final authControllerState = useProvider(authControllerProvider.state);
//     return Scaffold(
//       appBar: AppBar(
//         title: new Text('Mobile Mechanic',style: TextStyle(fontSize: 25.0),),
//         // leading: IconButton(icon: const Icon(Icons.logout),
//         //   onPressed: () {
//         //     context.read(authControllerProvider).signOut();
//         //   },),
//         leading: authControllerState != null ? IconButton(icon: const Icon(Icons.logout),
//           onPressed: () {
//             context.read(authControllerProvider).signOut();
//             //var user = context.read(authControllerS)
//             if (authControllerState == null){
//               Navigator.of(context).pushReplacementNamed('/logIn');
//             }
//
//           },):null,
//       ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: pageList,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: onTabTapped,
//         currentIndex: _currentIndex,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(
//             icon: new Icon(Icons.home),
//             title: new Text(
//                 'Home'
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: new Icon(Icons.history),
//             title: new Text(
//                 'History'
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: new Icon(Icons.message),
//             title: new Text(
//                 'Messages'
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: new Icon(Icons.account_circle),
//             title: new Text(
//                 'Profile'
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   void onTabTapped(int index){
//     setState(() {
//       _currentIndex = index;
//     });
//   }
// }