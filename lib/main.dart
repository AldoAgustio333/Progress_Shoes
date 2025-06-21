import 'package:flutter/material.dart';
import 'halaman_toko.dart';
import 'store_page.dart';
import 'search_page.dart';
import 'riwayat_page.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';
import 'models/history_model.dart';
import 'splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:carousel_slider/carousel_slider.dart';

// Local notifications plugin instance
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

// Background message handler (harus top level function)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();

    // Set background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Inisialisasi flutter_local_notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Request permission untuk iOS & Android 13+
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    // Dapatkan FCM token (untuk testing atau server)
    String? token = await messaging.getToken();
    print('FCM Token: $token');

    // Listen ketika notifikasi datang saat app aktif (foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'default_channel',
                'Default Channel',
                channelDescription: 'This channel is used for important notifications.',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
              ),
            ),
          );
        }
      }
    });

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartModel()),
          ChangeNotifierProvider(create: (_) => HistoryModel()),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e) {
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'Gagal menginisialisasi Firebase:\n$e',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const SearchPage(),
    const StorePage(),
    const RiwayatPage(),
    const Center(child: Text('Profile Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _selectedIndex == 2 ? Colors.orange : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.store,
                color: _selectedIndex == 2 ? Colors.white : Colors.grey,
                size: 30,
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final produkUtama = [
      'Tas Gunung Eiger',
      'Sepatu Hiking',
      'Jaket Waterproof',
      'Kacamata Polarized',
      'Kompas Digital',
    ];

    final produkRekomendasi = [
      'Carrier 45L',
      'Tenda Dome 2P',
      'Senter LED Tahan Air',
      'Sarung Tangan Outdoor',
      'Kaos Quick Dry',
    ];

    final bannerImages = [
      'assets/images/banner1.png',
      'assets/images/banner2.png',
      'assets/images/banner3.png',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SplashScreen()),
            );
          },
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HalamanToko()),
            );
          },
          child: const Text(
            'EIGER',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart diklik!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: bannerImages.map((imagePath) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            buildHorizontalProductList(context, produkUtama, isRekomendasi: false),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Rekomendasi produk untukmu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Lihat lainnya', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            buildHorizontalProductList(context, produkRekomendasi, isRekomendasi: true),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/banner2.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 160,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildHorizontalProductList(BuildContext context, List<String> produkList, {required bool isRekomendasi}) {
    return SizedBox(
      height: isRekomendasi ? 210 : 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: produkList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StorePage()),
              );
            },
            child: Container(
              width: 160,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: isRekomendasi ? Colors.white : Colors.orange,
                borderRadius: BorderRadius.circular(12),
                boxShadow: isRekomendasi
                    ? [const BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]
                    : [],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/${isRekomendasi ? 'popular' : 'product'}${index + 1}.png',
                          fit: BoxFit.contain,
                          height: 80,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      produkList[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isRekomendasi ? 10 : 12,
                        color: isRekomendasi ? Colors.black : Colors.white,
                      ),
                    ),
                    if (isRekomendasi) ...[
                      const SizedBox(height: 4),
                      const Text('Produk original berkualitas', style: TextStyle(fontSize: 8, color: Colors.grey)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Rp 150.000',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),


                      const SizedBox(height: 20),
                    ],
                  ],

                ),

              ),

            ),


          );
        },

      ),
    );

  }
}
