import 'package:flutter/material.dart';
import '../models/hospital_model.dart';
import 'package:tugas_mobile/UI/add_hospital_screen.dart';
import '../services/api_service.dart';

class HospitalCard extends StatelessWidget {
  final Hospital hospital;
  final Function() onDelete;

  HospitalCard({required this.hospital, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                hospital.imageUrl,
                height: 500,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () async {
                    final updatedHospital = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddHospitalScreen(hospital: hospital),
                      ),
                    );
                    if (updatedHospital != null) {
                      // Jika ada pembaruan, refresh daftar rumah sakit
                      onDelete(); // Pastikan untuk memanggil fungsi onDelete untuk menyegarkan data
                    }
                  },
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: () async {
                    final confirmDelete = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Hapus Rumah Sakit'),
                          content: Text('Apakah Anda yakin ingin menghapus rumah sakit ini?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('Hapus'),
                            ),
                          ],
                        );
                      },
                    );
                    if (confirmDelete) {
                      await HospitalService().deleteHospital(hospital.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Rumah Sakit berhasil dihapus')),
                      );
                      onDelete(); // Trigger the parent to refresh the list
                    }
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(hospital.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(hospital.location),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Harga: ${hospital.price}'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Rating: ${hospital.rating}'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Deskripsi: ${hospital.description}',  
              overflow: TextOverflow.ellipsis,  
            ),
          ),
        ],
      ),
    );
  }
}
