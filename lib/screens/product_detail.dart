import 'package:flutter/material.dart';
import 'package:booktique_mobile/models/product.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:booktique_mobile/screens/edit_product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final Function? onProductUpdated;

  const ProductDetailPage({
    super.key, 
    required this.product,
    this.onProductUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: SingleChildScrollView(  
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,  
                children: [
                  Text(
                    product.fields.name,
                    style: const TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,  
                  ),
                  const SizedBox(height: 16),
                  DetailRow(
                    icon: Icons.person, 
                    text: "${product.fields.author}"
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  DetailRow(
                    icon: Icons.description, 
                    text: "${product.fields.description}",
                    isMultiLine: true,  
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  DetailRow(
                    icon: Icons.attach_money, 
                    text: "${product.fields.price}"
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  DetailRow(
                    icon: Icons.inventory, 
                    text: "${product.fields.stockQuantity}"
                  ),
                  const SizedBox(height: 24), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.edit),
                        label: const Text("Edit"),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProductPage(
                                product: product,
                                onProductUpdated: onProductUpdated,
                              ),
                            ),
                          );
                          
                          if (result == true) {
                            onProductUpdated?.call();
                            Navigator.pop(context, true);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.delete),
                        label: const Text("Delete"),
                        onPressed: () async {
                          bool confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Confirm Delete"),
                              content: const Text("Are you sure you want to delete this book?"),
                              actions: [
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () => Navigator.pop(context, false),
                                ),
                                TextButton(
                                  child: const Text("Delete"),
                                  onPressed: () => Navigator.pop(context, true),
                                ),
                              ],
                            ),
                          ) ?? false;

                          if (confirm && context.mounted) {
                            final response = await request.get(
                              'http://127.0.0.1:8000/delete-product-flutter/${product.pk}/',
                            );

                            if (context.mounted) {
                              if (response['status'] == 'success') {
                                onProductUpdated?.call();
                                Navigator.pop(context, true);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Book deleted successfully")
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Failed to delete book")
                                  ),
                                );
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isMultiLine;  

  const DetailRow({
    super.key, 
    required this.icon, 
    required this.text,
    this.isMultiLine = false,  
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,  
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.visible, 
            softWrap: true,
            maxLines: isMultiLine ? null : 2,  
          ),
        ),
      ],
    );
  }
}