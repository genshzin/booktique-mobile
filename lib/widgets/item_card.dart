import 'package:flutter/material.dart';
import 'package:booktique_mobile/screens/itementry_form.dart';

// Kelas untuk menyimpan data item menu
class ItemHomepage {
  final String name;
  final IconData icon;

  ItemHomepage(this.name, this.icon);
}

// Widget untuk menampilkan kartu menu
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  // Fungsi untuk menentukan warna background kartu berdasarkan jenis menu
  Color _getColorForItem(BuildContext context) {
    switch (item.name) {
      case "Lihat Daftar Produk":
        return Colors.black;
      case "Tambah Produk":
        return Colors.teal.shade900;
      case "Logout":
        return Colors.red.shade900;
      default:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _getColorForItem(context),
      borderRadius: BorderRadius.circular(12),
      // Menambahkan efek sentuhan pada kartu
      child: InkWell(
        onTap: () {
          // Menampilkan snackbar saat kartu ditekan
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!")),
            );
          if (item.name == "Tambah Produk") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ItemEntryFormPage(),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ikon menu
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                // Teks menu
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}