import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/note.dart';
import '../models/topic.dart';


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
          await db.execute(
            "CREATE TABLE Topic(id INTEGER PRIMARY KEY autoincrement, title TEXT,description TEXT,color Integer,isRemoveAble BOOLEAN)",
          );

          insertTopic(
            Topic(
                title: "General",
                description: "General Topic",
                color:-4144960,
                isRemoveAble: false
            )
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

  Future insertTopic(Topic topic) async {
    await openDb();
    return await _database.insert('Topic', topic.toJson());
  }

  Future<List<Topic>> getTopicList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query(
        'Topic',
        orderBy: "isRemoveAble ASC, id DESC"
    );

    return List.generate(maps.length, (i) {
      return Topic(
          id: maps[i]['id'],
          title: maps[i]['title'],
          description: maps[i]['description'],
          color: maps[i]['color'],
          isRemoveAble : maps[i]['isRemoveAble'] == 0 ? false : true
      );
    });
  }
}