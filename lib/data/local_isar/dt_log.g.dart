// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dt_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDtLogCollection on Isar {
  IsarCollection<DtLog> get dtLogs => this.collection();
}

const DtLogSchema = CollectionSchema(
  name: r'DtLog',
  id: 4946085770645157293,
  properties: {
    r'color': PropertySchema(
      id: 0,
      name: r'color',
      type: IsarType.string,
    ),
    r'finishedAt': PropertySchema(
      id: 1,
      name: r'finishedAt',
      type: IsarType.dateTime,
    ),
    r'hasFinished': PropertySchema(
      id: 2,
      name: r'hasFinished',
      type: IsarType.bool,
    ),
    r'lastAttemptedAt': PropertySchema(
      id: 3,
      name: r'lastAttemptedAt',
      type: IsarType.dateTime,
    ),
    r'requestedAt': PropertySchema(
      id: 4,
      name: r'requestedAt',
      type: IsarType.dateTime,
    ),
    r'retryCount': PropertySchema(
      id: 5,
      name: r'retryCount',
      type: IsarType.long,
    )
  },
  estimateSize: _dtLogEstimateSize,
  serialize: _dtLogSerialize,
  deserialize: _dtLogDeserialize,
  deserializeProp: _dtLogDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _dtLogGetId,
  getLinks: _dtLogGetLinks,
  attach: _dtLogAttach,
  version: '3.1.0+1',
);

int _dtLogEstimateSize(
  DtLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.color;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _dtLogSerialize(
  DtLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.color);
  writer.writeDateTime(offsets[1], object.finishedAt);
  writer.writeBool(offsets[2], object.hasFinished);
  writer.writeDateTime(offsets[3], object.lastAttemptedAt);
  writer.writeDateTime(offsets[4], object.requestedAt);
  writer.writeLong(offsets[5], object.retryCount);
}

DtLog _dtLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DtLog();
  object.color = reader.readStringOrNull(offsets[0]);
  object.finishedAt = reader.readDateTimeOrNull(offsets[1]);
  object.hasFinished = reader.readBoolOrNull(offsets[2]);
  object.id = id;
  object.lastAttemptedAt = reader.readDateTimeOrNull(offsets[3]);
  object.requestedAt = reader.readDateTimeOrNull(offsets[4]);
  object.retryCount = reader.readLongOrNull(offsets[5]);
  return object;
}

P _dtLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dtLogGetId(DtLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dtLogGetLinks(DtLog object) {
  return [];
}

void _dtLogAttach(IsarCollection<dynamic> col, Id id, DtLog object) {
  object.id = id;
}

extension DtLogQueryWhereSort on QueryBuilder<DtLog, DtLog, QWhere> {
  QueryBuilder<DtLog, DtLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DtLogQueryWhere on QueryBuilder<DtLog, DtLog, QWhereClause> {
  QueryBuilder<DtLog, DtLog, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<DtLog, DtLog, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterWhereClause> idBetween(
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

extension DtLogQueryFilter on QueryBuilder<DtLog, DtLog, QFilterCondition> {
  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> colorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> colorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> colorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> colorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> colorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> colorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> colorContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> colorMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'color',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> finishedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'finishedAt',
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> finishedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'finishedAt',
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> finishedAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> finishedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'finishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> finishedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'finishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> finishedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'finishedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> hasFinishedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hasFinished',
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> hasFinishedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hasFinished',
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> hasFinishedEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasFinished',
        value: value,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> lastAttemptedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastAttemptedAt',
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> lastAttemptedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastAttemptedAt',
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> lastAttemptedAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastAttemptedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> lastAttemptedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastAttemptedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> lastAttemptedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastAttemptedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> lastAttemptedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastAttemptedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> requestedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'requestedAt',
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> requestedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'requestedAt',
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> requestedAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requestedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> requestedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'requestedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> requestedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'requestedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> requestedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'requestedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> retryCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'retryCount',
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> retryCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'retryCount',
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> retryCountEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'retryCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> retryCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'retryCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> retryCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'retryCount',
        value: value,
      ));
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterFilterCondition> retryCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'retryCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DtLogQueryObject on QueryBuilder<DtLog, DtLog, QFilterCondition> {}

extension DtLogQueryLinks on QueryBuilder<DtLog, DtLog, QFilterCondition> {}

extension DtLogQuerySortBy on QueryBuilder<DtLog, DtLog, QSortBy> {
  QueryBuilder<DtLog, DtLog, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> sortByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.asc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> sortByFinishedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.desc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> sortByHasFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFinished', Sort.asc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> sortByHasFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFinished', Sort.desc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> sortByLastAttemptedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptedAt', Sort.asc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> sortByLastAttemptedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptedAt', Sort.desc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> sortByRequestedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestedAt', Sort.asc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> sortByRequestedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestedAt', Sort.desc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> sortByRetryCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retryCount', Sort.asc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> sortByRetryCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retryCount', Sort.desc);
    });
  }
}

extension DtLogQuerySortThenBy on QueryBuilder<DtLog, DtLog, QSortThenBy> {
  QueryBuilder<DtLog, DtLog, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> thenByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.asc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> thenByFinishedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.desc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> thenByHasFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFinished', Sort.asc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> thenByHasFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFinished', Sort.desc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> thenByLastAttemptedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptedAt', Sort.asc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> thenByLastAttemptedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptedAt', Sort.desc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> thenByRequestedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestedAt', Sort.asc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> thenByRequestedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestedAt', Sort.desc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> thenByRetryCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retryCount', Sort.asc);
    });
  }

  QueryBuilder<DtLog, DtLog, QAfterSortBy> thenByRetryCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'retryCount', Sort.desc);
    });
  }
}

extension DtLogQueryWhereDistinct on QueryBuilder<DtLog, DtLog, QDistinct> {
  QueryBuilder<DtLog, DtLog, QDistinct> distinctByColor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DtLog, DtLog, QDistinct> distinctByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finishedAt');
    });
  }

  QueryBuilder<DtLog, DtLog, QDistinct> distinctByHasFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasFinished');
    });
  }

  QueryBuilder<DtLog, DtLog, QDistinct> distinctByLastAttemptedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastAttemptedAt');
    });
  }

  QueryBuilder<DtLog, DtLog, QDistinct> distinctByRequestedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requestedAt');
    });
  }

  QueryBuilder<DtLog, DtLog, QDistinct> distinctByRetryCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'retryCount');
    });
  }
}

extension DtLogQueryProperty on QueryBuilder<DtLog, DtLog, QQueryProperty> {
  QueryBuilder<DtLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DtLog, String?, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<DtLog, DateTime?, QQueryOperations> finishedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finishedAt');
    });
  }

  QueryBuilder<DtLog, bool?, QQueryOperations> hasFinishedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasFinished');
    });
  }

  QueryBuilder<DtLog, DateTime?, QQueryOperations> lastAttemptedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastAttemptedAt');
    });
  }

  QueryBuilder<DtLog, DateTime?, QQueryOperations> requestedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requestedAt');
    });
  }

  QueryBuilder<DtLog, int?, QQueryOperations> retryCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'retryCount');
    });
  }
}
