import 'package:flutter/material.dart';
import 'package:rekanpabrik/models/users/pelamar.dart';
import 'package:rekanpabrik/shared/shared.dart';

class TestAPI extends StatelessWidget {
  const TestAPI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('Daftar Pelamar'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: PelamarService().getAllPelamar(), // Memanggil API
          builder: (context, AsyncSnapshot<List<Pelamar>> snapshot) {
            // Jika data belum diambil, tampilkan loading spinner
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // Jika ada error, tampilkan pesan error
            else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            // Jika data berhasil diambil
            else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              // Tampilkan data pelamar dalam ListView
              List<Pelamar> pelamarList = snapshot.data!;
              return ListView.builder(
                itemCount: pelamarList.length,
                itemBuilder: (context, index) {
                  Pelamar pelamar = pelamarList[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: pelamar.profilePict != null
                            ? NetworkImage(pelamar.profilePict!)
                            : null,
                        child: pelamar.profilePict == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      title: Text('${pelamar.firstName} ${pelamar.lastName}'),
                      subtitle: Text(
                          'Email: ${pelamar.email}\nRole: ${pelamar.role}'),
                      onTap: () {
                        // Tambahkan aksi jika perlu
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Tidak ada data pelamar.'));
            }
          },
        ),
      ),
    );
  }
}
