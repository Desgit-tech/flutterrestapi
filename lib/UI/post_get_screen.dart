import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostGetScreen extends StatefulWidget {
  @override
  _PostGetScreenState createState() => _PostGetScreenState();
}

class _PostGetScreenState extends State<PostGetScreen> {
  List hospitals = [];

  @override
  void initState() {
    super.initState();
    fetchHospitals();
  }

  Future<void> fetchHospitals() async {
    final response = await http.get(Uri.parse('http://192.168.100.22/flutter_api/get.php'));

    if (response.statusCode == 200) {
      setState(() {
        hospitals = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load hospitals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POST and GET All Hospitals'),
      ),
      body: ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(hospitals[index]['name']),
            subtitle: Text('Price: ${hospitals[index]['price']}\nRating: ${hospitals[index]['rating']}'),
          );
        },
      ),
    );
  }
}
