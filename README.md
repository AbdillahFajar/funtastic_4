# Funtastic Note App - Flutter Application

<div align="center">
  <img src="https://github.com/user-attachments/assets/24ff1705-2151-4efa-87b3-9ab09a40c8af" alt="Logo Global" width="200"/>
  <br/>
  <p>Institut Teknologi dan Bisnis Bina Sarana Global</p>
</div>
<div align="center">
FAKULTAS TEKNOLOGI INFORMASI & KOMUNIKASI 
<br>
https://global.ac.id/
  </div>

  ##  Project UAS
  - Mata Kuliah : Aplikasi Mobile
  - Kelas : KS1234 
  - Semester : GANJIL 
  - Tahun Akademik: 2025 - 2026 
  
  

## About The Project

Funtastic Note adalah aplikasi catatan sederhana yang dibuat khusus untuk mencatat dengan cara kerja yang mudah, ringan dan bermanfaat. Aplikasi ini menggunakan firebase untuk menangani proses login dan registrasi, memperbarui profile user, menerima notifikasi dan menggunakan supabase untuk menyimpan foto yang diupload oleh user. Sedangkan untuk setiap catatan yang dibuat oleh user, disimpan menggunakan database lokal yaitu SQLite.

### Key Features

- **Modern UI/UX Design** - Antarmuka yang clean, minimalis, dan user-friendly untuk pengalaman mencatat yang fokus.
- **Media Attachment** - Dukungan upload foto ke dalam catatan yang disimpan secara aman menggunakan Supabase Storage.
- **User Profile Management** - Fitur pengelolaan akun yang memungkinkan pengguna memperbarui foto profil dan data diri dengan mudah.
- **Cloud Sync** - Sinkronisasi otomatis dengan Firebase
- **Secure Authentication** - Sistem login dan registrasi yang aman, cepat, dan terpercaya menggunakan teknologi Firebase Authentication.
- **Push Notifications** - Sistem notifikasi pintar via Firebase untuk mengingatkan pengguna akan catatan atau jadwal penting.
- **Quick Action** - Kemudahan mengelola catatan (seperti menghapus catatan) dengan akses cepat langsung dari halaman utama.

## Screenshots

<div align="center">
  <img src="screenshots/ss-1.jpeg" alt="Splash Screen 1" width="200"/>
  <img src="screenshots/ss-2.jpeg" alt="Splash Screen 2" width="200"/>
  <img src="screenshots/ss-3.jpeg" alt="Splash Screen 3" width="200"/>
  <img src="screenshots/ss-4.jpeg" alt="Splash Screen 4" width="200"/>
  <img src="screenshots/dashboard.png" alt="Halaman Utama" width="200"/>
  <img src="screenshots/foreground-notif.jpeg" alt="Notifikasi" width="200"/>
  <img src="screenshots/fajar.jpeg" alt="Fajar Abdillah" width="200"/>
  <img src="screenshots/damar.jpeg" alt="Damar Bagas" width="200"/>
  <img src="screenshots/frendy.jpeg" alt="Frendy Aprianto" width="200"/>
  <img src="screenshots/rayen.jpeg" alt="Rayhandi Tenri" width="200"/>
</div>

## Demo Video

Lihat video demo aplikasi kami untuk melihat semua fitur dalam aksi!

