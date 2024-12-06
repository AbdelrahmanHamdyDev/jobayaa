import 'dart:async';
import 'package:jobayaa/Models/jobaya.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlLiteDB {
  Database? _db;

  static final SqlLiteDB _instance = SqlLiteDB._internal();
  factory SqlLiteDB() => _instance;
  SqlLiteDB._internal();

  final StreamController<List<job>> _jobStreamController =
      StreamController<List<job>>.broadcast();

  Stream<List<job>> get jobStream => _jobStreamController.stream;

  Future<Database> getDb() async {
    if (_db == null) {
      _db = await initDb();
      await _updateJobStream();
    }
    return _db!;
  }

  Future<Database> initDb() async {
    String dataPath = await getDatabasesPath();
    String path = join(dataPath, 'jobaya.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE jobs (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "name" TEXT NOT NULL,
        "link" TEXT NOT NULL,
        "company_name" TEXT NOT NULL,
        "platform" TEXT NOT NULL,
        "description" TEXT,
        "location" TEXT
      )
    ''');

    print("Database created");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("Database upgraded");
  }

  Future<List<job>> getJobs() async {
    Database db = await getDb();
    List<Map<String, dynamic>> data = await db.query('jobs');
    return data.map((e) => job.fromMap(e)).toList();
  }

  Future<int> insertJob(job Job) async {
    Database db = await getDb();
    int res = await db.insert(
      'jobs',
      {
        'name': Job.name,
        'link': Job.link,
        'company_name': Job.companyName,
        'platform': Job.platform.name,
        'description': Job.description,
        'location': Job.location,
      },
    );
    await _updateJobStream();
    return res;
  }

  Future<int> updateJob(job Job) async {
    Database db = await getDb();
    int res = await db.update(
      'jobs',
      {
        'name': Job.name,
        'link': Job.link,
        'company_name': Job.companyName,
        'platform': Job.platform.name,
        'description': Job.description,
        'location': Job.location,
      },
      where: 'id = ?',
      whereArgs: [Job.id],
    );
    await _updateJobStream();
    return res;
  }

  Future<int> deleteJob(job Job) async {
    Database db = await getDb();
    int res = await db.delete('jobs', where: 'id = ?', whereArgs: [Job.id]);
    await _updateJobStream();
    return res;
  }

  Future<void> _updateJobStream() async {
    List<job> jobs = List.from(await getJobs());
    _jobStreamController.add(jobs);
  }

  void dispose() {
    _jobStreamController.close();
  }
}
