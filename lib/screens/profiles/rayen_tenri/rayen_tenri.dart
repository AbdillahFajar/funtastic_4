import 'package:flutter/material.dart';

class RayhandiTenri extends StatelessWidget {
  const RayhandiTenri({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi Warna (Color Grading)
    final gradientBackground = const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0F2027), // Deep Dark Blue
          Color(0xFF203A43), // Mid Teal
          Color(0xFF2C5364), // Lighter Blue-Grey
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rayhandi Tenri",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: gradientBackground,
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Avatar Section dengan Glow Effect
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.5),
                      blurRadius: 25,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white10,
                  backgroundImage: AssetImage('assets/images/Rayen.jpeg'),
                  // Ganti NetworkImage dengan AssetImage('assets/foto_anda.jpg') jika ada file lokal
                ),
              ),
              const SizedBox(height: 30),

              // 2. Nama & Identitas Utama
              Text(
                "Rayhandi Tenri",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
                ),
                child: const Text(
                  "NIM: 1123150121 | Kelas: TISE23P2",
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // 3. Card Keahlian (Glassmorphism Effect)
              _buildGlassCard(
                context,
                title: "Keahlian",
                icon: Icons.code,
                content: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildSkillChip("All Programming Languages"),
                    _buildSkillChip("Flutter Expert"),
                    _buildSkillChip("Fullstack Dev"),
                    _buildSkillChip("System Architecture"),
                    _buildSkillChip("AI Integration"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 4. Card Deskripsi
              _buildGlassCard(
                context,
                title: "Tentang Saya",
                icon: Icons.person_pin,
                content: const Text(
                  "Seorang pengembang perangkat lunak yang berdedikasi dengan kemampuan adaptasi tinggi di seluruh bahasa pemrograman. Fokus pada penciptaan solusi digital yang efisien, skalabel, dan estetis.",
                  style: TextStyle(color: Colors.white70, height: 1.5),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.orangeAccent),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white24, height: 20),
          content,
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.deepPurpleAccent.withOpacity(0.3),
      labelStyle: const TextStyle(color: Colors.white),
      side: BorderSide.none,
      elevation: 0,
    );
  }
}
