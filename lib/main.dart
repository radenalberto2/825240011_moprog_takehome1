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

  // Masuk Ke Bagian Constructornya
  Product({ //Fungsi dari ada { kurung kurawal di dalam ( kurung biasa adalah
    // untuk membuat label agar tidak hanya menjadi
    // angka dan teks acak seperti Product('Headphone', 350000)

    // Memakai required karena informasi penting yang pasti berbeda di tiap produknya
    required this.name,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    // tidak pakai required karena informasi yang tidak pasti berbeda di tiap produknya
    this.likes = 0,
    this.isLiked = false,
    this.isSelected = false,
    this.quantity = 1,
  });
}

void main() {
  runApp(const MyApp());
}

// Memakai StatelessWidget karena tugas MyApp hanya sebagai
// pembungkus luar/yang mengatur tema
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartPage(), //akan memanggil layar keranjang
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
      child: Text('Keranjang Belanja'),
      ),
    );
  }
}

