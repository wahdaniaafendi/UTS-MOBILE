//kelas abstrak Transportasi
abstract class Transportasi {
    String id; //kode unik transportasi
    String nama; //nama transportasi
    double _tarifDasar; //tarif dasar(private)
    int kapasitas; //jumlah maksimum penumpang

    //konstruktor
    Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas);

    //getter untuk tarif dasar
    double get tarifDasar => _tarifDasar;

    //method abstrak untuk menghitung tarif
    double hitungTarif(int jumlahPenumpang);

    //menampilkan info Transportasi
    void tampilInfo() {
        print("ID: $id");
        print("Nama: $nama");
        print("Tarif Dasar: $_tarifDasar");
        print("Kapasitas: $kapasitas");
    }
}

//kelas turunan 1.Taksi
class Taksi extends Transportasi {
    double jarak;//jarak perjalanan dalam km

    //konstruktor
    Taksi(String id, String nama, double tarifDasar, int kapasitas, this.jarak)
        :super(id, nama, tarifDasar, kapasitas);
    
    //override method hitungTarif
    @override
    double hitungTarif(int jumlahPenumpang) {
        return tarifDasar * jarak; //rumus hitung total biaya taksi
    }

    //override tampilanInfo untuk info taksi
    @override
    void tampilInfo() {
        super.tampilInfo();
        print("Jarak: $jarak km");
    }
}

// kelas turunan 2.Bus
class Bus extends Transportasi {
    bool adaWifi; //true jika bus memiliki wifi

    //kontruktor 
    Bus(String id, String nama, double tarifDasar, int kapasitas, this.adaWifi)
        :super(id, nama, tarifDasar, kapasitas);

    //override method hitungTarif
    @override
    double hitungTarif(int jumlahPenumpang) {
        //rumus total biaya
        return (tarifDasar * jumlahPenumpang) + (adaWifi ? 5000 : 0);
    }

    //override tampilInfo menambah info wifi
    @override
    void tampilInfo() {
        super.tampilInfo();
        print("Ada Wifi: ${adaWifi ? 'ya' : 'Tidak'}");
    }
}

//Kelas turunan 3.Pesawat
class Pesawat extends Transportasi {
    String kelasPenerbangan; //tipe kelas: ekonomi atau bisnis

    //konstruktor 
    Pesawat(String id, String nama, double tarifDasar, int kapasitas, this.kelasPenerbangan)
        :super(id, nama, tarifDasar, kapasitas);

    //override method hitungTarif
    @override
    double hitungTarif(int jumlahPenumpang) {
        //rumus total biaya pesawat
        double faktor = (kelasPenerbangan == "Bisnis") ? 1.5 : 1.0;
        return tarifDasar * jumlahPenumpang * faktor;
    }

    //override tampilInfo untuk pesawat
    @override
    void tampilInfo() {
        super.tampilInfo();
        print("Kelas Penerbangan: $kelasPenerbangan");
    }
}

//kelas pemesanan
class Pemesanan {
    String idPemesanan;// kode unik pemesanan
    String namaPelanggan; //nama pelanggan
    Transportasi transportasi; //objek transportasi
    int jumlahPenumpang; //jumlah penumpang
    double totalTarif; //total biaya perjalanan

    //kosntruktor 
    Pemesanan(this.idPemesanan, this.namaPelanggan, this.transportasi, this.jumlahPenumpang, this.totalTarif);

    //menampilkan struk pembayaran
    void cetakStruk() {
        print("\n ===== STRUK PEMESANAN =====");
        print("ID Pemesanan: $idPemesanan");
        print("Nama Pelanggan: $namaPelanggan");
        print("Transportasi: $Transportasi");
        print("Jumlah Penumpang: $jumlahPenumpang");
        print("Total Tarif: Rp ${totalTarif.toStringAsFixed(2)}");
        print("==============================\n");
    }

    //mengubah data pemesana ke database Map
    Map<String, dynamic> toMap() {
        return {
            'idPemesanan': idPemesanan,
            'namaPelanggan': namaPelanggan,
            'transportasi': transportasi,
            'jumlahPenumpang': jumlahPenumpang,
            'totalTarif': totalTarif,
        };
    }
}

//fungsi global pemesanan
Pemesanan buatPemesanan(Transportasi t, String nama, int jumlahPenumpang) {
    double total= t.hitungTarif(jumlahPenumpang); //hitung total tarif
    // buat ID unik berdasarkan pemesanan dalam waktu
    String idPemesanan = "PM-${DateTime.now().millisecondsSinceEpoch}";
    //kembalikan objek pemesanan
    return Pemesanan (idPemesanan, nama, t, jumlahPenumpang, total);
}

//fungsi global tampilkSemuaPemesanan
void tampilkSemuaPemesanan(List<Pemesanan> daftar) {
    print("\n===== DAFTAR SEMUA PEMESANAN =====");
    for (var p in daftar) {
        p.cetakStruk(); // tampilkan struk satu per satu
    }
}

//fungsi main (program utama)
void main() {
    //membuat objek transportasi
    Taksi taksi = Taksi("T001", "Taksi Online", 8000, 4, 10); //10 km perjalanan
    Bus bus = Bus("B001", "Bus TransTernate", 5000, 40, true); //true = ada wifi
    Pesawat pesawat = Pesawat("P001", "Garuda Indonesia", 1500000, 180, "Bisnis");

    //List simpan semua pemesanan
    List<Pemesanan> daftarPemesanan = [];

    //membuat simulasi pemesanan
    var p1 = buatPemesanan(taksi, "Wahdania", 1);
    var p2 = buatPemesanan(bus, "ibrahim", 5);
    var p3 = buatPemesanan(pesawat, "Abbas", 2);

    //menyimpan semua ke dalam list
    daftarPemesanan.addAll([p1, p2, p3]);

    //menampilkan semua hasil pemesanan
    tampilkSemuaPemesanan(daftarPemesanan);
}