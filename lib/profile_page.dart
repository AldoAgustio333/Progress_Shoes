import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'Profil Toko',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Logo Toko
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.orange.shade100,
              backgroundImage: const AssetImage('assets/images/eiger_logo_full.png'), 
            ),
            const SizedBox(height: 16),
            const Text(
              'EIGER Footwear Store',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your Adventure Partner',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            
            _buildInfoTile(
              icon: Icons.store,
              title: 'Tentang Kami',
              subtitle: 'Menyediakan perlengkapan outdoor dan alas kaki berkualitas sejak 1989.',
            ),
            _buildInfoTile(
              icon: Icons.location_on,
              title: 'Alamat Toko',
              subtitle: 'Jl. Merdeka No. 123, Bandung, Jawa Barat, Indonesia',
            ),
            _buildInfoTile(
              icon: Icons.phone,
              title: 'Hubungi Kami',
              subtitle: '+62 812 3456 7890',
            ),
            _buildInfoTile(
              icon: Icons.email,
              title: 'Email',
              subtitle: 'support@eigeradventure.com',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({required IconData icon, required String title, required String subtitle}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}