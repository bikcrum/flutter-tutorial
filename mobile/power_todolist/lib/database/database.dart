import 'dart:async';

import 'package:path/path.dart';
import 'package:power_todolist/config/keys.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/utils/all_util.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "powertodo.db");
    return await openDatabase(
      path,
      version: 2,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        print("current version:${version}");
        await db.execute("CREATE TABLE TodoList ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "account TEXT,"
            "taskName TEXT,"
            "taskType TEXT,"
            "taskStatus INTEGER,"
            "taskDetailNum INTEGER,"
            "overallProgress TEXT,"
            "changeTimes INTEGER,"
            "createDate TEXT,"
            "finishDate TEXT,"
            "startDate TEXT,"
            "deadLine TEXT,"
            "detailList TEXT,"
            "taskIconPower TEXT"
            ")");
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        print("new version:${newVersion}");
        print("old version:${oldVersion}");
        if (oldVersion <= 2) {
          await db.execute("ALTER TABLE TodoList ADD COLUMN changeTimes INTEGER DEFAULT 0");
        }
      },
    );
  }

  Future createTask(TaskPower task) async {
    final db = await database;
    task.id = await db.insert("TodoList", task.toMap());
  }

  Future<List<TaskPower>> getTasks({bool isDone = false}) async {
    final db = await database;
    final account = await SharedUtil.instance.getString(Keys.account) ?? "default";
    var list = await db.query(
      "TodoList",
      where: "account = ?" + (isDone ? " AND overallProgress >= ?" : " AND overallProgress < ?"),
      whereArgs: [
        account,
        "1.0"
      ],
    );
    List<TaskPower> powers = [];
    powers.clear();
    powers.addAll(TaskPower.fromMapList(list));
    return powers;
  }

  Future updateTask(TaskPower taskPower) async {
    final db = await database;
    await db.update(
      "TodoList",
      taskPower.toMap(),
      where: "id = ?",
      whereArgs: [
        taskPower.id
      ],
    );
  }

  Future deleteTask(int id) async {
    final db = await database;
    db.delete(
      "TodoList",
      where: "id = ?",
      whereArgs: [
        id
      ],
    );
  }

  Future<List<TaskPower>> queryTask(String query) async {
    final db = await database;
    final account = await SharedUtil.instance.getString(Keys.account) ?? "default";
    var list = await db.query(
      "TodoList",
      where: "account = ? AND (taskName LIKE ? "
          "OR detailList LIKE ? "
          "OR startDate LIKE ? "
          "OR deadLine LIKE ?)",
      whereArgs: [
        account,
        "%$query%",
        "%$query%",
        "%$query%",
        "%$query%",
      ],
    );
    List<TaskPower> powers = [];
    powers.clear();
    powers.addAll(TaskPower.fromMapList(list));
    return powers;
  }
}
