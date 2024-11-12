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

## Tugas 8

### Implementasi

Pada tugas 8, saya telah mengimplementasikan *navigation*, *layout*, *form*, dan *form input elements* pada aplikasi Flutter yang saya buat pada tugas sebelumnya. Berikut adalah rincian implementasinya.

1. **Membuat Halaman Formulir Tambah Item Baru**
   - Saya telah membuat halaman baru bernama `ItemEntryFormPage` yang diakses melalui tombol "Tambah Produk" pada halaman utama.
   - Halaman ini memiliki tiga elemen input, yaitu `name`, `author`, dan `description`. Saya juga menambahkan elemen input untuk `stock` dan `price` sesuai dengan model pada aplikasi tugas Django.
   - Semua elemen input pada formulir ini telah divalidasi agar tidak boleh kosong dan harus berisi data dengan tipe yang sesuai.
   - Terdapat sebuah tombol "Save" yang akan memunculkan sebuah dialog untuk menampilkan data yang diisi pada formulir.
   ```dart
   import 'package:flutter/material.dart';
   import 'package:booktique_mobile/widgets/left_drawer.dart';
   
   // StatefulWidget for book entry form
   class ItemEntryFormPage extends StatefulWidget {
     const ItemEntryFormPage({super.key});
   
     @override
     State<ItemEntryFormPage> createState() => _ItemEntryFormPageState();
   }
   
   class _ItemEntryFormPageState extends State<ItemEntryFormPage> {
     // Form key untuk validasi form
     final _formKey = GlobalKey<FormState>();
     
     // State variables untuk menyimpan data buku
     String _name = '';
     String _author = '';
     String _description = '';
     int _stock = 0;
     int _price = 0;
   
     // Helper method untuk membuat InputDecoration
     InputDecoration _buildDecoration(String label, String hint) {
       return InputDecoration(
         hintText: hint,
         labelText: label,
         filled: true,
         fillColor: Colors.white,
         // Styling normal state border
         enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(12.0),
           borderSide: BorderSide(
             color: Colors.grey.shade400,
             width: 1.0,
           ),
         ),
         // Styling focused state border
         focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(12.0),
           borderSide: BorderSide(
             color: Theme.of(context).colorScheme.primary,
             width: 2.0,
           ),
         ),
         // Styling error state border
         errorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(12.0),
           borderSide: const BorderSide(
             color: Colors.red,
             width: 1.0,
           ),
         ),
         // Styling focused error state border
         focusedErrorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(12.0),
           borderSide: const BorderSide(
             color: Colors.red,
             width: 2.0,
           ),
         ),
         contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
       );
     }
   
     @override
     Widget build(BuildContext context) {
       return Scaffold(
         // App bar configuration
         appBar: AppBar(
           title: const Center(
             child: Text(
               'Form Tambah Buku',
             ),
           ),
           backgroundColor: Theme.of(context).colorScheme.primary,
           foregroundColor: Colors.white,
         ),
         drawer: const LeftDrawer(),
         // Main form body
         body: Form(
           key: _formKey,
           child: SingleChildScrollView(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 // Nama buku input field
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextFormField(
                     decoration: _buildDecoration("Nama Buku", "Nama Buku"),
                     onChanged: (String? value) {
                       setState(() {
                         _name = value!;
                       });
                     },
                     // Validasi untuk nama buku
                     validator: (String? value) {
                       if (value == null || value.isEmpty) {
                         return "Nama buku tidak boleh kosong!";
                       }
                       return null;
                     },
                   ),
                 ),
                 // Author input field
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextFormField(
                     decoration: _buildDecoration("Penulis", "Penulis"),
                     onChanged: (String? value) {
                       setState(() {
                         _author = value!;
                       });
                     },
                     // Validasi untuk nama author
                     validator: (String? value) {
                       if (value == null || value.isEmpty) {
                         return "Nama penulis tidak boleh kosong!";
                       }
                       return null;
                     },
                   ),
                 ),
                 // Description input field
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextFormField(
                     decoration: _buildDecoration("Deskripsi", "Deskripsi"),
                     maxLines: 3,
                     onChanged: (String? value) {
                       setState(() {
                         _description = value!;
                       });
                     },
                     // Validasi untuk description
                     validator: (String? value) {
                       if (value == null || value.isEmpty) {
                         return "Deskripsi tidak boleh kosong!";
                       }
                       return null;
                     },
                   ),
                 ),
                 // Stock input field
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextFormField(
                     decoration: _buildDecoration("Stok", "Stok"),
                     keyboardType: TextInputType.number,
                     onChanged: (String? value) {
                       setState(() {
                         _stock = int.tryParse(value!) ?? 0;
                       });
                     },
                     // Validation untuk stock
                     validator: (String? value) {
                       if (value == null || value.isEmpty) {
                         return "Stok tidak boleh kosong!";
                       }
                       if (int.tryParse(value) == null) {
                         return "Stok harus berupa angka!";
                       }
                       return null;
                     },
                   ),
                 ),
                 // Harga input field
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextFormField(
                     decoration: _buildDecoration("Harga", "Harga"),
                     keyboardType: TextInputType.number,
                     onChanged: (String? value) {
                       setState(() {
                         _price = int.tryParse(value!) ?? 0;
                       });
                     },
                     // Validas untuk Buku
                     validator: (String? value) {
                       if (value == null || value.isEmpty) {
                         return "Harga tidak boleh kosong!";
                       }
                       if (int.tryParse(value) == null) {
                         return "Harga harus berupa angka!";
                       }
                       return null;
                     },
                   ),
                 ),
                 // Save button
                 Align(
                   alignment: Alignment.bottomCenter,
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: ElevatedButton(
                       style: ButtonStyle(
                         backgroundColor: WidgetStateProperty.all(
                             Theme.of(context).colorScheme.primary),
                       ),
                       onPressed: () {
                         // Validasi form sebelum menampilkan dialog
                         if (_formKey.currentState!.validate()) {
                           // Menampilkan dialog
                           showDialog(
                             context: context,
                             builder: (context) {
                               // Success dialog 
                               return AlertDialog(
                                 title: const Text('Buku berhasil tersimpan'),
                                 content: SingleChildScrollView(
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text('Nama: $_name'),
                                       Text('Penulis: $_author'),
                                       Text('Deskripsi: $_description'),
                                       Text('Stok: $_stock'),
                                       Text('Harga: $_price'),
                                     ],
                                   ),
                                 ),
                                 actions: [
                                   TextButton(
                                     child: const Text('OK'),
                                     onPressed: () {
                                       Navigator.pop(context);
                                       _formKey.currentState!.reset();
                                     },
                                   ),
                                 ],
                               );
                             },
                           );
                         }
                       },
                       child: const Text(
                         "Save",
                         style: TextStyle(color: Colors.white),
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           ),
         ),
       );
     }
   }
   ```

