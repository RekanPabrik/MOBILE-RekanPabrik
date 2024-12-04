import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rekanpabrik/shared/shared.dart';

class UploadCv extends StatefulWidget {
  const UploadCv({super.key});

  @override
  State<UploadCv> createState() => _UploadCvState();
}

class _UploadCvState extends State<UploadCv> {
  String? selectedFileName;
  bool isUploading = false;

  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          selectedFileName = result.files.single.name;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tidak ada file yang dipilih.")),
        );
      }
    } catch (e) {
      debugPrint("Error saat memilih file: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memilih file: $e")),
      );
    }
  }

  Future<void> uploadFile() async {
    if (selectedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pilih file terlebih dahulu!")),
      );
      return;
    }

    setState(() {
      isUploading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("CV berhasil diunggah!")),
      );
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengunggah file: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unggah CV"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Pilih file CV dalam format PDF:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: pickFile,
              icon: const Icon(Icons.upload_file),
              label: const Text("Pilih File"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
            const SizedBox(height: 16),
            if (selectedFileName != null)
              Text(
                "File dipilih: $selectedFileName",
                style: const TextStyle(fontSize: 16, color: Colors.green),
              ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: isUploading ? null : uploadFile,
              child: isUploading
                  ? CircularProgressIndicator(
                      color: thirdColor,
                    )
                  : const Text(
                      "Unggah CV",
                      style: TextStyle(color: Colors.white),
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: thirdColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
