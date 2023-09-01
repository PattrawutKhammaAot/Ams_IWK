import 'package:sqflite/sqflite.dart';

import '../../data/database/dbsqlite.dart';
import '../../data/database/quickTypes/quickTypes.dart';

class ListCountDetailReportModel {
  const ListCountDetailReportModel({
    this.ID,
    this.PLAN_CODE,
    this.ASSET_CODE,
    this.ASSET_NAME,
    this.BEFORE_LOCATION_ID,
    this.BEFORE_LOCATION_CODE,
    this.BEFORE_LOCATION_NAME,
    this.NEW_LOCATION_ID,
    this.NEW_LOCATION_CODE,
    this.NEW_LOCATION_NAME,
    this.BEFORE_DEPARTMENT_ID,
    this.BEFORE_DEPARTMENT_CODE,
    this.BEFORE_DEPARTMENT_NAME,
    this.NEW_DEPARTMENT_ID,
    this.NEW_DEPARTMENT_CODE,
    this.NEW_DEPARTMENT_NAME,
    this.CHECK_DATE,
    this.STATUS_CHECK,
    this.STATUS_NAME,
    this.REMARK,
    this.QTY,
  });
  final int? ID;
  final String? PLAN_CODE;
  final String? ASSET_CODE;
  final String? ASSET_NAME;
  final int? BEFORE_LOCATION_ID;
  final String? BEFORE_LOCATION_CODE;
  final String? BEFORE_LOCATION_NAME;
  final int? NEW_LOCATION_ID;
  final String? NEW_LOCATION_CODE;
  final String? NEW_LOCATION_NAME;
  final int? BEFORE_DEPARTMENT_ID;
  final String? BEFORE_DEPARTMENT_CODE;
  final String? BEFORE_DEPARTMENT_NAME;
  final int? NEW_DEPARTMENT_ID;
  final String? NEW_DEPARTMENT_CODE;
  final String? NEW_DEPARTMENT_NAME;
  final String? CHECK_DATE;
  final String? STATUS_CHECK;
  final String? STATUS_NAME;
  final String? REMARK;
  final int? QTY;
  List<Object> get props => [
        ID!,
        PLAN_CODE!,
        ASSET_CODE!,
        ASSET_NAME!,
        BEFORE_LOCATION_ID!,
        BEFORE_LOCATION_CODE!,
        BEFORE_LOCATION_NAME!,
        NEW_LOCATION_ID!,
        NEW_LOCATION_CODE!,
        NEW_LOCATION_NAME!,
        BEFORE_DEPARTMENT_ID!,
        BEFORE_DEPARTMENT_CODE!,
        BEFORE_DEPARTMENT_NAME!,
        NEW_DEPARTMENT_ID!,
        NEW_DEPARTMENT_CODE!,
        NEW_DEPARTMENT_NAME!,
        CHECK_DATE!,
        STATUS_CHECK!,
        STATUS_NAME!,
        REMARK!,
        QTY!,
      ];

  static ListCountDetailReportModel fromJson(dynamic json) {
    return ListCountDetailReportModel(
      ID: json[ListCountDetailReportField.ID],
      PLAN_CODE: json[ListCountDetailReportField.PLAN_CODE],
      ASSET_CODE: json[ListCountDetailReportField.ASSET_CODE],
      ASSET_NAME: json[ListCountDetailReportField.ASSET_NAME],
      BEFORE_LOCATION_ID: json[ListCountDetailReportField.BEFORE_LOCATION_ID],
      BEFORE_LOCATION_CODE:
          json[ListCountDetailReportField.BEFORE_LOCATION_CODE],
      BEFORE_LOCATION_NAME:
          json[ListCountDetailReportField.BEFORE_LOCATION_NAME],
      NEW_LOCATION_ID: json[ListCountDetailReportField.NEW_LOCATION_ID],
      NEW_LOCATION_CODE: json[ListCountDetailReportField.NEW_LOCATION_CODE],
      NEW_LOCATION_NAME: json[ListCountDetailReportField.NEW_LOCATION_NAME],
      BEFORE_DEPARTMENT_ID:
          json[ListCountDetailReportField.BEFORE_DEPARTMENT_ID],
      BEFORE_DEPARTMENT_CODE:
          json[ListCountDetailReportField.BEFORE_DEPARTMENT_CODE],
      BEFORE_DEPARTMENT_NAME:
          json[ListCountDetailReportField.BEFORE_DEPARTMENT_NAME],
      NEW_DEPARTMENT_ID: json[ListCountDetailReportField.NEW_DEPARTMENT_ID],
      NEW_DEPARTMENT_CODE: json[ListCountDetailReportField.NEW_DEPARTMENT_CODE],
      NEW_DEPARTMENT_NAME: json[ListCountDetailReportField.NEW_DEPARTMENT_NAME],
      CHECK_DATE: json[ListCountDetailReportField.CHECK_DATE],
      STATUS_CHECK: json[ListCountDetailReportField.STATUS_CHECK],
      STATUS_NAME: json[ListCountDetailReportField.STATUS_NAME],
      REMARK: json[ListCountDetailReportField.REMARK],
      QTY: json[ListCountDetailReportField.QTY],
    );
  }