2. **Navigasi Menuju Halaman Formulir Tambah Item Baru**
   - Ketika pengguna menekan tombol "Tambah Produk" pada halaman utama, aplikasi akan mengarahkan pengguna ke halaman formulir tambah item baru (`ItemEntryFormPage`).
     
   ```dart
   class MyHomePage extends StatelessWidget {
     // ... (deklarasi data pengguna)

     final List<ItemHomepage> items = [
       ItemHomepage("Lihat Daftar Produk", Icons.list),
       ItemHomepage("Tambah Produk", Icons.add),
       ItemHomepage("Logout", Icons.logout),
     ];

     @override
     Widget build(BuildContext context) {
       return Scaffold(
         // ... (deklarasi AppBar)
         drawer: const LeftDrawer(),
         body: Padding(
           // ... (deklarasi konten lain)
           GridView.count(
             // ... (deklarasi grid menu)
             children: items.map((ItemHomepage item) {
               return ItemCard(item);
             }).toList(),
           ),
         ),
       );
     }
   }
   ```
   Kode `ItemCard` yang digunakan untuk menampilkan menu dan mengarahkan ke `ItemEntryFormPage`

   ```dart
   class ItemCard extends StatelessWidget {
     final ItemHomepage item;

     const ItemCard(this.item, {super.key});

     @override
     Widget build(BuildContext context) {
       return Material(
         // ... (deklarasi tampilan kartu)
         child: InkWell(
           onTap: () {
             if (item.name == "Tambah Produk") {
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => const ItemEntryFormPage(),
                 ),
               );
             }
           },
           // ... (deklarasi konten kartu)
         ),
       );
     }
   }
   ```
