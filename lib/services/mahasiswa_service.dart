import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MahasiswaService {
  final DatabaseReference _database =
      FirebaseDatabase.instance.reference().child('mahasiswa_list');

  Stream<List<Map<dynamic, dynamic>>> getMahasiswaList() {
    return _database.onValue.map((event) {
      final List<Map<dynamic, dynamic>> items = [];
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          items.add({
            'nama': value['nama'] as String,
            'npm': value['npm'] as String,
          });
        });
      }
      return items;
    });
  }

  void addMahasiswaItem(
      String namaMahasiswa, String npmMahasiswa, BuildContext context) {
    if (namaMahasiswa.isEmpty || npmMahasiswa.isEmpty) {
      final warning = SnackBar(content: Text('Isian tidak lengkap!'));
      ScaffoldMessenger.of(context).showSnackBar(warning);
    } else {
      _database.push().set({'nama': namaMahasiswa, 'npm': npmMahasiswa});
    }
  }
}
