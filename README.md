Muhammad Rizky Febrianto | 2409116045
# 📱 Mini Project 1

## 📝 Deskripsi Aplikasi

Arkivee adalah aplikasi mobile berbasis Flutter untuk mengelola surat masuk dan surat keluar secara digital. Aplikasi ini memudahkan pengguna dalam mencatat, menyimpan, memperbarui, dan menghapus data surat tanpa perlu menggunakan arsip fisik. Dengan tampilan yang sederhana dan intuitif, Arkivee cocok digunakan untuk keperluan administrasi pribadi maupun organisasi kecil.

State management pada aplikasi ini menggunakan **GetX**, sehingga perubahan data langsung tercermin di tampilan tanpa perlu reload halaman secara manual.

---

## ✨ Fitur Aplikasi

- **Tambah Surat** — Menambahkan data surat baru dengan mengisi form yang tersedia
- **Lihat Daftar Surat** — Menampilkan semua surat yang tersimpan dalam bentuk list
- **Update Surat** — Mengedit data surat yang sudah ada
- **Hapus Surat** — Menghapus surat dari daftar penyimpanan
- **Statistik Surat** — Menampilkan jumlah total surat, surat masuk, dan surat keluar di halaman utama
- **Recently** — Menampilkan 4 surat yang paling baru ditambahkan di halaman utama
- **Pilih Tanggal** — Field tanggal menggunakan date picker kalender, bukan input manual
- **Validasi Nomor Surat** — Nomor surat yang sudah digunakan tidak bisa dipakai lagi selama masih tersimpan

---

## 🧩 Widget yang Digunakan

| Widget | Kegunaan |
|---|---|
| `GetMaterialApp` | Root aplikasi dengan dukungan GetX |
| `Scaffold` | Struktur dasar tiap halaman |
| `AppBar` | Header halaman utama |
| `FloatingActionButton` | Tombol tambah surat |
| `Container` | Membungkus elemen dengan dekorasi warna dan border radius |
| `SafeArea` | Menghindari konten tertutup status bar |
| `Column` | Menyusun widget secara vertikal |
| `Row` | Menyusun widget secara horizontal |
| `Expanded` | Mengisi sisa ruang yang tersedia |
| `ListView.builder` | Menampilkan daftar surat secara dinamis |
| `Card` | Tampilan kotak dengan bayangan untuk tiap surat dan input field |
| `ListTile` | Isi konten tiap kartu surat |
| `TextField` | Input teks untuk form surat |
| `DropdownButton` | Pilihan kategori surat (Masuk / Keluar) |
| `ElevatedButton` | Tombol simpan |
| `IconButton` | Tombol hapus dan tombol back |
| `TextButton` | Tombol "See All" di halaman utama |
| `SnackBar` (via `Get.snackbar`) | Notifikasi validasi form |
| `Obx` | Widget GetX untuk reaktif terhadap perubahan data |
| `showDatePicker` | Dialog kalender untuk memilih tanggal surat |
| `BoxDecoration` | Dekorasi container (warna, border radius) |
| `BorderRadius` | Mengatur sudut melengkung pada container |
| `SingleChildScrollView` | Membuat form bisa di-scroll |
| `SizedBox` | Memberi jarak antar widget |
| `Padding` | Memberi jarak di dalam widget |
| `Center` | Memusatkan widget |
| `Text` | Menampilkan teks |
| `Icon` | Ikon pada tombol |

---

## 🖼️ Tampilan Aplikasi & Penjelasannya
<table>
  <tr>
    <th>Home Page</th>
    <th>Create A Letter</th>
  </tr>  
  <tr>
    <td><img width="312" height="672" alt="image" src="https://github.com/user-attachments/assets/a6af862e-64a5-4b04-ada1-8a145eb7e251" /></td>
    <td><img width="310" height="671" alt="image" src="https://github.com/user-attachments/assets/5c8bafaf-b8b7-4724-9e58-ff5bfe5701c9" /></td>
  </tr>
  <tr>
    <td>
        Halaman utama aplikasi. Di bagian atas terdapat kotak biru yang menampilkan statistik surat: jumlah surat masuk, surat keluar, dan total surat. Di bawahnya ada section "Recently" yang akan menampilkan 4 surat             terbaru, serta tombol *See All* untuk melihat semua surat. Tombol "+" di pojok kanan bawah digunakan untuk menambah surat baru.
    </td>
    <td>
        Halaman untuk menambahkan surat baru. Terdapat 5 field yang harus diisi: Nomor Surat, Perihal, Tanggal Surat (dengan ikon kalender untuk memilih tanggal), Asal/Tujuan, dan Kategori Surat (dropdown Masuk/Keluar).          Di bagian bawah ada tombol "Simpan" untuk menyimpan data. Tombol "←" di pojok kiri atas untuk kembali ke halaman sebelumnya.
    </td>
  </tr>
  <tr>
    <th>Your Letter (List Surat)</th>
    <th>Update A Letter</th>
  </tr>
  <tr>
    <td><img width="311" height="673" alt="image" src="https://github.com/user-attachments/assets/88f836c1-eb75-4c91-ab4b-3ae254edc16b" /></td>
    <td><img width="309" height="673" alt="image" src="https://github.com/user-attachments/assets/c4f2d283-8115-49e1-8343-3f3a186e7cc7" /></td>
  </tr>
  <tr>
    <td>
      Halaman daftar semua surat yang tersimpan. Setiap surat ditampilkan dalam bentuk kartu berisi: Perihal (judul), Nomor, Tanggal, Kategori, dan Asal/Tujuan. Terdapat ikon 🗑️ merah di sisi kanan untuk menghapus             surat. Jika kartu ditekan, akan masuk ke halaman Update.
    </td>
    <td>
      Halaman untuk mengedit data surat yang sudah ada. Form-nya sama seperti Create, namun field sudah terisi dengan data lama sehingga pengguna tinggal mengubah bagian yang diperlukan saja. Setelah selesai, tekan             "Simpan" untuk menyimpan perubahan.
    </td>
  </tr>
</table>

---

# 🚀 Mini Project 2
