// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../datasource.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class DocTypeGroup extends DataClass implements Insertable<DocTypeGroup> {
  final String? typeGroupId;
  final String? typeGroupNm;
  final String useYn;
  const DocTypeGroup({this.typeGroupId, this.typeGroupNm, required this.useYn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || typeGroupId != null) {
      map['type_group_id'] = Variable<String>(typeGroupId);
    }
    if (!nullToAbsent || typeGroupNm != null) {
      map['type_group_nm'] = Variable<String>(typeGroupNm);
    }
    map['use_yn'] = Variable<String>(useYn);
    return map;
  }

  DocTypeGroupsCompanion toCompanion(bool nullToAbsent) {
    return DocTypeGroupsCompanion(
      typeGroupId: typeGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(typeGroupId),
      typeGroupNm: typeGroupNm == null && nullToAbsent
          ? const Value.absent()
          : Value(typeGroupNm),
      useYn: Value(useYn),
    );
  }

  factory DocTypeGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocTypeGroup(
      typeGroupId: serializer.fromJson<String?>(json['typeGroupId']),
      typeGroupNm: serializer.fromJson<String?>(json['typeGroupNm']),
      useYn: serializer.fromJson<String>(json['useYn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'typeGroupId': serializer.toJson<String?>(typeGroupId),
      'typeGroupNm': serializer.toJson<String?>(typeGroupNm),
      'useYn': serializer.toJson<String>(useYn),
    };
  }

  DocTypeGroup copyWith(
          {Value<String?> typeGroupId = const Value.absent(),
          Value<String?> typeGroupNm = const Value.absent(),
          String? useYn}) =>
      DocTypeGroup(
        typeGroupId: typeGroupId.present ? typeGroupId.value : this.typeGroupId,
        typeGroupNm: typeGroupNm.present ? typeGroupNm.value : this.typeGroupNm,
        useYn: useYn ?? this.useYn,
      );
  @override
  String toString() {
    return (StringBuffer('DocTypeGroup(')
          ..write('typeGroupId: $typeGroupId, ')
          ..write('typeGroupNm: $typeGroupNm, ')
          ..write('useYn: $useYn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(typeGroupId, typeGroupNm, useYn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocTypeGroup &&
          other.typeGroupId == this.typeGroupId &&
          other.typeGroupNm == this.typeGroupNm &&
          other.useYn == this.useYn);
}

class DocTypeGroupsCompanion extends UpdateCompanion<DocTypeGroup> {
  final Value<String?> typeGroupId;
  final Value<String?> typeGroupNm;
  final Value<String> useYn;
  const DocTypeGroupsCompanion({
    this.typeGroupId = const Value.absent(),
    this.typeGroupNm = const Value.absent(),
    this.useYn = const Value.absent(),
  });
  DocTypeGroupsCompanion.insert({
    this.typeGroupId = const Value.absent(),
    this.typeGroupNm = const Value.absent(),
    required String useYn,
  }) : useYn = Value(useYn);
  static Insertable<DocTypeGroup> custom({
    Expression<String>? typeGroupId,
    Expression<String>? typeGroupNm,
    Expression<String>? useYn,
  }) {
    return RawValuesInsertable({
      if (typeGroupId != null) 'type_group_id': typeGroupId,
      if (typeGroupNm != null) 'type_group_nm': typeGroupNm,
      if (useYn != null) 'use_yn': useYn,
    });
  }

  DocTypeGroupsCompanion copyWith(
      {Value<String?>? typeGroupId,
      Value<String?>? typeGroupNm,
      Value<String>? useYn}) {
    return DocTypeGroupsCompanion(
      typeGroupId: typeGroupId ?? this.typeGroupId,
      typeGroupNm: typeGroupNm ?? this.typeGroupNm,
      useYn: useYn ?? this.useYn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (typeGroupId.present) {
      map['type_group_id'] = Variable<String>(typeGroupId.value);
    }
    if (typeGroupNm.present) {
      map['type_group_nm'] = Variable<String>(typeGroupNm.value);
    }
    if (useYn.present) {
      map['use_yn'] = Variable<String>(useYn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocTypeGroupsCompanion(')
          ..write('typeGroupId: $typeGroupId, ')
          ..write('typeGroupNm: $typeGroupNm, ')
          ..write('useYn: $useYn')
          ..write(')'))
        .toString();
  }
}

class $DocTypeGroupsTable extends DocTypeGroups
    with TableInfo<$DocTypeGroupsTable, DocTypeGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocTypeGroupsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _typeGroupIdMeta =
      const VerificationMeta('typeGroupId');
  @override
  late final GeneratedColumn<String> typeGroupId = GeneratedColumn<String>(
      'type_group_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: 'UNIQUE');
  final VerificationMeta _typeGroupNmMeta =
      const VerificationMeta('typeGroupNm');
  @override
  late final GeneratedColumn<String> typeGroupNm = GeneratedColumn<String>(
      'type_group_nm', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _useYnMeta = const VerificationMeta('useYn');
  @override
  late final GeneratedColumn<String> useYn = GeneratedColumn<String>(
      'use_yn', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [typeGroupId, typeGroupNm, useYn];
  @override
  String get aliasedName => _alias ?? 'doc_type_groups';
  @override
  String get actualTableName => 'doc_type_groups';
  @override
  VerificationContext validateIntegrity(Insertable<DocTypeGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('type_group_id')) {
      context.handle(
          _typeGroupIdMeta,
          typeGroupId.isAcceptableOrUnknown(
              data['type_group_id']!, _typeGroupIdMeta));
    }
    if (data.containsKey('type_group_nm')) {
      context.handle(
          _typeGroupNmMeta,
          typeGroupNm.isAcceptableOrUnknown(
              data['type_group_nm']!, _typeGroupNmMeta));
    }
    if (data.containsKey('use_yn')) {
      context.handle(
          _useYnMeta, useYn.isAcceptableOrUnknown(data['use_yn']!, _useYnMeta));
    } else if (isInserting) {
      context.missing(_useYnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  DocTypeGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocTypeGroup(
      typeGroupId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}type_group_id']),
      typeGroupNm: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}type_group_nm']),
      useYn: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}use_yn'])!,
    );
  }

  @override
  $DocTypeGroupsTable createAlias(String alias) {
    return $DocTypeGroupsTable(attachedDatabase, alias);
  }
}

abstract class _$LocalDataBase extends GeneratedDatabase {
  _$LocalDataBase(QueryExecutor e) : super(e);
  late final $DocTypeGroupsTable docTypeGroups = $DocTypeGroupsTable(this);
  late final DocTypeDao docTypeDao = DocTypeDao(this as LocalDataBase);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [docTypeGroups];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}
