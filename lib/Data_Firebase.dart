import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Feedback_Page.dart';
import 'Map.dart';
import 'User_Profil_Login.dart';
import 'Doctors_Profile.dart';
import 'firebase_options.dart';
import 'AI.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug sign
      title: 'DDrug',
      home: Drug_Data(),
    );
  }
}

class Drug_Data extends StatefulWidget {
  const Drug_Data({Key? key});

  @override
  _Drug_Data_Fire createState() => _Drug_Data_Fire();
}

class _Drug_Data_Fire extends State<Drug_Data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
        automaticallyImplyLeading: false, // Remove back arrow
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Text_R()),
              );
            },
            tooltip: 'Prescription Reader', // Tooltip text //show what this icon do
          ),
        ],
      ),
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _build_Section( context, 'Cold&Flu - نزلات البرد والإنفلونزا',
                        FirebaseFirestore.instance.collection('cold&flu')),
                    _build_Section(
                        context, 'Pain&Fever - الألم والحمى',
                        FirebaseFirestore.instance.collection('pain&fever')),
                    _build_Section(
                        context, 'laxatives - المسهلات-الملينات',
                        FirebaseFirestore.instance.collection('laxatives')),
                    _build_Section(
                        context, 'digestives - عسرالهضم-المهضمات',
                        FirebaseFirestore.instance.collection('digestives')),
                    _build_Section(context, 'MIGRAINE - الصداع النصفي',
                        FirebaseFirestore.instance.collection('MIGRAINE')),
                    _build_Section(
                        context, 'pain&anti-inflammatory - الألم ومضاد للالتهابات',
                        FirebaseFirestore.instance.collection('pain&anti-inflammatory')),
                    _build_Section(
                        context, 'colic&contractions - ألام البطن-المغص والتقلصات',
                        FirebaseFirestore.instance.collection('colic&contractions')),
                    _build_Section(
                        context, 'acidity&burning - ألام البطن-الحموضةوالحرقان',
                        FirebaseFirestore.instance.collection('acidity&burning')),
                    _build_Section(
                        context, 'diarrhea - علاج الإسهال-مطهرمعوي',
                        FirebaseFirestore.instance.collection('diarrhea')),
                    _build_Section(
                        context, 'allergies&infections - الحساسية(الحكةوسيلان-الأنف)والألتهابات',
                        FirebaseFirestore.instance.collection('allergies&infections')),
                    _build_Section(
                        context, 'anti-bloating&gases - الانتفاخ والغازات',
                        FirebaseFirestore.instance.collection('anti-bloating&gases')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile_Page()),
                );
                // Navigate to user profile page
              },
              tooltip: 'User Profile', // Tooltip text //show what this icon do
            ),
            IconButton(
              icon: const Icon(Icons.map),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pharmacy_Map()),
                );
              },
              tooltip: ' Pharmacies', // Tooltip text //show what this icon do
            ),
            IconButton(
              icon: const Icon(Icons.chat),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WhatsApp_Page()),
                );
                // Navigate to chat page
              },
              tooltip: 'Connect with Doctor', // Tooltip text //show what this icon do
            ),
            IconButton(
              icon: const Icon(Icons.feedback),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Feedback_Page()),
                );
                // Navigate to chat page
              },
              tooltip: 'Give Your Feedback ', // Tooltip text //show what this icon do
            ),
          ],
        ),
      ),
    );
  }

  Widget _build_Section(BuildContext context, String title,
      CollectionReference collectionReference) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Collection_Details_Screen(
                title: title, collectionReference: collectionReference),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(
              _getIconData(title),
              color: Colors.black,
            ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String title) {
    switch (title) {
      case 'Pain&Fever - الألم والحمى':
        return Icons.healing;
      default:
        return Icons.medication; // Default icon
    }
  }
}

class Collection_Details_Screen extends StatelessWidget {
  final String title;
  final CollectionReference collectionReference;

  const Collection_Details_Screen(
      {Key? key, required this.title, required this.collectionReference});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collectionReference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final DocumentSnapshot document = documents[index];
              final Map<String, dynamic> data =
              document.data() as Map<String, dynamic>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: data.entries.map((entry) {
                  return _buildItemContainer(entry.key, entry.value);
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
  Widget _buildItemContainer(String fieldName, dynamic fieldValue) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              fieldName,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          if (fieldValue is String)
            Expanded(
              child: Text(
                fieldValue,
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
