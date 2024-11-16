// import 'package:flutter/material.dart';
// import 'Login_Page.dart';
// import 'Admin_Login.dart';
//
// class RoleSelectionPage extends StatelessWidget {
//   const RoleSelectionPage({super.key});
//
//   @override
//   /////////////////////////////////////////////////////////////////out now
// ///////////////////////////////////////////////////////////////////out now
//   Widget build(BuildContext context) {
//     return Scaffold(backgroundColor: Colors.blue,
//       appBar: AppBar(
//         title: const Text('Select Role'),
//       ),
//       body: Center(
//
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to Admin Page
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Admin_Login()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20), // Set button padding
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0), // Set button border radius
//                 ),
//                 textStyle: const TextStyle(fontSize: 20), // Set button text size
//               ),
//               child: const Text('Admin'),
//             ),
//             const SizedBox(height: 20), // Add some spacing between the buttons
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to User Page
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginPage()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20), // Set button padding
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0), // Set button border radius
//                 ),
//                 textStyle: const TextStyle(fontSize: 20), // Set button text size
//               ),
//               child: const Text('User'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }