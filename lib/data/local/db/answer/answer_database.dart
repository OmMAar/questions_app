import 'package:question_answer_app/data/local/constants/db_constants.dart';
import 'package:question_answer_app/data/local/db/answer/answer_fields.dart';
import 'package:question_answer_app/data/local/db/base/base_database.dart';
import 'package:question_answer_app/models/questions/answer_item_model.dart';
import 'package:sqflite/sqflite.dart';

class AnswerDatabase {
  // database instance
  final BaseDatabase _db;

  // Constructor
  AnswerDatabase(this._db);

  Future<AnswerItemModel> create(AnswerItemModel item) async {
    final db = await _db.database;

    final id = await db.insert(DBConstants.TABLE_LIST_OF_ANSWER, item.answerItemModelToJson(item));
    print(
        "Item with answer_id :${item.answerId} inserted successfully with answerId sql : $id");
    return item;
  }

  Future<int?> getCount(int questionId) async {
    final db = await _db.database;
    var x = await db
        .rawQuery("SELECT COUNT (*) from ${DBConstants.TABLE_LIST_OF_ANSWER}  WHERE ${AnswerFields.questionId} LIKE '%$questionId%'");
    int count = Sqflite.firstIntValue(x)!;
    return count;
  }

  Future<List<AnswerItemModel>?> getPagingItems(
      {required int page, int pageSize = 20,required int questionId}) async {
    final db = await _db.database;
    var items = await db.rawQuery(
        "SELECT * from ${DBConstants.TABLE_LIST_OF_ANSWER} WHERE ${AnswerFields.questionId} LIKE $questionId LIMIT ${(page - 1) * pageSize}, $pageSize ");
    return items.map((json) => AnswerItemModel.answerItemModelFromJson(json)).toList();
  }

  Future<AnswerItemModel> readItem(int id) async {
    final db = await _db.database;

    final maps = await db.query(
      DBConstants.TABLE_LIST_OF_ANSWER,
      columns: AnswerFields.values,
      where: '${AnswerFields.answerId} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return AnswerItemModel.answerItemModelFromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<AnswerItemModel>> readAllItems() async {
    final db = await _db.database;

    // final orderBy = '${ItemFields.comments} ASC';

    final result = await db.query(DBConstants.TABLE_LIST_OF_ANSWER);

    return result.map((json) => AnswerItemModel.answerItemModelFromJson(json)).toList();
  }

  Future<int> update(AnswerItemModel note) async {
    final db = await _db.database;

    return db.update(
      DBConstants.TABLE_LIST_OF_ANSWER,
      note.toJson(),
      where: '${AnswerFields.answerId} = ?',
      whereArgs: [note.answerId],
    );
  }

  Future<int> delete(int id) async {
    final db = await _db.database;

    return await db.delete(
      DBConstants.TABLE_LIST_OF_ANSWER,
      where: '${AnswerFields.answerId} = ?',
      whereArgs: [id],
    );
  }
}
