import 'package:flutter/material.dart';
import 'package:tugas_mobile/UI/add_hospital_screen.dart';
import '../models/hospital_model.dart';
import '../services/api_service.dart';
import '../widgets/hospital_card.dart';

class HospitalListScreen extends StatefulWidget {
  @override
  _HospitalListScreenState createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  late Future<List<Hospital>> futureHospitals;
  TextEditingController searchController = TextEditingController();
  List<Hospital> allHospitals = [];
  List<Hospital> filteredHospitals = [];

  @override
  void initState() {
    super.initState();
    futureHospitals = HospitalService().fetchHospitals();
  }

  void refreshHospitals() {
    setState(() {
      futureHospitals = HospitalService().fetchHospitals();
    });
  }

  void filterHospitals(String query) {
    setState(() {
      filteredHospitals = allHospitals
          .where((hospital) =>
              hospital.name.toLowerCase().contains(query.toLowerCase()) ||
              hospital.location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Rumah Sakit'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: HospitalSearchDelegate(allHospitals),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Hospital>>(
        future: futureHospitals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada rumah sakit ditemukan'));
          } else {
            allHospitals = snapshot.data!;
            filteredHospitals = allHospitals;

            return ListView.builder(
              itemCount: filteredHospitals.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    final hospital = filteredHospitals[index];
                    final updatedHospital = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddHospitalScreen(hospital: hospital),
                      ),
                    );
                    if (updatedHospital != null) {
                      refreshHospitals();
                    }
                  },
                  child: HospitalCard(
                    hospital: filteredHospitals[index],
                    onDelete: () => refreshHospitals(),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            textStyle: TextStyle(fontSize: 18),
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddHospitalScreen()),
            );
            refreshHospitals();
          },
          child: Text(
            'Tambah Rumah Sakit',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class HospitalSearchDelegate extends SearchDelegate {
  final List<Hospital> allHospitals;

  HospitalSearchDelegate(this.allHospitals);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allHospitals
        .where((hospital) =>
            hospital.name.toLowerCase().contains(query.toLowerCase()) ||
            hospital.location.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder( 
      itemCount: results.length,
      itemBuilder: (context, index) {
        final hospital = results[index];
        return ListTile(
          title: Text(hospital.name),
          subtitle: Text(hospital.location),
          onTap: () async {
            final updatedHospital = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddHospitalScreen(hospital: hospital),
              ),
            );
            if (updatedHospital != null) {
              close(context, updatedHospital);
            }
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = allHospitals
        .where((hospital) =>
            hospital.name.toLowerCase().contains(query.toLowerCase()) ||
            hospital.location.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final hospital = suggestions[index];
        return ListTile(
          title: Text(hospital.name),
          subtitle: Text(hospital.location),
          onTap: () async {
            final updatedHospital = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddHospitalScreen(hospital: hospital),
              ),
            );
            if (updatedHospital != null) {
              close(context, updatedHospital);
            }
          },
        );
      },
    );
  }
}