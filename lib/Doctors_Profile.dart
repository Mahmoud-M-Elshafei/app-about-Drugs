import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Doctors_Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctors Profile ',
      theme: ThemeData(
        primaryColor: Colors.blue, // Set primary color to blue
      ),
      home: WhatsApp_Page(),
    );
  }
}

class WhatsApp_Page extends StatelessWidget {
  final List<Map<String, String>> users = [
    {
      'name': 'Dr. Mahmoud',
      'email': 'mahmoud.mohamed0207@gmail.com.com',
      'phone': '+201552717474'
    },
    {
      'name': 'Dr. Ahmed',
      'email': 'dr.ahmedbadawy2015@gmail.com',
      'phone': '+201006267134'
    },
    {
      'name': 'Dr. Ahmed',
      'email': 'ampop485@gmail.com',
      'phone': '+201007803626'
    },
    {
      'name': 'Dr. Assem',
      'email': 'assemosama759@gmail.com',
      'phone': '+201128277672'
    },
    {
      'name': 'Dr. Sameh',
      'email': 'Assem@example.com',
      'phone': '+201016133206'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors Profile ',style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return Profile_Card(
            name: users[index]['name']!,
            email: users[index]['email']!,
            phone: users[index]['phone']!,
          );
        },
      ),
    );
  }
}

class Profile_Card extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  Profile_Card({
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add elevation for a modern look
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Add margin for spacing between cards
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Round the corners of the card
      ),
      child: InkWell(
        onTap: () => _Contact_Options(context),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0, // Increase font size for name
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Email: $email',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                'Phone: $phone',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),

      ),
    );
  }

  void _Contact_Options(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Call $name'),
                onTap: () => _Launch_PhoneCall(phone),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Send email to $name'),
                onTap: () => _Send_Email(email),
              ),
              ListTile(
                leading: Icon(Icons.chat),
                title: Text('Open WhatsApp chat with $name'),
                onTap: () => _Launch_WhatsApp(phone),
              ),
            ],
          ),
        );
      },
    );
  }

  void _Launch_WhatsApp(String phone) async {
    String formatPhone = phone.replaceAll(RegExp(r'[^\d]+'), '');

    final url = 'https://api.whatsapp.com/send?phone=$formatPhone';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching WhatsApp: $e');
    }
  }

  void _Launch_PhoneCall(String phone) async {
    String formatPhone = phone.replaceAll(RegExp(r'[^\d]+'), '');

    final url = 'tel:$formatPhone';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching phone call: $e');
    }
  }

  void _Send_Email(String email) async {
    final url = 'mailto:$email';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error sending email: $e');
    }
  }
}
