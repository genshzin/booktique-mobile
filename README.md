# Booktique 🛍️

## Tugas 7

### Implementasi Checklist

1. **Membuat Program Flutter Baru**
   - Membuat proyek Flutter baru bernama `booktique_mobile` dengan perintah:
     ```bash
     flutter create booktique_mobile
     cd booktique_mobile
     ```
   - Membuat file baru `menu.dart` pada folder `lib`
   - Mengubah tema aplikasi pada `main.dart`:
     ```dart
     import 'package:flutter/material.dart';
     import 'package:booktique_mobile/menu.dart';

     void main() {
       runApp(const MyApp());
     }

     class MyApp extends StatelessWidget {
       const MyApp({super.key});

       @override
       Widget build(BuildContext context) {
         return MaterialApp(
           title: 'Booktique',
           theme: ThemeData(
             colorScheme: ColorScheme.fromSwatch(
               primarySwatch: Colors.indigo,
             ).copyWith(secondary: Colors.indigo[900]),
             useMaterial3: true,
           ),
           home: MyHomePage(),
         );
       }
     }
     ```

2. **Membuat 3 Tombol Sederhana**
   - Membuat class untuk menyimpan item menu pada `menu.dart`:
     ```dart
     class ItemHomepage {
       final String name;
       final IconData icon;

       ItemHomepage(this.name, this.icon);
     }
     ```
   - Membuat list item pada class `MyHomePage`:
     ```dart
     final List<ItemHomepage> items = [
       ItemHomepage("Lihat Daftar Produk", Icons.list),
       ItemHomepage("Tambah Produk", Icons.add),
       ItemHomepage("Logout", Icons.logout),
     ];
     ```
   - Mengimplementasikan tampilan grid pada `menu.dart`:
     ```dart
     GridView.count(
       primary: true,
       padding: const EdgeInsets.all(20),
       crossAxisSpacing: 10,
       mainAxisSpacing: 10,
       crossAxisCount: 3,
       shrinkWrap: true,
       children: items.map((ItemHomepage item) {
         return ItemCard(item);
       }).toList(),
     )
     ```

3. **Implementasi Warna Berbeda untuk Setiap Tombol**
   - Membuat fungsi untuk menentukan warna pada `ItemCard`:
     ```dart
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
     ```

4. **Implementasi Snackbar**
   - Menambahkan handler `onTap` pada `ItemCard`:
     ```dart
     InkWell(
       onTap: () {
         ScaffoldMessenger.of(context)
           ..hideCurrentSnackBar()
           ..showSnackBar(
             SnackBar(
               content: Text("Kamu telah menekan tombol ${item.name}!")
             ),
           );
       },
       child: Container(
         padding: const EdgeInsets.all(8),
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(
                 item.icon,
                 color: Colors.white,
                 size: 30.0,
               ),
               const Padding(padding: EdgeInsets.all(3)),
               Text(
                 item.name,
                 textAlign: TextAlign.center,
                 style: const TextStyle(color: Colors.white),
               ),
             ],
           ),
         ),
       ),
     )
     ```

### Pertanyaan

1. **Perbedaan Stateless dan Stateful Widget**
   
   **Stateless Widget:**
   - Widget yang statis/tidak berubah
   - Tidak memiliki internal state
   - Dibuat sekali dan tidak akan berubah selama aplikasi berjalan
   - Cocok untuk UI yang tidak perlu update, seperti teks, ikon, atau tombol sederhana
   
   **Stateful Widget:**
   - Widget yang dinamis/dapat berubah
   - Memiliki internal state yang dapat diperbarui
   - Dapat diperbarui ketika pengguna berinteraksi atau ketika menerima data
   - Cocok untuk UI yang memerlukan pembaruan, seperti form input atau animasi

2. **Widget yang Digunakan**
   - `MaterialApp`: Widget root yang menyediakan tema dan navigasi
   - `Scaffold`: Menyediakan struktur dasar layout material design
   - `AppBar`: Menampilkan bar aplikasi di bagian atas
   - `Column`: Mengatur widget secara vertikal
   - `Row`: Mengatur widget secara horizontal
   - `GridView`: Menampilkan widget dalam grid layout
   - `Card`: Menampilkan informasi dalam bentuk kartu
   - `Container`: Mengatur padding, margin, dan dekorasi
   - `InkWell`: Memberikan efek sentuhan dan handling onTap
   - `Icon`: Menampilkan ikon
   - `Text`: Menampilkan teks
   - `Padding`: Memberikan padding pada widget
   - `Center`: Mengatur widget ke tengah
   - `Material`: Memberikan efek visual material design

3. **Fungsi setState()**
   
   `setState()` adalah metode yang memberitahu framework bahwa internal state dari objek telah berubah dan mungkin mempengaruhi UI. Ketika `setState()` dipanggil, Flutter akan membangun ulang widget dan turunannya.
   
   Dalam proyek ini tidak menggunakan `setState()` karena hanya menggunakan stateless widget. Namun jika menggunakan stateful widget, variabel yang dapat terdampak adalah variabel yang didefinisikan sebagai state widget tersebut.

4. **Perbedaan const dengan final**
   
   **const:**
   - Variabel harus diinisialisasi pada saat kompilasi
   - Nilainya harus sudah diketahui sebelum runtime
   - Membuat objek menjadi deeply immutable
   - Contoh: `const pi = 3.14`
   
   **final:**
   - Variabel hanya bisa diset sekali
   - Nilainya bisa diinisialisasi saat runtime
   - Hanya membuat referensi immutable, bukan nilai objeknya
   - Contoh: `final currentTime = DateTime.now()`