  Map<String, dynamic> toJson() => {
        ListCountDetailReportField.ID: ID,
        ListCountDetailReportField.PLAN_CODE: PLAN_CODE,
        ListCountDetailReportField.ASSET_CODE: ASSET_CODE,
        ListCountDetailReportField.ASSET_NAME: ASSET_NAME,
        ListCountDetailReportField.BEFORE_LOCATION_ID: BEFORE_LOCATION_ID,
        ListCountDetailReportField.BEFORE_LOCATION_CODE: BEFORE_LOCATION_CODE,
        ListCountDetailReportField.BEFORE_LOCATION_NAME: BEFORE_LOCATION_NAME,
        ListCountDetailReportField.NEW_LOCATION_ID: NEW_LOCATION_ID,
        ListCountDetailReportField.NEW_LOCATION_CODE: NEW_LOCATION_CODE,
        ListCountDetailReportField.NEW_LOCATION_NAME: NEW_LOCATION_NAME,
        ListCountDetailReportField.BEFORE_DEPARTMENT_ID: BEFORE_DEPARTMENT_ID,
        ListCountDetailReportField.BEFORE_DEPARTMENT_CODE:
            BEFORE_DEPARTMENT_CODE,
        ListCountDetailReportField.BEFORE_DEPARTMENT_NAME:
            BEFORE_DEPARTMENT_NAME,
        ListCountDetailReportField.NEW_DEPARTMENT_ID: NEW_DEPARTMENT_ID,
        ListCountDetailReportField.NEW_DEPARTMENT_CODE: NEW_DEPARTMENT_CODE,
        ListCountDetailReportField.NEW_DEPARTMENT_NAME: NEW_DEPARTMENT_NAME,
        ListCountDetailReportField.CHECK_DATE: CHECK_DATE,
        ListCountDetailReportField.STATUS_CHECK: STATUS_CHECK,
        ListCountDetailReportField.STATUS_NAME: STATUS_NAME,
        ListCountDetailReportField.REMARK: REMARK,
        ListCountDetailReportField.QTY: QTY,
      };
  createTable(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${ListCountDetailReportField.TABLE_NAME} ('
        '${QuickTypes.ID_PRIMARYKEY},'
        '${ListCountDetailReportField.PLAN_CODE} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.ASSET_CODE} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.ASSET_NAME} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.BEFORE_LOCATION_ID} ${QuickTypes.INTEGER},'
        '${ListCountDetailReportField.BEFORE_LOCATION_CODE} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.BEFORE_LOCATION_NAME} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.NEW_LOCATION_ID} ${QuickTypes.INTEGER},'
        '${ListCountDetailReportField.NEW_LOCATION_CODE} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.NEW_LOCATION_NAME} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.BEFORE_DEPARTMENT_ID} ${QuickTypes.INTEGER},'
        '${ListCountDetailReportField.BEFORE_DEPARTMENT_CODE} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.BEFORE_DEPARTMENT_NAME} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.NEW_DEPARTMENT_ID} ${QuickTypes.INTEGER},'
        '${ListCountDetailReportField.NEW_DEPARTMENT_CODE} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.NEW_DEPARTMENT_NAME} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.CHECK_DATE} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.STATUS_CHECK} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.STATUS_NAME} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.REMARK} ${QuickTypes.TEXT},'
        '${ListCountDetailReportField.QTY} ${QuickTypes.INTEGER}'
        ')');
  }

  Future<int> insert(Map<String, dynamic> data) async {
    try {
      final db = await DbSqlite().database;
      return await db.insert(ListCountDetailReportField.TABLE_NAME, data);
    } on Exception catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> query() async {
    Database db = await DbSqlite().database;
    return await db.query(ListCountDetailReportField.TABLE_NAME);
  }
}

class ListCountDetailReportField {
  static const String TABLE_NAME = 't_listCountDetailReport';
  static const String ID = 'ID';
  static const String PLAN_CODE = 'planCode';
  static const String ASSET_CODE = 'assetCode';
  static const String ASSET_NAME = 'assetName';
  static const String BEFORE_LOCATION_ID = 'beforeLocationId';
  static const String BEFORE_LOCATION_CODE = 'beforeLocationCode';
  static const String BEFORE_LOCATION_NAME = 'beforeLocationName';
  static const String NEW_LOCATION_ID = 'newLocationId';
  static const String NEW_LOCATION_CODE = 'newLocationCode';
  static const String NEW_LOCATION_NAME = 'newLocationName';
  static const String BEFORE_DEPARTMENT_ID = 'beforeDepartmentId';
  static const String BEFORE_DEPARTMENT_CODE = 'beforeDepartmentCode';
  static const String BEFORE_DEPARTMENT_NAME = 'beforeDepartmentName';
  static const String NEW_DEPARTMENT_ID = 'newDepartmentId';
  static const String NEW_DEPARTMENT_CODE = 'newDepartmentCode';
  static const String NEW_DEPARTMENT_NAME = 'newDepartmentName';
  static const String CHECK_DATE = 'checkDate';
  static const String STATUS_CHECK = 'statusCheck';
  static const String STATUS_NAME = 'statusName';
  static const String REMARK = 'remark';
  static const String QTY = 'qty';
}
