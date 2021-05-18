class NoteQuery {
  static const String TABLE_NAME = "note";
  static const String CREATE_TABLE =
      " CREATE TABLE IF NOT EXISTS $TABLE_NAME (id INTEGER PRIMARY KEY AUTOINCREMENT, judul TEXT, catatan TEXT, pin TEXT, tanggal TEXT)";
  static const String SELECT = "SELECT * FROM $TABLE_NAME";
}
