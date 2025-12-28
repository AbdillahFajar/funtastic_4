import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:funtastic_4/screens/loading_screen.dart';
import 'register_page.dart';
import 'package:provider/provider.dart';
import '../presentation/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  // bool _isLoading = false; /*Nilai awal _isLoading adalah false. _isLoading berfungsi sebagai acuan untuk aplikai menentukan tampilannya (UI),
  //                           jadi, UI akan dipengaruhi berdasarkan keadaan _isLoading, apakah true atau false.
  //                            Dalam halaman login ini, yang dipengaruhi tampilannya berdasarkan keadaan _isLoading adalah tombol 'Login' yang menggunakan ElevatedButton.*/
  // String? _error; //nilai awal _error belum didefinisikan tapi telah dibuat sebagai String yang nilainya boleh null.
  bool _obscure =
      true; //ini untuk tombol mata yang memunculkan atau menyembunyikan password ketika diklik

  // Future<void>_login() async {

  //   //keadaan awal yang terjadi ketika tombol login di-klik, sehingga memanggil _login untuk bekerja, dan proses login pun berjalan dengan firebase mulai mencocokkan hasil inputan dari user di field email dan password
  //   setState(() {
  //     _isLoading = true; //tombol login jadi disable dan berubah menjadi loading circular
  //     _error = null; //_error di-set ke null, karena setiap kali tombol login di-klik, maka selama proses login berjalan, tidak akan ada error apapun sampai firebase tidak menemukan adanya kesalahan dari inputan user di field email dan password atau dari aplikasinya sendiri
  //   });

  //   //
  //   try{
  //     //mengambil hasil inputan user di field email dan password
  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailCtrl.text.trim(),//mengambil inputan berupa text dari field email dan menghapus spasi di tiap ujung (ujung kiri dan kanan) tulisan emailnya
  //       password: passCtrl.text,//mengambil inputan text dari field password
  //     );

  //     final user = credential.user; //cek atau ambil user yang sesuai dengan hasil inputan email dan password yang dimasukkan

  //     if(!mounted) return; //ini mencegah aplikasi crash ketika widget aplikasi di-dispose (dihilangkan) oleh flutter karena perilaku user, contohnya, keluar dari aplikasi

  //     //ini bakalan muncul kalo login berhasil, yaitu kumpulan tulisan yang disusun di dalam semacam card. kenapa pake !mounted?
  //     showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //         title: const Text('Login Berhasil. Silahkan klik \'OK\' untuk lanjut'),
  //         content: Text('UID: ${user?.uid}\nEmail: ${user?.email}'),
  //         actions: [TextButton(onPressed: () =>
  //          Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => const LoadingScreen()),
  //           (Route<dynamic> route) => false, //hapus semua rute ke halaman sebelum dashboard dengan kode itu
  //          ),
  //          child:const Text('OK'))],
  //       ),
  //     );
  //   }
  //   //bikin catch untuk pesan error khusus autentikasi firebase yang menangani salah satunya, kalau login gak berhasil (salah email atau password atau keduanya atau bahkan form dikosongkan tapi maksa klik 'Login').
  //   on FirebaseAuthException catch (e) {
  //     setState(() {
  //       _error = e.message;
  //     });
  //   }
  //   catch (e) { //catch untuk pesan error umum yang selain dari autentikasi firebase. contoh, internet mati, error parsing, error kode program, request timeout, dll
  //     setState(() {
  //       _error = e.toString();
  //     });
  //   }
  //   finally { /*ini untuk bagian "pembersihan". di halaman ini, maksudnya adalah me-reset _isLoading kembali menjadi false, agar tombol bisa aktif (bisa diklik), dan loading circular-nya hilang.
  //               karena berdasarkan penggunaan _isLoading di ElevatedButton login, jika true (?), maka tombol login akan null, yang artinya akan disable atau gak bisa diklik dan akan muncul loading circular.
  //               sehingga, jika gak ditangani dengan finally, maka tombolnya akan terus gak bisa diklik dan loading circular-nya akan terus muncul. maka dari itu, setelah nulis isi try dan catch,
  //               finally harus ditulis juga isinya yang berkaitan dengan "pembersihan". contoh lain dari "pembersihan" di finally ini adalah menutup koneksi ke database ketika gak pake firebase atau pake db-manual.*/
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/GI-logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // Text(
                //   "Log in",
                //   style: TextStyle(
                //     fontSize: 25,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black,
                //   ),
                // ),
                SizedBox(height: 10),

                Text(
                  textAlign: TextAlign.center,
                  "Masuk ke akun Anda menggunakan\nemail dan password",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 40),

                //TextField Email
                TextField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Masukkan alamat email Anda',
                    prefixIcon: const Icon(Icons.email),
                    //tambah border ketika field gak diklik user
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    //tambah border ketika field diklik user
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFF1A4C8B),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                //TextField Password
                TextField(
                  controller: passCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Masukkan password Anda',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_off
                            : Icons.visibility_outlined,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFF1A4C8B),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                //logika if yang digunakan ketika ada error terdeteksi, apapun jenisnya, baik dari sisi autentikasi ataupun dari sisi selain itu (baca lagi bagian catch umum)
                if (auth.error != null) ...[
                  //isi logikanya dibungkus dengan kurung siku (artinya, isi dari logika if menggunakan list), karena bukan cuma nampilin satu widget aja yaitu, tulisan error, tapi juga nambahin spasi (SizedBox) ketika tulisan error itu  muncul, sehingga ada space di bawah tulisannya yang gak akan ngebiarin tulisan itu nempel dengan tombol login di bawahnya
                  Text(auth.error!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(
                    height: 8,
                  ), //titik tiga (...) di sana adalah spread operator, yang gunanya untuk memisahkan setiap widget di dalam if itu menjadi widget yang terpisah, bukan satu widget
                ],

                //bikin tombol login
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: auth.loading
                          ? null
                          : () async {
                              final nav = Navigator.of(context);
                              try {
                                await auth.signIn(
                                  emailCtrl.text.trim(),
                                  passCtrl.text,
                                );
                                if (auth.error == null) {
                                  nav.pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LoadingScreen(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Login gagal: ${e.toString()}',
                                    ),
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE5B637),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Daftar Akun",
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
