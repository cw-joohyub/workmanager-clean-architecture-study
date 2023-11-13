// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dt_task.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDtTaskCollection on Isar {
  IsarCollection<DtTask> get dtTasks => this.collection();
}

const DtTaskSchema = CollectionSchema(
  name: r'DtTask',
  id: -6076228929338314591,
  properties: {
    r'dateTime': PropertySchema(
      id: 0,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'eventType': PropertySchema(
      id: 1,
      name: r'eventType',
      type: IsarType.byte,
      enumMap: _DtTaskeventTypeEnumValueMap,
    ),
    r'taskKey': PropertySchema(
      id: 2,
      name: r'taskKey',
      type: IsarType.string,
    ),
    r'taskStatus': PropertySchema(
      id: 3,
      name: r'taskStatus',
      type: IsarType.byte,
      enumMap: _DtTasktaskStatusEnumValueMap,
    )
  },
  estimateSize: _dtTaskEstimateSize,
  serialize: _dtTaskSerialize,
  deserialize: _dtTaskDeserialize,
  deserializeProp: _dtTaskDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _dtTaskGetId,
  getLinks: _dtTaskGetLinks,
  attach: _dtTaskAttach,
  version: '3.1.0+1',
);

int _dtTaskEstimateSize(
  DtTask object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.taskKey.length * 3;
  return bytesCount;
}

void _dtTaskSerialize(
  DtTask object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateTime);
  writer.writeByte(offsets[1], object.eventType.index);
  writer.writeString(offsets[2], object.taskKey);
  writer.writeByte(offsets[3], object.taskStatus.index);
}

DtTask _dtTaskDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DtTask(
    dateTime: reader.readDateTime(offsets[0]),
    eventType:
        _DtTaskeventTypeValueEnumMap[reader.readByteOrNull(offsets[1])] ??
            EventType.red,
    taskKey: reader.readString(offsets[2]),
    taskStatus:
        _DtTasktaskStatusValueEnumMap[reader.readByteOrNull(offsets[3])] ??
            TaskStatus.open,
  );
  object.id = id;
  return object;
}

P _dtTaskDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (_DtTaskeventTypeValueEnumMap[reader.readByteOrNull(offset)] ??
          EventType.red) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (_DtTasktaskStatusValueEnumMap[reader.readByteOrNull(offset)] ??
          TaskStatus.open) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _DtTaskeventTypeEnumValueMap = {
  'red': 0,
  'black': 1,
};
const _DtTaskeventTypeValueEnumMap = {
  0: EventType.red,
  1: EventType.black,
};
const _DtTasktaskStatusEnumValueMap = {
  'open': 0,
  'inProgress': 1,
  'done': 2,
  'canceled': 3,
};
const _DtTasktaskStatusValueEnumMap = {
  0: TaskStatus.open,
  1: TaskStatus.inProgress,
  2: TaskStatus.done,
  3: TaskStatus.canceled,
};

Id _dtTaskGetId(DtTask object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dtTaskGetLinks(DtTask object) {
  return [];
}

void _dtTaskAttach(IsarCollection<dynamic> col, Id id, DtTask object) {
  object.id = id;
}

extension DtTaskQueryWhereSort on QueryBuilder<DtTask, DtTask, QWhere> {
  QueryBuilder<DtTask, DtTask, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DtTaskQueryWhere on QueryBuilder<DtTask, DtTask, QWhereClause> {
  QueryBuilder<DtTask, DtTask, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DtTaskQueryFilter on QueryBuilder<DtTask, DtTask, QFilterCondition> {
  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> dateTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> dateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> dateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> dateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> eventTypeEqualTo(
      EventType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventType',
        value: value,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> eventTypeGreaterThan(
    EventType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eventType',
        value: value,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> eventTypeLessThan(
    EventType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eventType',
        value: value,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> eventTypeBetween(
    EventType lower,
    EventType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eventType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> taskKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> taskKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taskKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> taskKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taskKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> taskKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taskKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> taskKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'taskKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> taskKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'taskKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> taskKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'taskKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> taskKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'taskKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> taskKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskKey',
        value: '',
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> taskKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'taskKey',
        value: '',
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> taskStatusEqualTo(
      TaskStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> taskStatusGreaterThan(
    TaskStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taskStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> taskStatusLessThan(
    TaskStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taskStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterFilterCondition> taskStatusBetween(
    TaskStatus lower,
    TaskStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taskStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DtTaskQueryObject on QueryBuilder<DtTask, DtTask, QFilterCondition> {}

extension DtTaskQueryLinks on QueryBuilder<DtTask, DtTask, QFilterCondition> {}

extension DtTaskQuerySortBy on QueryBuilder<DtTask, DtTask, QSortBy> {
  QueryBuilder<DtTask, DtTask, QAfterSortBy> sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> sortByEventType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventType', Sort.asc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> sortByEventTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventType', Sort.desc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> sortByTaskKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskKey', Sort.asc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> sortByTaskKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskKey', Sort.desc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> sortByTaskStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskStatus', Sort.asc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> sortByTaskStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskStatus', Sort.desc);
    });
  }
}

extension DtTaskQuerySortThenBy on QueryBuilder<DtTask, DtTask, QSortThenBy> {
  QueryBuilder<DtTask, DtTask, QAfterSortBy> thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> thenByEventType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventType', Sort.asc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> thenByEventTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventType', Sort.desc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> thenByTaskKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskKey', Sort.asc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> thenByTaskKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskKey', Sort.desc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> thenByTaskStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskStatus', Sort.asc);
    });
  }

  QueryBuilder<DtTask, DtTask, QAfterSortBy> thenByTaskStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskStatus', Sort.desc);
    });
  }
}

extension DtTaskQueryWhereDistinct on QueryBuilder<DtTask, DtTask, QDistinct> {
  QueryBuilder<DtTask, DtTask, QDistinct> distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<DtTask, DtTask, QDistinct> distinctByEventType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventType');
    });
  }

  QueryBuilder<DtTask, DtTask, QDistinct> distinctByTaskKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DtTask, DtTask, QDistinct> distinctByTaskStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskStatus');
    });
  }
}

extension DtTaskQueryProperty on QueryBuilder<DtTask, DtTask, QQueryProperty> {
  QueryBuilder<DtTask, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DtTask, DateTime, QQueryOperations> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<DtTask, EventType, QQueryOperations> eventTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventType');
    });
  }

  QueryBuilder<DtTask, String, QQueryOperations> taskKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskKey');
    });
  }

  QueryBuilder<DtTask, TaskStatus, QQueryOperations> taskStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskStatus');
    });
  }
}
