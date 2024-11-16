import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

// void main() {
//   runApp(MyApp());
// }
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharmacy ',
      home: Pharmacy_Map(),

    );
  }
}
class Pharmacy {
  final String name;
  final double lat;
  final double lng;
  final String address;

  Pharmacy({
    required this.name,
    required this.lat,
    required this.lng,
    this.address = '',
  });
}
class Pharmacy_Map extends StatefulWidget {
  @override
  _Pharmacy_Map_State createState() => _Pharmacy_Map_State();
}
class _Pharmacy_Map_State extends State<Pharmacy_Map> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  Future<void> _Request_Location_Permission() async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      // Location permission granted, proceed with displaying the map
      _addPharmacyMarkers();
    } else {
      // Location permission denied, handle accordingly (show message, etc.)
      print('Location permission denied');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pharmacy ',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(30.013056, 31.208853), // San Francisco coordinates
          zoom: 12,
        ),
        markers: _markers,
        onMapCreated: _onMapCreated,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }


  void _addPharmacyMarkers() {
    List<Pharmacy> pharmacies = [
      Pharmacy(
        name: 'Ahmed Badawy 1 ,د.أحمد بدوي ',
        lat: 30.02315636056966,
        lng: 31.188137925164785,
        address: 'شارع صلاح ابو اليزيد, شارع الملك فيصل، محافظة الجيزة',
      ),
      Pharmacy(
        name: 'Ahmed Badawy 2 ,د.أحمد بدوي',
        lat: 30.020183812445214,
        lng: 31.1917791448984,
        address: 'شارع محمد النادي من شارع ترعة عبدالعال، شارع الملك فيصل، محافظة الجيزة',
      ),
      Pharmacy(
        name: 'Ahmed Salah 2 ,د.احمدصلاح',
        lat:30.02165639208662,
        lng:31.190740064840114
        ,
        address: 'شارع سلامة عيد, نزالة خلف، بولاق الدكرور، محافظة الجيزة ',
      ),
      Pharmacy(
        name: 'Sohair  Elansary , د.سهير الأنصاري',
        lat:30.156440747667038,
        lng:31.60970066755873,
        address: '[جنه مول,شارع 43 منطقة د2,الشروق،محافظة القاهرة ',
      ),

      Pharmacy(
        name: 'Ahmed Mohy , د.احمد محي',
        lat:30.1556577606275,
        lng:31.608358940747088,
        address: 'الصفا مول,شارع قهمي النقرتشي,الشروق،محافظة القاهرة ',
      ),
      Pharmacy(
        name: 'Mahmoud Bakr , د.محمود أبوبكر',
        lat:30.15427353704425,
        lng: 31.62076190172428,
        address: 'شارع احمد باشا ماهر,الشروق،محافظة القاهرة ',
      ),
    ];
    setState(() {
      _markers.clear();
      for (var pharmacy in pharmacies) {
        _markers.add(
          Marker(
            markerId: MarkerId(pharmacy.name),
            position: LatLng(pharmacy.lat, pharmacy.lng),
            infoWindow: InfoWindow(
              title: pharmacy.name,
              snippet: 'Address: ${pharmacy.address}',
            ),
            onTap: () => _openMap(pharmacy.lat, pharmacy.lng),
          ),
        );
      }
    });
  }

  Future<void> _openMap(double latitude, double longitude) async {
    final mapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(mapsUrl)) {
      await launch(mapsUrl);
    } else {
      throw 'Could not launch $mapsUrl';
    }
  }
  @override
  void initState() {
    super.initState();
    _Request_Location_Permission(); // Request location permission when the widget is initialized
  }
}

