import 'package:path/path.dart';
import 'package:question_answer_app/data/local/constants/db_constants.dart';
import 'package:question_answer_app/data/local/db/answer/answer_fields.dart';
import 'package:question_answer_app/data/local/db/question/question_fields.dart';
import 'package:sqflite/sqflite.dart';

class BaseDatabase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(DBConstants.DB_SQ_NAME);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT';
    final textTypeNotNullWithUnique = 'TEXT NOT NULL UNIQUE';
    final textTypeNotNull = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN';
    final integerType = 'INTEGER';

    await db.execute('''
CREATE TABLE ${DBConstants.TABLE_LIST_OF_QUESTION} ( 
  ${QuestionFields.id} $idType, 
  ${QuestionFields.tags} $textType,
  ${QuestionFields.owner} $textType,
  ${QuestionFields.isAnswered} $int,
  ${QuestionFields.answerCount} $integerType,
  ${QuestionFields.viewCount} $integerType,
  ${QuestionFields.score} $integerType,
  ${QuestionFields.questionId} $integerType,
  ${QuestionFields.link} $textType,
  ${QuestionFields.title} $textType,
  ${QuestionFields.acceptedAnswerId} $integerType
  )
''');
    await db.execute('''
CREATE TABLE ${DBConstants.TABLE_LIST_OF_ANSWER} ( 
  ${AnswerFields.id} $integerType, 
  ${AnswerFields.owner} $textType,
  ${AnswerFields.isAccepted} $int,
  ${AnswerFields.score} $integerType,
  ${AnswerFields.answerId} $integerType,
  ${AnswerFields.questionId} $integerType
  )
''');
  }

  Future close() async {
    final db = await database;

    db.close();
  }
}
