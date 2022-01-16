import 'package:link/models/friend.dart';
import 'package:sqflite/sqflite.dart';

class LinkDatabase {
  static final LinkDatabase instance = LinkDatabase._init();

  static Database? _database;

  final int _version = 1;

  LinkDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('com.stream_suite.link.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    return await openDatabase(filePath, version: _version, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('DROP TABLE If EXISTS $friendsTableName');
    await db.execute('''
CREATE TABLE $friendsTableName ( 
  ${FriendsTableFieldNames.id} $idType, 
  ${FriendsTableFieldNames.userId} $textType, 
  ${FriendsTableFieldNames.email} $textType, 
  ${FriendsTableFieldNames.username} $textType, 
  ${FriendsTableFieldNames.isRequest} $integerType
  );
''');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