3. **Pembuatan Drawer**
   - Saya telah membuat sebuah drawer bernama `LeftDrawer` yang dapat diakses dari setiap halaman pada aplikasi.
   - Drawer ini memiliki dua opsi, yaitu "Halaman Utama" dan "Tambah Item".
   - Ketika pengguna memilih opsi "Halaman Utama", aplikasi akan mengarahkan pengguna kembali ke halaman utama (`MyHomePage`).
   - Ketika pengguna memilih opsi "Tambah Item", aplikasi akan mengarahkan pengguna ke halaman formulir tambah item baru (`ItemEntryFormPage`).


   ```dart
   class LeftDrawer extends StatelessWidget {
     const LeftDrawer({super.key});

     @override
     Widget build(BuildContext context) {
       return Drawer(
         child: ListView(
           children: [
             // Deklarasi header drawer
             DrawerHeader(
               // ... (deklarasi tampilan header)
             ),
             // Opsi "Halaman Utama"
             ListTile(
               leading: const Icon(Icons.home_outlined),
               title: const Text('Halaman Utama'),
               onTap: () {
                 Navigator.pushReplacement(
                   context,
                   MaterialPageRoute(
                     builder: (context) => MyHomePage(),
                   ),
                 );
               },
             ),
             // Opsi "Tambah Item"
             ListTile(
               leading: const Icon(Icons.book),
               title: const Text('Tambah Item'),
               onTap: () {
                 Navigator.pushReplacement(
                   context,
                   MaterialPageRoute(
                     builder: (context) => ItemEntryFormPage(),
                   ),
                 );
               },
             ),
           ],
         ),
       );
     }
   }
   ```
   
4. **Struktur dan Refactoring**
   - Saya telah melakukan refactoring pada struktur aplikasi dengan memisahkan komponen-komponen ke dalam file yang berbeda, seperti:
     folder *`widgets`*:
     - `item_card.dart`: Menyimpan kode untuk widget `ItemCard`.
     - `left_drawer.dart`: Menyimpan kode untuk widget `LeftDrawer`.
     folder *`screens`*:
     - `itementry_form.dart`: Menyimpan kode untuk halaman `ItemEntryFormPage`.
     - `menu.dart`: Menyimpan kode untuk halaman utama `MyHomePage`.

### Pertanyaan

1. **Apa kegunaan `const` di Flutter? Jelaskan apa keuntungan ketika menggunakan `const` pada kode Flutter. Kapan sebaiknya kita menggunakan `const`, dan kapan sebaiknya tidak digunakan?**

   - `const` di Flutter digunakan untuk membuat nilai konstan yang tidak dapat diubah selama runtime aplikasi. Penggunaan `const` memberikan beberapa keuntungan, antara lain:
     - **Efisiensi Memori** --> Nilai konstan yang dibuat dengan `const` akan disimpan hanya sekali di memori, sehingga dapat meningkatkan efisiensi penggunaan memori.
     - **Performa** --> Penggunaan `const` dapat meningkatkan performa aplikasi karena nilai konstan dapat dievaluasi pada saat kompilasi, mengurangi beban komputasi pada saat runtime.
     - **Keamanan** --> Nilai konstan yang dibuat dengan `const` tidak dapat diubah, sehingga dapat membantu mencegah kesalahan dalam penggunaan nilai tersebut.

   - Sebaiknya menggunakan `const` untuk:
     - Nilai yang tidak akan berubah selama aplikasi berjalan.
     - Variabel atau objek yang digunakan secara luas dalam aplikasi.
     - Nilai yang digunakan untuk inisialisasi awal suatu objek.

   - Sebaiknya tidak menggunakan `const` untuk:
     - Nilai yang dapat berubah selama aplikasi berjalan.
     - Nilai yang hanya digunakan dalam konteks tertentu dan tidak digunakan secara luas.

