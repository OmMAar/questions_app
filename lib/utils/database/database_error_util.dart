import 'package:sqflite/sqflite.dart';

class DataBaseErrorUtil {
  // general methods:------------------------------------------------------------
  static String handleError(dynamic error) {
    String errorDescription = "";
    if (error is DatabaseException) {

      if(error.isDatabaseClosedError()){
        errorDescription = "Database Closed Error";
      }else if(error.isDuplicateColumnError()){
        errorDescription = "Duplicate Column Error";
      }else if(error.isNoSuchTableError()){
        errorDescription = "No Such Table Error";
      }
      else if(error.isNotNullConstraintError()){
        errorDescription = "Not Null Constraint Error";
      }else if(error.isOpenFailedError()){
        errorDescription = "Open Failed Error";
      }else if(error.isReadOnlyError()){
        errorDescription = "Read Only Error";
      }else if(error.isSyntaxError()){
        errorDescription = "Syntax Error";
      }else if(error.isUniqueConstraintError()){
        errorDescription = "Unique Constraint Error";
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}