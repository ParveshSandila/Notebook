import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/note.dart';


class NoteDBHandler{

  late Database _database;

  static NoteDBHandler databaseHandler = NoteDBHandler();

  Future openDb() async {
    _database = await openDatabase(
        join(await getDatabasesPath(), "notes.db"),
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            "CREATE TABLE Note(id INTEGER PRIMARY KEY autoincrement, heading TEXT, description TEXT)",
          );
        });
    return _database;
  }

  Future insertModel(Note note) async {
    await openDb();
    return await _database.insert('Note', note.toJson());
  }

  Future<List<Note>> getNoteList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query(
        'Note',
         orderBy: "id DESC"
    );

    return List.generate(maps.length, (i) {
      return Note(
          id: maps[i]['id'],
          heading: maps[i]['heading'],
          description: maps[i]['description']);
    });
  }

}