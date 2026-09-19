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

//sifat kaku dan tidak bisa diubah yang dimana tidak boleh menyimpan variabel yg berubah-ubah
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  //jembatan penghubung antara class CartPage dan _CartPageState
  @override
  State<CartPage> createState() => _CartPageState();
}

//sifat nya bisa berubah kapan aja dan menjadi otak dan brankas data aplikasi
class _CartPageState extends State<CartPage> {
  String bannerMessage = ''; //digunakan untuk menyimpan notif saat produk di Long-Press

      List<Product> products = [ //untuk menampung banyak item sekaligus
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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
      child: Text('Keranjang Belanja'),
      ),
    );
  }
}

@override
  Widget build(BuildContext context) {
  return Scaffold(
    // Membuat Header Atas (AppBar)
    appBar: AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      title: Row( // Row dipakai disini untuk menaruh icon keranjang(kiri) yang berdampingan dengan tulisan(kanan) 'MyCart cart dan belanja lebih mudah setiap hari'
        children: [ // bagian judul utama di AppBar
          const Icon(
            Icons.shopping_cart,
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const[
              Text(
                'MyCart',
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

    // Masuk ke bagian badan layar
    body: const Center(
      child: Text('Daftar Text Akan Muncul Disini'),
      ),
  );
}

