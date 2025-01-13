import 'package:flutter/material.dart';
import 'package:tugas_mobile/UI/hospital_list_screen.dart';
 
void main() {
  runApp(HospitalApp());
}

class HospitalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Rumah Sakit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HospitalListScreen(), 
    );
  }
}
