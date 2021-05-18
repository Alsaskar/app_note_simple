class NoteModel {
  int id;
  String judul;
  String catatan;
  String pin;
  String tanggal;

  NoteModel({this.id, this.judul, this.catatan, this.pin, this.tanggal});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      judul: json['judul'],
      catatan: json['catatan'],
      pin: json['pin'],
      tanggal: json['tanggal'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['judul'] = this.judul;
    data['catatan'] = this.catatan;
    data['pin'] = this.pin;
    data['tanggal'] = this.tanggal;

    return data;
  }
}
