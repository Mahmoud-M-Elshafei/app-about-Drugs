// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'Admin_Page.dart'; // Import your Admin_Page
// ////////////////////////////////////////////////////out now
// /////////////////////////////////////////////////////////////////out now
// class Admin_Login extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   final RegExp emailRegExp =
//   RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
//
//   Admin_Login({super.key});
//
//   Future<void> _authenticate(BuildContext context) async {
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();
//
//     // Query the Admin collection in Firestore
//     final adminSnapshot = await FirebaseFirestore.instance
//         .collection('Admin')
//         .where('email', isEqualTo: email)
//         .where('password', isEqualTo: password)
//         .get();
//
//     if (adminSnapshot.docs.isNotEmpty) {
//       // If admin with given email and password exists, navigate to Admin_Page
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const Admin_Page()),
//       );
//     } else {
//       // If no matching admin found, show error message
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Error'),
//             content: const Text('Invalid email or password. Please try again.'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlue[50],
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextFormField(
//                 controller: _emailController,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   if (!emailRegExp.hasMatch(value)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   labelText: 'Enter Your Email',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 8.0),
//               TextFormField(
//                 controller: _passwordController,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   labelText: 'Enter Your Password',
//                   border: OutlineInputBorder(),
//                 ),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 10.0),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue, // تغيير لون زر الدخول
//                 ),
//                 child: const Text('Log In'),
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _authenticate(context);
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
