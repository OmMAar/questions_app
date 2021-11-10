
import 'package:question_answer_app/data/local/constants/db_constants.dart';
import 'package:question_answer_app/data/local/db/base/base_database.dart';
import 'package:question_answer_app/data/local/db/question/question_fields.dart';
import 'package:question_answer_app/models/questions/question_item_model.dart';
import 'package:sqflite/sqflite.dart';

class QuestionDatabase {
  // database instance
  final BaseDatabase _db;

  // Constructor
  QuestionDatabase(this._db);

  Future<QuestionItemModel> create(QuestionItemModel item) async {
    final db = await _db.database;

    final id = await db.insert(DBConstants.TABLE_LIST_OF_QUESTION, item.questionItemLocalModelToJson(item));
    print("Item with question_id :${item.questionId} inserted successfully with question_id sql : $id");
    return item;
  }

  Future<int?> getCount() async {
    final db = await _db.database;
    var x = await db
        .rawQuery('SELECT COUNT (*) from ${DBConstants.TABLE_LIST_OF_QUESTION}');
    int count = Sqflite.firstIntValue(x)!;
    return count;
  }

  Future<List<QuestionItemModel>?> getPagingItems(
      {required int page, int pageSize = 20}) async {
    final db = await _db.database;
    var items = await db.rawQuery(
        'SELECT * from ${DBConstants.TABLE_LIST_OF_QUESTION} LIMIT ${(page - 1) * pageSize}, $pageSize ');
    return items.map((json) => QuestionItemModel.questionItemLocalModelFromJson(json)).toList();
  }

  Future<QuestionItemModel> readItem(int id) async {
    final db = await _db.database;

    final maps = await db.query(
      DBConstants.TABLE_LIST_OF_QUESTION,
      columns: QuestionFields.values,
      where: '${QuestionFields.questionId} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return QuestionItemModel.questionItemLocalModelFromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<QuestionItemModel>> readAllItems() async {
    final db = await _db.database;

    // final orderBy = '${ItemFields.comments} ASC';

    final result = await db.query(DBConstants.TABLE_LIST_OF_QUESTION);

    return result.map((json) => QuestionItemModel.questionItemLocalModelFromJson(json)).toList();
  }

  Future<int> update(QuestionItemModel note) async {
    final db = await _db.database;

    return db.update(
      DBConstants.TABLE_LIST_OF_QUESTION,
      note.toJson(),
      where: '${QuestionFields.questionId} = ?',
      whereArgs: [note.questionId],
    );
  }

  Future<int> delete(int id) async {
    final db = await _db.database;

    return await db.delete(
      DBConstants.TABLE_LIST_OF_QUESTION,
      where: '${QuestionFields.questionId} = ?',
      whereArgs: [id],
    );
  }
}