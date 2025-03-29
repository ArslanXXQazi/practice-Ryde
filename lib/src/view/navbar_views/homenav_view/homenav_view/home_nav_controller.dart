import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../controllers/constants/linker.dart';

class HomeNavController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    fetchNearbyLocations();
  }

  var userName='User'.obs;
  var greeting = 'Good Morning,'.obs;
  var selectedCar = 0.obs;

  void getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('userData').doc(user.uid).get();
        if (userDoc.exists) {
          var data = userDoc.data() as Map<String, dynamic>;
          userName.value = data['name'] ?? 'Guest';
          Future.delayed(Duration(milliseconds: 500), () {
            userName.refresh();
          });
        } else {
          userName.value = 'Guest';
          update();
        }
      } catch (e) {
        userName.value = 'Guest';
        update();
      }
    }
  }

  void updateGreeting() {
    int hour = DateTime.now().hour;
    if (hour < 12) {
      greeting.value = 'Good Morning,';
    } else if (hour < 18) {
      greeting.value = 'Good Afternoon,';
    } else {
      greeting.value = 'Good Evening,';
    }
    update();
  }

  void updateSelectedCar(int index) {
    selectedCar.value = index;
  }

  void selectCarAndNavigate(int carType, BuildContext context) {
    selectedCar.value = carType; // Selected car update karo
  }

  var suggestedLocations = <Map<String, dynamic>>[].obs;

  Future<void> fetchNearbyLocations() async {
    Position position = await _determinePosition();
    String apiKey = "AIzaSyBrRRqr91A35j6PxUhjNRn4UucULfwMOiQ";
    String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude},${position.longitude}&radius=5000&type=point_of_interest&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("API Response: $data");
        List results = data['results'];
        // results = results.take(10).toList();
        suggestedLocations.value = results.map((place) {
          return {
            'name': place['name'],
            'icon': place['icon'] ?? Appimages.location, // Good: Default image agar API se na aaye
          };
        }).toList();
      }
    } catch (e) {
      print("Error fetching locations: $e");
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

}