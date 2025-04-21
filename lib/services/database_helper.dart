import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_v2/models/noted_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_noted.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE notes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          content TEXT,
          color TEXT,
          dateTime TEXT
        )
      ''');
  }

  Future<int> insertNote(NotedModel note) async {
    final db = await database;
    return await db.insert('notes', note.toMap());
  }

  Future<List<NotedModel>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) => NotedModel.fromMap(maps[i]));
  }

  Future<int> updateNote(NotedModel note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int noteId) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [noteId]);
  }
}
