import 'package:flutter/material.dart';
import '../models/hospital_model.dart';
import 'package:http/http.dart' as http;

class AddHospitalScreen extends StatefulWidget {
  final Hospital? hospital;

  AddHospitalScreen({this.hospital});

  @override
  _AddHospitalScreenState createState() => _AddHospitalScreenState();
}

class _AddHospitalScreenState extends State<AddHospitalScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.hospital != null) {
      nameController.text = widget.hospital!.name;
      locationController.text = widget.hospital!.location;
      priceController.text = widget.hospital!.price.toString();
      ratingController.text = widget.hospital!.rating.toString();
      descriptionController.text = widget.hospital!.description;
      imageUrlController.text = widget.hospital!.imageUrl;
    }
  }

  Future<void> addOrUpdateHospital() async {
  if (nameController.text.isEmpty ||
      locationController.text.isEmpty ||
      priceController.text.isEmpty ||
      ratingController.text.isEmpty ||
      descriptionController.text.isEmpty ||
      imageUrlController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Semua field harus diisi')));
    return;
  }

  final String url = widget.hospital == null
      ? 'http://192.168.100.22/flutter_api/post.php'
      : 'http://192.168.100.22/flutter_api/update.php';

  final response = await http.post(
    Uri.parse(url),
    body: {
      'id': widget.hospital?.id.toString() ?? '',
      'name': nameController.text,
      'location': locationController.text,
      'price': priceController.text,
      'rating': ratingController.text,
      'description': descriptionController.text,
      'image_url': imageUrlController.text,
    },
  );

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data berhasil disimpan')));
    Navigator.pop(context, true); 
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menyimpan data')));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hospital == null ? 'Tambah Rumah Sakit' : 'Edit Rumah Sakit'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama Rumah Sakit'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Lokasi'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Harga'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: ratingController,
              decoration: InputDecoration(labelText: 'Rating'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'URL Gambar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addOrUpdateHospital,
              child: Text(widget.hospital == null ? 'Tambah Rumah Sakit' : 'Update Rumah Sakit'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Kembali ke Daftar Rumah Sakit'),
            ),
          ],
        ),
      ),
    );
  }
}
