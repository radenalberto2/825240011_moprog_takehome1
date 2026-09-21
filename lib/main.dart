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
  Product({ //Fungsi dari ada { kurung kurawal di dalam ( kurung biasa adalah untuk membuat label agar tidak hanya menjadi angka dan teks acak seperti Product('Headphone', 350000)

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
// Variabel untuk mencatat menu navigasi bawah yang sedang aktif (0: Beranda, 1: Kategori, 2: Keranjang, 3: Akun)
int currentNavIndex = 2; // Default bernilai 2 karena kita sedang di halaman Keranjang

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

  // 1. Rumus untuk menghitung total jumlah semua barang
  int get totalItems {
    int total = 0;
    for (var item in products) {
      total += item.quantity;
    }
    return total;
  }

  // 2. Rumus ketika menghitung total biaya (harga x jumlah beli)
  int get totalPrice {
    int total = 0;
    for (var item in products) {
      total += (item.price * item.quantity);
    }
    return total;
  }

  // 3. Fungsi untuk mengubah angka yang polos menjadi format rupiah dengan titik
  String formatRupiah(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
    );
  }

  // Membuat BannerNotifikasi yang ketika produk ditekan akan menghasilkan notifikasi
  Widget _buildBannerNotification() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329), // warna hitam/abu-abu gelap
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // bayangan terlihat lebih pekat agar efek melayang
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // untuk icon centang hijau
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 26,
          ),
          const SizedBox(width: 12),

          // untuk teks notifikasi (bagian judul & subtitle nya)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Produk dipilih!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  bannerMessage,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          // tombol Silang nya (X)
          GestureDetector(
            onTap: () {
              setState(() {
                bannerMessage = ''; // Menutup banner
              });
            },
            child: const Icon(
              Icons.close,
              color: Colors.white54,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  // Widget Header AppBar
  Widget _buildHeader() {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            const Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'My Cart',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Belanja lebih mudah setiap hari',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      // Interaksi 1: Tap (Pilih Produk / Border Biru)
      onTap: () {
        setState(() {
          product.isSelected = !product.isSelected;
        });
      },

      // Interaksi 2: Double Tap (Tambah Like & Hati Merah)
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

      // Interaksi 3: Long Press (Tampilkan Notifikasi)
      onLongPress: () {
        setState(() {
          bannerMessage = '${product.name} telah dipilih.';
        });
      },

      //Masuk ke dalam bagian container child untuk kartu
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), //Memberi Jarak Ho-16px di pinggir kiri dan kanan agar kartu tidak mentok dan Ve-8px untuk atas dan bawah
        padding: const EdgeInsets.all(12), //memberi ruang kosong 12px di bagian dalam kotak (agar tulisan dan foto tidak nempel pas di garis dinding kotak
        decoration: BoxDecoration( // gunanya untuk "Menghias kotak (warna latar, lengkungan sudut, garis tepi, atau bayangan)
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // melengkungkan 4 sudut kotak sebesar 12 pixel semakin besar angkanya semakin bulat sudut kotaknya
          border: Border.all( // memberikan garis bingkai
            color: product.isSelected ? Colors.blue : Colors.grey.shade200, // kondisi ? jika_benar(Colors.blue) : jika_salah(Colors.grey.shade200)
            width: product.isSelected ? 2 : 1, // jadi kalau produk nya sedang dipilih akan ditebalkan jadi 2px kalau tidak menjadi samar 1px
          ),
          boxShadow: [ //memberikan efek bayangan halus di belakang kotak
            BoxShadow(
              color: Colors.black.withOpacity(0.05), //warna bayangan nya hitam dengan kepekatan sebesar 5% agar terlihat lembut dan alami
              blurRadius: 5, // tingkat keburaman sebesar 5pixel
              offset: const Offset(0, 2), // untuk mengatur posisi bayangan jatuh (2pixel ke arah bawah) seolah2 ada cahaya dari atas
            ),
          ],
        ),
        child: Row(
          children: [

            // Sekarang dibawah sini akan menempatkan FOTO PRODUK (yang disebelah kiri letaknya)
            ClipRRect( // Singkatan dari Clip Rounded Rectangle untuk menggunting gambar yg kita upload itu
              borderRadius: BorderRadius.circular(8), //menjadi 8 pixel sehingga serasi dengan lengkungan kartu luarnya
              child: Image.network( // mengambil atau menampilkan gambar langsung dari URL internet yang
                product.imageUrl, // tersimpan di variabel product.imageUrl
                width: 80, // mengunci lebar foto sebesar 80pixel
                height: 80, // mengunci tinggi foto sebesar 80pixel
                fit: BoxFit.cover, //kamera zoom otomatis tanpa membuat gambarnya gepeng/ketarik lebar
                // Menangani Gambar jika gagal dimuat
                errorBuilder: (context, error, stackTrace){
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

            // Spasi Pemisah Horizontal (antara foto kiri dan text kanan)
            const SizedBox(width: 12),

            // Masuk ke bagian Informasi Detail Produk di sebelah kanan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // memaksa seluruh teks (Nama,Subtitle,dan harga) sejajar lurus rata kiri
                children: [
                  // A. Nama Produk
                  Text(
                    product.name, // menampilkan nama barang
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold, // dengan font tebal ukuran 15
                    ),
                  ),
                  const SizedBox(height: 2),

                  // B. Subtitle Merek
                  Text(
                    product.subtitle, // menampilkan merk
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600, //dengan warna abu-abu agak gelap
                    ),
                  ),
                  const SizedBox(height: 6),

                  // C. Harga Produk (Tampilan Visual saja tapi angka masi polos misal 350000) maka dari itu ada fungsi formatRupiah
                  Text(
                    'Rp ${product.price}', // menggabungkan simbol Rp(Rupiah) dengan angka harga dari objek produk
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // dan diberi warna biru tebal
                    ),
                  ),
                  const SizedBox(height: 8),

                  // D. Baris Bawah: Like di kiri & Tombol Counter di kanan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // untuk mendorong ikon hati ke ujung pojok kiri dan tombol coutner - 1 + itu ke pojok kanan
                    children: [
                      // 1. Bagian Ikon Hati & Angka Like
                      Row(
                        children: [
                          Icon( // untuk interaksi Double Tap
                            product.isLiked ? Icons.favorite : Icons.favorite_border, // Jika true gunakan gambar hati penuh | jika false akan hati tidak berwarna (garis tepi aja)
                            color: product.isLiked ? Colors.red : Colors.grey, // dan akan menampillam warna merah | dan warna abu-abu
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

                      // 2. Bagian Tombol Counter (- 1 +)
                      Row(
                        children: [
                          // Tombol Kurang (-)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (product.quantity > 1) {
                                  product.quantity--; // kuantitas barang dikurangi 1 tapi batas minimal tidak boleh 0 atau (-) minus
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

                          // Angka Jumlah Beli
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

                          // Tombol Tambah (+)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                product.quantity++; //setiap kali tombol (+) di-tap jumlah kuantitas akan bertambah 1
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

  // Widget Helper untuk BAR Checkout total di bagian bawah
  Widget _buildBottomCheckoutBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, -3), // Bayangan jatuh ke arah atas
          ),
        ],
      ),
      child: SafeArea(
        top: false, // Menjaga agar tidak tertutup tombol navigasi sistem HP
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // 1. Informasi Total belanjaan di keranjang
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total ($totalItems produk)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Rp ${formatRupiah(totalPrice)}', // bagian Rp untuk produk di bagian bawah
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // 2. Tombol Checkout
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentNavIndex,
      onTap: (index) {
        setState(() {
          currentNavIndex = index; // Mengubah menu yang aktif saat diklik
        });
      },
      type: BottomNavigationBarType.fixed, // untuk menjaga 4 tombol tetap sejajar tidak bergeser
      selectedItemColor: Colors.blue,      // Warna menu aktif adalah biru
      unselectedItemColor: Colors.grey,    // Warna menu tidak aktif adalah abu-abu
      selectedFontSize: 11,
      unselectedFontSize: 11,
      items: [
        // Menu 1: Beranda
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Beranda',
        ),

        // Menu 2: Kategori
        const BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_outlined),
          activeIcon: Icon(Icons.grid_view),
          label: 'Kategori',
        ),

        // Menu 3: Keranjang (Lengkap dengan Lingkaran Merah / Badge)
        BottomNavigationBarItem(
          icon: Badge(
            label: Text('$totalItems'), // Angka dinamis dari rumus totalItems
            backgroundColor: Colors.red,
            child: const Icon(Icons.shopping_cart_outlined),
          ),
          activeIcon: Badge(
            label: Text('$totalItems'),
            backgroundColor: Colors.red,
            child: const Icon(Icons.shopping_cart),
          ),
          label: 'Keranjang',
        ),

        // Menu 4: Akun
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Akun',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      // Masuk ke bagian badan layar (Menampilkan 3 Kartu Belanja)
      body: Stack(
        children: [

          // Layer 1 bagian bawah: Header + Daftar + Checkout
          Column(
            children: [
              // 1. Header Biru "My Cart"
              _buildHeader(),

              // 2. Daftar 3 Produk Belanja
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: products.map((product) {
                    return _buildProductCard(product);
                  }).toList(),
                ),
              ),

              // 3. Bar Total & Tombol Checkout
              _buildBottomCheckoutBar(),
            ],
          ),

          // Banner Notifikasi yang Melayang ketika di Long Press
          if (bannerMessage.isNotEmpty)
            Positioned(
              top: 21,
              left: 16,
              right: 16,
              child: SafeArea(
                bottom: false,
                child: _buildBannerNotification(),
              ),
            ),
        ],
      ),

      // Bilah Navigasi paling bawah
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}