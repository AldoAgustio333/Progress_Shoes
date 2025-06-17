import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // TextEditingController untuk setiap input
  final TextEditingController _nameController = TextEditingController(text: 'Nama Pengguna Contoh');
  final TextEditingController _emailController = TextEditingController(text: 'contoh@email.com');
  final TextEditingController _phoneController = TextEditingController(text: '081234567890');
  final TextEditingController _addressController = TextEditingController(text: 'Jl. Contoh No. 123, Kota Contoh, Kode Pos 12345');

  // Variabel untuk melacak mode edit
  bool _isEditing = false;

  @override
  void dispose() {
    // Pastikan controller dibuang saat widget dihapus untuk menghindari kebocoran memori
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Logika untuk "menyimpan" data (tanpa database)
        // Di sini Anda bisa memanggil API atau menyimpan ke lokal jika ada
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil berhasil diperbarui!')),
        );
        print('Data yang "disimpan":');
        print('Nama: ${_nameController.text}');
        print('Email: ${_emailController.text}');
        print('Telepon: ${_phoneController.text}');
        print('Alamat: ${_addressController.text}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'Profil Pengguna',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.save : Icons.edit,
              color: Colors.white,
            ),
            onPressed: _toggleEditMode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.orange.shade100,
                    backgroundImage: const AssetImage('assets/images/profile_placeholder.png'), // Ganti dengan gambar profil default
                    child: const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.orange,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // Aksi untuk mengubah gambar profil (jika diperlukan)
                        print('Ubah foto profil diklik!');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildProfileField(
              label: 'Nama Lengkap',
              controller: _nameController,
              enabled: _isEditing,
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            _buildProfileField(
              label: 'Email',
              controller: _emailController,
              enabled: _isEditing,
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            _buildProfileField(
              label: 'Nomor Telepon',
              controller: _phoneController,
              enabled: _isEditing,
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            _buildProfileField(
              label: 'Alamat Pengiriman',
              controller: _addressController,
              enabled: _isEditing,
              icon: Icons.location_on,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            // Tombol tambahan jika diperlukan (misal: Ganti Password, Logout)
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.grey),
              title: const Text('Ganti Password'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                print('Ganti Password diklik!');
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Keluar', style: TextStyle(color: Colors.red)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                print('Keluar diklik!');
                // Logika logout
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget pembantu untuk membangun setiap baris field profil
  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    required bool enabled,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.orange, width: 2),
            ),
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          style: TextStyle(
            color: enabled ? Colors.black : Colors.black54,
          ),
        ),
      ],
    );
  }
}