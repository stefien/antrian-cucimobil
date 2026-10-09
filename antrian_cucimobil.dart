import 'dart:io';

void main() {
  var jalan = true;

  Map<String, dynamic> posa = {'plat': null};
  Map<String, dynamic> posb = {'plat': null};
  Map<String, dynamic> posc = {'plat': null};

  List<String> waitinglist = [];

  void tampilmenu() {
    print('\n========================');
    print('===== Wash & Clean =====');
    print('========================');
    print('1. Tambah Waiting List');
    print('2. Lihat Waiting List');
    print('3. Lihat Pos');
    print('4. Selesaikan Pos');
    print('5. Keluar Aplikasi');
    print('=========================');
    stdout.write('Pilih Menu (1/2/3/4/5): ');
  }

  void tambahlist() {
    stdout.write('Masukkan plat mobil: ');
    String? plat = stdin.readLineSync()?.toUpperCase();

    if (plat == null || plat.trim().isEmpty) {
      print('\nPlat nomor tidak boleh kosong!');
      return;
    }

    if (posa['plat'] == null) {
      posa['plat'] = plat;
      print('Mobil $plat berhasil masuk ke POS A');
    } else if (posb['plat'] == null) {
      posb['plat'] = plat;
      print('Mobil $plat berhasil masuk ke POS B');
    } else if (posc['plat'] == null) {
      posc['plat'] = plat;
      print('Mobil $plat berhasil masuk ke POS C');
    } else {
      waitinglist.add(plat);
      print(
          'Semua pos penuh. Mobil $plat masuk ke Waiting List urutan ke-${waitinglist.length}');
    }
  }

  void lihatlist() {
    print('\n===== Waiting List =====');
    if (waitinglist.isEmpty) {
      print('Tidak ada mobil di waiting list.');
    } else {
      for (int i = 0; i < waitinglist.length; i++) {
        print('${i + 1}. Mobil [${waitinglist[i]}]');
      }
    }
  }

  void lihatpos() {
    print('\n===== Kondisi Pos Cuci =====');
    print('POS A: ${posa['plat'] ?? 'KOSONG'}');
    print('POS B: ${posb['plat'] ?? 'KOSONG'}');
    print('POS C: ${posc['plat'] ?? 'KOSONG'}');
  }

  void selesaikanpos() {
    print('\nPilih POS yang sudah selesai dicuci:');
    print('A. POS A ([${posa['plat'] ?? 'KOSONG'}])');
    print('B. POS B ([${posb['plat'] ?? 'KOSONG'}])');
    print('C. POS C ([${posc['plat'] ?? 'KOSONG'}])');
    stdout.write('Pilih pos (A/B/C): ');
    String? pilihanpos = stdin.readLineSync()?.toUpperCase();

    Map<String, dynamic>? posterpilih;
    String namapos = '';

    if (pilihanpos == 'A') {
      posterpilih = posa;
      namapos = 'POS A';
    } else if (pilihanpos == 'B') {
      posterpilih = posb;
      namapos = 'POS B';
    } else if (pilihanpos == 'C') {
      posterpilih = posc;
    } else {
      print('Pilihan pos tidak valid!');
      return;
    }

    if (posterpilih['plat'] == null) {
      print('$namapos memang sudah kosong!');
      return;
    }

    print('$namapos Selesai.');
    posterpilih['plat'] = null; 

    if (waitinglist.isNotEmpty) {
      String mobilberikutnya =
          waitinglist.removeAt(0);
      posterpilih['plat'] = mobilberikutnya;
      print('Mobil [$mobilberikutnya] masuk ke $namapos');
    } else {
      print('$namapos sekarang kosong.');
    }
  }

  while (jalan) {
    tampilmenu();
    String? input = stdin.readLineSync();
    switch (input) {
      case '1':
        tambahlist();
        break;
      case '2':
        lihatlist();
        break;
      case '3':
        lihatpos();
        break;
      case '4':
        selesaikanpos();
        break;
      case '5':
        jalan = false;
        exit(0);
      default:
        print('Menu tidak tersedia, silakan coba lagi.');
    }
  }
}
