import 'package:drift/drift.dart';
import 'package:me/db/DbSource.dart';

import 'package:me/db/tables/DocType.dart';

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
// 코드생성 명령어 >>> flutter packages pub run build_runner build --delete-conflicting-outputs
part 'DocTypeDao.g.dart';


// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftAccessor(tables: [DocTypeGroup])
class DocTypeDao extends DatabaseAccessor<LocalDataBase>
    with _$DocTypeDaoMixin
{
  // this constructor is required so that the main database can create an instance
  // of this object.
  DocTypeDao(LocalDataBase db) : super(db);

  // we tell the database where to store the data with this constructor
  Stream<List<DocTypeGroupData>> watchDocTypeGroup(String id) =>
      (select(docTypeGroup)..where((tbl) => tbl.typeGroupId.equals(id))).watch();

  // insert
  Future<int> createDocTypeGroup(DocTypeGroupCompanion data) => into(docTypeGroup).insert(data);

  // delete
  Future<int> removeDocTypeGroup(String id) =>
      (delete(docTypeGroup)..where((tbl) => tbl.typeGroupId.equals(id))).go();

}

