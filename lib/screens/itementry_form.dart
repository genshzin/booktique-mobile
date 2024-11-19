import 'package:flutter/material.dart';
import 'package:booktique_mobile/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:booktique_mobile/screens/menu.dart';

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
    final request = context.watch<CookieRequest>();
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Kirim ke Django dan tunggu respons
                        // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                        final response = await request.postJson(
                          "http://127.0.0.1:8000/create-flutter/",
                          jsonEncode(<String, String>{
                            'name': _name,
                            'author': _author,
                            'description': _description,
                            'stock_quantity': _stock.toString(),
                            'price': _price.toString(),
                          }),
                        );
                        if (context.mounted) {
                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Buku baru berhasil disimpan!"),
                            ));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text("Terdapat kesalahan, silakan coba lagi."),
                            ));
                          }
                        }
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