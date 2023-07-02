import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:me/db/tables/DocType.dart';
import 'daos/DocTypeDao.dart';

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
// 코드생성 명령어 >>> flutter packages pub run build_runner build --delete-conflicting-outputs
part 'DbSource.g.dart';


// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(tables: [DocTypeGroup], daos: [DocTypeDao])
class LocalDataBase extends _$LocalDataBase {

  // we tell the database where to store the data with this constructor
  LocalDataBase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;
}

  LazyDatabase _openConnection() {
    // the LazyDatabase util lets us find the right location for the file async.
    return LazyDatabase(() async {
      // put the database file, called db.sqlite here, into the documents folder
      // for your app.
      final dbFolder = await getApplicationDocumentsDirectory();
      print("dbFolder:  ${dbFolder.path}");
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    });
  }
