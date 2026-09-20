import 'package:flutter/material.dart';

class Product {
  final String name;
  final String subtitle;
  final int price;
  final String imageUrl;
  int likes;
  bool isLiked;
  bool isSelected;
  int quantity;

  Product({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    this.likes = 0,
    this.isLiked = false,
    this.isSelected = false,
    this.quantity = 1,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartPage(),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String bannerMessage = '';

  List<Product> products = [
    Product(
      name: 'Wireless Headphone',
      subtitle: 'Sony WH-CH520',
      price: 350000,
      imageUrl: 'https://i.imgur.com/nNik8C5.jpeg',
      likes: 12,
    ),
    Product(
      name: 'Laptop ASUS Vivobook',
      subtitle: 'ASUS',
      price: 7500000,
      imageUrl: 'https://i.imgur.com/QtyesPv.jpeg',
      likes: 8,
    ),
    Product(
      name: 'Wireless Mouse',
      subtitle: 'Logitech M330',
      price: 250000,
      imageUrl: 'https://i.imgur.com/qLei2RD.jpeg',
      likes: 5,
    ),
  ];

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      // Interaksi 1: Tap
      onTap: () {
        setState(() {
          product.isSelected = !product.isSelected;
        });
      },

      // Interaksi 2: Double Tap
      onDoubleTap: () {
        setState(() {
          product.isLiked = !product.isLiked;
          if (product.isLiked) {
            product.likes++;
          } else {
            product.likes--;
          }
        });
      },

      // Interaksi 3: Long Press
      onLongPress: () {
        setState(() {
          bannerMessage = 'Produk dipilih!\n${product.name} telah dipilih.';
        });
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: product.isSelected ? Colors.blue : Colors.grey.shade200,
            width: product.isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Foto Produk
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            // Informasi Detail Produk
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),

                  Text(
                    product.subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Text(
                    'Rp ${product.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Bagian Like
                      Row(
                        children: [
                          Icon(
                            product.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: product.isLiked ? Colors.red : Colors.grey,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${product.likes}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      // Bagian Counter
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (product.quantity > 1) {
                                  product.quantity--;
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '${product.quantity}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                product.quantity++;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                '+',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Row(
          children: [
            const Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'My Cart',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Belanja lebih mudah setiap hari',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: products.map((product) {
          return _buildProductCard(product);
        }).toList(),
      ),
    );
  }
}