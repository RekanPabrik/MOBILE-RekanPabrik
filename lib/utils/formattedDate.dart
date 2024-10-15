import 'package:intl/intl.dart'; // Import intl package

// Fungsi untuk format tanggal
String formatTanggal(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date); // Format tanggal sesuai kebutuhan
}