2. **Jelaskan dan bandingkan penggunaan *Column* dan *Row* pada Flutter. Berikan contoh implementasi dari masing-masing layout widget ini!**

   - `Column`: Widget ini digunakan untuk menyusun anak-anak widget secara vertikal. Anak-anak widget akan ditampilkan satu di atas yang lain.
   - `Row`: Widget ini digunakan untuk menyusun anak-anak widget secara horizontal. Anak-anak widget akan ditampilkan satu di samping yang lain.

   Contoh implementasi `Column`:
   ```dart
   Column(
     children: [
       Text('Baris 1'),
       Text('Baris 2'),
       Text('Baris 3'),
     ],
   )
   ```

   Contoh implementasi `Row`:
   ```dart
   Row(
     children: [
       Text('Kolom 1'),
       Text('Kolom 2'),
       Text('Kolom 3'),
     ],
   )
   ```

   Perbedaan utama antara `Column` dan `Row` adalah arah penyusunan anak-anak widget. `Column` menyusun secara vertikal, sedangkan `Row` menyusun secara horizontal. Pemilihan antara `Column` atau `Row` bergantung pada kebutuhan tampilan aplikasi yang ingin dicapai.

3. **Sebutkan apa saja elemen input yang kamu gunakan pada halaman *form* yang kamu buat pada tugas kali ini. Apakah terdapat elemen input Flutter lain yang tidak kamu gunakan pada tugas ini? Jelaskan!**

   - Elemen input yang saya gunakan pada halaman formulir tambah item baru (`ItemEntryFormPage`) adalah:
     - `TextFormField`: Digunakan untuk input `name`, `author`, `description`.
     - `TextFormField` dengan `keyboardType: TextInputType.number`: Digunakan untuk input `stock` dan `price`.

   - Selain elemen input yang saya gunakan, terdapat beberapa elemen input lain pada Flutter, antara lain:
     - `Checkbox`: Untuk input checkbox.
     - `Radio`: Untuk input radio button.
     - `Slider`: Untuk input slider.
     - `Switch`: Untuk input switch.
     - `DropdownButton`: Untuk input dropdown.

   - Pada tugas kali ini, saya tidak menggunakan elemen input lain selain `TextFormField` karena kebutuhan aplikasi hanya memerlukan input teks biasa, angka, dan tidak membutuhkan input checkbox, radio button, slider, switch, atau dropdown.

4. **Bagaimana cara kamu mengatur tema (theme) dalam aplikasi Flutter agar aplikasi yang dibuat konsisten? Apakah kamu mengimplementasikan tema pada aplikasi yang kamu buat?**
   Untuk mengatur tema dalam aplikasi Flutter, saya menggunakan `ThemeData` yang disediakan oleh Flutter. Saya mengatur tema aplikasi pada `MaterialApp` yang menjadi root widget aplikasi. Pada aplikasi yang saya buat, saya telah mengimplementasikan tema dengan mengatur `colorScheme`, yaitu mengatur warna-warna utama aplikasi, seperti `primary` dan `secondary`. Saya sudah mengimplementasikan ini pada BG AppBar, button style pada form page, dan DrawerHeader.
     

6. **Bagaimana cara kamu menangani navigasi dalam aplikasi dengan banyak halaman pada Flutter?**

   - Dalam aplikasi saya, saya menggunakan `Navigator` dan `MaterialPageRoute` untuk menangani navigasi antar halaman.

   - Ketika pengguna menekan tombol "Tambah Produk" pada halaman utama, saya menggunakan `Navigator.push()` untuk mengarahkan pengguna ke halaman formulir tambah item baru (`ItemEntryFormPage`).

   - Saat pengguna memilih opsi "Halaman Utama" atau "Tambah Item" pada drawer, saya menggunakan `Navigator.pushReplacement()` untuk mengganti halaman saat ini dengan halaman yang baru dipilih.