**[Watch Full Demo on YouTube](https://www.youtube.com/watch?v=uT79qpT3mIE)**

## Download APK

Download versi terbaru aplikasi Funtastic Notes:

### Latest Release v1.0.0
- [**Download APK (57,7 MB)**](https://drive.google.com/drive/folders/1aNF60Xc12keJs9890GgyjRRoqJuoORv3?usp=sharing)


**Minimum Requirements:**
- Android 6.0 (API level 23) or higher
- ~20MB free storage space

## Built With

- **[Flutter](https://flutter.dev/)** - UI Framework
- **[Dart](https://dart.dev/)** - Programming Language
- **[Firebase](https://firebase.google.com/)** - Backend & Authentication
- **[SQLite](https://www.sqlite.org/)** - Local Database
- **[Provider](https://pub.dev/packages/provider)** - State Management


## Getting Started

### Prerequisites

Pastikan Anda sudah menginstall:
- Flutter SDK (3.16.0 or higher)
- Dart SDK (3.2.0 or higher)
- Android Studio / VS Code
- Git

### Installation

1. Clone repository
```bash
git clone https://github.com/AbdillahFajar/funtastic_4
```

2. Install dependencies
```bash
flutter pub get
```

3. Setup Firebase
```bash
# Download google-services.json dari Firebase Console
# Place in android/app/
cp android/app/google-services.json
```

4. Run aplikasi
```bash
flutter run
```

### Build APK

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# Split APK by ABI
flutter build apk --split-per-abi
```

## 📁 Project Structure

```
lib/
├── core/                       # Core utilities (env, constants, helpers)
│
├── data/                       # Data layer (Firebase, API, local DB)
│   └── services/
│       ├── auth_service.dart
│       ├── database_helper.dart
│       ├── firestore_service.dart
│       ├── storage_service.dart
│       └── user_service.dart
│
├── domain/                     # Domain layer (entities, repositories, usecases)
│
├── models/                     # Data models
│   ├── menu.dart
│   ├── note.dart
│   └── team.dart
│
├── presentation/               # UI + State Management
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   └── profile_provider.dart
│   │
│   └── screens/                
│       ├── profiles/
│       ├── app_entry.dart
│       ├── dashboard_screen.dart
│       ├── loading_screen.dart
│       ├── login_screen.dart
│       ├── my_simple_notes.dart
│       ├── notifications_screen.dart
│       ├── profile_update.dart
│       ├── register_page.dart
│       ├── splash_screen.dart
│       ├── splash_screen_2.dart
│       ├── splash_screen_3.dart
│       ├── splash_screen_4.dart
│       └── team_screen.dart
│
├── firebase_options.dart
└── main.dart
```

## Authentication Flow

```
1. Splash Screen (Auto-login check)
   ↓
2. Login Screen / Register Screen
   ↓
3. Home Screen (Dashboard)
   ↓
4. Profile & Settings
```

## 🗄️ Database Schema

### Notes Table
```sql
CREATE TABLE tableABC (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  title TEXT NOT NULL,
  content TEXT,
  category_id TEXT,
  created_at INTEGER,
  updated_at INTEGER,
  is_synced INTEGER DEFAULT 0
);
```


## 📝 API Documentation

### Authentication Endpoints
- `POST /api/auth/register` - Register user baru
- `POST /api/auth/login` - Login user
- `POST /api/auth/logout` - Logout user
- `GET /api/auth/verify` - Verify token

### Development Workflow

1. Fork repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## Team Members & Contributions

### Development Team

| Name | Role | Contributions |
|------|------|---------------|
| **Fajar Abdillah** | Project Lead & Backend Developer | - Mengintegrasikan proyek flutter dengan Firebase dan Supabase untuk kebutuhan autentikasi (login, registrasi dan logout)<br>- Membuat splash screen<br>- Membuat loading screen<br>- Membuat fitur login, registrasi, dan logout<br>- Membuat tampilan utama untuk aplikasi Funtastic Notes<br>- Membuat proses tambah, lihat, update dan hapus catatan menggunakan sqlite<br>- Membuat fitur pembaruan akun user<br>- Membuat fitur terima notifikasi dari Firebase Cloud Message<br>- Membuat halaman Informasi Pengembang<br>- Membuat halaman profil Fajar Abdillah |
| **Muhammad Damar Bagas** | Developer 1 | -Membuat splash screen<br>- Membuat halaman tim pengembang<br>- Membuat halaman profil Damar Bagas |
| **Moh Frendy Aprianto** | Developer 2 | - Membuat splash screen<br>- Membuat halaman profil Frendy Aprianto |
| **Rayhandi Tenri** | Developer 3 | - Membuat splash screen<br>- Membuat halaman profil Rayhandi Tenri |


## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.



## Acknowledgments

- [Flutter Community](https://flutter.dev/community) - For amazing packages
- [Firebase](https://firebase.google.com/) - For backend services
- [Flaticon](https://www.flaticon.com/) - For app icons
- [Unsplash](https://unsplash.com/) - For placeholder images



---

<div align="center">
  <p>Made with by Funtastic Team</p>
  <p>© 2026 Notes App. All rights reserved.</p>
</div>
