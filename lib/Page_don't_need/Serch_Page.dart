// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'DDrug',
//       home: DrugData(title: '', collectionName: '',),
//     );
//   }
// }
//
// class DrugData extends StatefulWidget {
//   const DrugData({Key? key, required String title, required String collectionName});
//
//   @override
//   _DrugDataAndSearchState createState() => _DrugDataAndSearchState();
// }
//
// class _DrugDataAndSearchState extends State<DrugData> {
//   late TextEditingController _searchController;
//
//   @override
//   void initState() {
//     super.initState();
//     _searchController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       backgroundColor: Colors.blue,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               'Search for Collection',
//               style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16.0),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _searchController,
//                     cursorErrorColor: Colors.red,
//                     decoration: const InputDecoration(
//                       hintText: 'Enter collection name',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.search),
//                   color: Colors.black,
//                   onPressed: () {
//                     String collectionName = _searchController.text.trim();
//                     if (collectionName.isNotEmpty) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => CollectionDetailsScreen(
//                           title: 'Search Results for: $collectionName',
//                           collectionName: collectionName,
//                         )),
//                       );
//                     } else {
//                       // Show error or prompt user to enter a collection name
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CollectionDetailsScreen extends StatelessWidget {
//   final String title;
//   final String collectionName;
//
//   const CollectionDetailsScreen({
//     Key? key,
//     required this.title,
//     required this.collectionName,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collectionGroup(collectionName).snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }
//           final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
//           if (documents.isEmpty) {
//             return Center(
//               child: Text('No data found for: $collectionName'),
//             );
//           }
//           return ListView.builder(
//             itemCount: documents.length,
//             itemBuilder: (BuildContext context, int index) {
//               final DocumentSnapshot document = documents[index];
//               final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: data.entries.map((entry) {
//                   return _buildItemContainer(entry.key, entry.value);
//                 }).toList(),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildItemContainer(String fieldName, dynamic fieldValue) {
//     return Container(
//       color: Colors.blue,
//       padding: const EdgeInsets.all(8.0),
//       margin: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Text(
//               fieldName,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ),
//           if (fieldValue is String)
//             Expanded(
//               child: Text(
//                 fieldValue,
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
