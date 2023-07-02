import 'package:drift/drift.dart';

// TODO 테이블 명을 지정하지 않으면 DocTypeGroupData로 Data가 붙는다.??
// 아니면 class명에 s 를 붙여서 DocTypeGroups 짓게 되면 DocTypeGroup로 되려나..공식 문서 보니까 그런듯..
class DocTypeGroup extends Table {
  TextColumn get typeGroupId => text().unique().nullable()(); // "타입그룹ID" : BASE
  TextColumn get typeGroupNm => text().nullable()();          // "타입그룹명" : Calendar
  TextColumn get useYn => text().withLength(max: 1)();        // "사용여부"   : Y/N
}
//
// CREATE TABLE `DOC_TYPE_GROUP` (
// `type_group_id`	String	NOT NULL,
// `type_group_nm`	String	NULL,
// `use_yn`	String	NULL
// );
//
// CREATE TABLE `DOC_TYPE` (
// `type_id`	String	NOT NULL,
// `type_group_id`	String	NOT NULL,
// `type_nm`	String	NULL,
// `use_yn`	String	NULL
// );
//
// CREATE TABLE `DOC_TYPE_FORM` (
// `type_form_id`	String	NOT NULL,
// `type_id`	String	NOT NULL,
// `type_form_nm`	String	NULL,
// `type_form_property`	String	NULL,
// `type_form_req`	String	NULL,
// `type_form_order`	Number	NULL,
// `type_form_size`	Number	NULL,
// `use_yn`	String	NULL
// );
//
// CREATE TABLE `ME_BASE` (
// `doc_id`	String	NOT NULL,
// `type_id`	String	NOT NULL,
// `doc_content`	String	NULL,
// `doc_start_dt`	Date	NULL,
// `doc_update_dt`	Date	NULL,
// `done`	String	NULL,
// `start_dt`	Date	NULL,
// `end_date`	Date	NULL
// );
//
// CREATE TABLE `ME_MEMO` (
// `doc_id`	String	NOT NULL,
// `type_id`	String	NOT NULL,
// `doc_content`	String	NULL,
// `doc_start_dt`	Date	NULL,
// `doc_update_dt`	Date	NULL,
// `img_path`	String	NULL
// );
//
// ALTER TABLE `DOC_TYPE_GROUP` ADD CONSTRAINT `PK_DOC_TYPE_GROUP` PRIMARY KEY (
// `type_group_id`
// );
//
// ALTER TABLE `DOC_TYPE` ADD CONSTRAINT `PK_DOC_TYPE` PRIMARY KEY (
// `type_id`,
// `type_group_id`
// );
//
// ALTER TABLE `DOC_TYPE_FORM` ADD CONSTRAINT `PK_DOC_TYPE_FORM` PRIMARY KEY (
// `type_form_id`,
// `type_id`
// );
//
// ALTER TABLE `ME_BASE` ADD CONSTRAINT `PK_ME_BASE` PRIMARY KEY (
// `doc_id`,
// `type_id`
// );
//
// ALTER TABLE `ME_MEMO` ADD CONSTRAINT `PK_ME_MEMO` PRIMARY KEY (
// `doc_id`,
// `type_id`
// );
//
