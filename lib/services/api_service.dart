import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hospital_model.dart';

class HospitalService {
  final String baseUrl = 'http://192.168.100.22/flutter_api/';

  Future<List<Hospital>> fetchHospitals() async {
    final response = await http.get(Uri.parse(baseUrl + 'get.php'));

    if (response.statusCode == 200) {
      print('Response Body: ${response.body}');
      try {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((hospital) => Hospital.fromJson(hospital)).toList();
      } catch (e) {
        throw Exception('Gagal memparsing JSON: $e');
      }
    } else {
      throw Exception('Gagal mengambil data rumah sakit');
    }
  }

  Future<void> deleteHospital(int id) async {
    final response = await http.post(
      Uri.parse(baseUrl + 'delete.php'),
      body: {'id': id.toString()},
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus data rumah sakit');
    }
  }

  Future<void> addOrUpdateHospital(Hospital hospital) async {
    final String url = hospital.id == 0
        ? baseUrl + 'post.php'  
        : baseUrl + 'update.php';  

    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': hospital.id.toString(),
        'name': hospital.name,
        'location': hospital.location,
        'price': hospital.price.toString(),
        'rating': hospital.rating.toString(),
        'description': hospital.description,
        'image_url': hospital.imageUrl,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menyimpan data rumah sakit');
    }
  }
}
