import 'package:flutter/material.dart';
import 'package:booktique_mobile/models/product.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class EditProductPage extends StatefulWidget {
  final Product product;
  final Function? onProductUpdated;

  const EditProductPage({
    super.key, 
    required this.product,
    this.onProductUpdated,
  });

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _author;
  late String _description;
  late int _stock;
  late int _price;

  @override
  void initState() {
    super.initState();
    _name = widget.product.fields.name;
    _author = widget.product.fields.author;
    _description = widget.product.fields.description;
    _stock = widget.product.fields.stockQuantity;
    _price = widget.product.fields.price;
  }

  InputDecoration _buildDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Book'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: _buildDecoration('Book Name', 'Enter book name'),
                onChanged: (value) => _name = value,
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _author,
                decoration: _buildDecoration('Author', 'Enter author name'),
                onChanged: (value) => _author = value,
                validator: (value) => value!.isEmpty ? 'Please enter an author' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _description,
                decoration: _buildDecoration('Description', 'Enter description'),
                maxLines: 3,
                onChanged: (value) => _description = value,
                validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _stock.toString(),
                decoration: _buildDecoration('Stock', 'Enter stock quantity'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _stock = int.tryParse(value) ?? 0,
                validator: (value) => value!.isEmpty ? 'Please enter stock quantity' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _price.toString(),
                decoration: _buildDecoration('Price', 'Enter price'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _price = int.tryParse(value) ?? 0,
                validator: (value) => value!.isEmpty ? 'Please enter a price' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final response = await request.post(
                      'http://127.0.0.1:8000/edit-product-flutter/${widget.product.pk}/',
                      jsonEncode({
                        'name': _name,
                        'author': _author,
                        'description': _description,
                        'stock_quantity': _stock,
                        'price': _price,
                      }),
                    );

                    if (context.mounted) {
                      if (response['status'] == 'success') {
                        widget.onProductUpdated?.call();
                        Navigator.pop(context, true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Book updated successfully")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Failed to update book")),
                        );
                      }
                    }
                  }
                },
                child: const Text(
                  'Update Book',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}