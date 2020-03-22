// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Recepie extends DataClass implements Insertable<Recepie> {
  final int id;
  final String title;
  final String body;
  Recepie({@required this.id, @required this.title, @required this.body});
  factory Recepie.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Recepie(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      body: stringType.mapFromDatabaseResponse(data['${effectivePrefix}body']),
    );
  }
  factory Recepie.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Recepie(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
    };
  }

  @override
  RecepiesCompanion createCompanion(bool nullToAbsent) {
    return RecepiesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
    );
  }

  Recepie copyWith({int id, String title, String body}) => Recepie(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
      );
  @override
  String toString() {
    return (StringBuffer('Recepie(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(title.hashCode, body.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Recepie &&
          other.id == this.id &&
          other.title == this.title &&
          other.body == this.body);
}

class RecepiesCompanion extends UpdateCompanion<Recepie> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> body;
  const RecepiesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
  });
  RecepiesCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    @required String body,
  })  : title = Value(title),
        body = Value(body);
  RecepiesCompanion copyWith(
      {Value<int> id, Value<String> title, Value<String> body}) {
    return RecepiesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}

class $RecepiesTable extends Recepies with TableInfo<$RecepiesTable, Recepie> {
  final GeneratedDatabase _db;
  final String _alias;
  $RecepiesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false,
        minTextLength: 1, maxTextLength: 30);
  }

  final VerificationMeta _bodyMeta = const VerificationMeta('body');
  GeneratedTextColumn _body;
  @override
  GeneratedTextColumn get body => _body ??= _constructBody();
  GeneratedTextColumn _constructBody() {
    return GeneratedTextColumn(
      'body',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, title, body];
  @override
  $RecepiesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'recepies';
  @override
  final String actualTableName = 'recepies';
  @override
  VerificationContext validateIntegrity(RecepiesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (d.body.present) {
      context.handle(
          _bodyMeta, body.isAcceptableValue(d.body.value, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recepie map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Recepie.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(RecepiesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.body.present) {
      map['body'] = Variable<String, StringType>(d.body.value);
    }
    return map;
  }

  @override
  $RecepiesTable createAlias(String alias) {
    return $RecepiesTable(_db, alias);
  }
}

class Ingredient extends DataClass implements Insertable<Ingredient> {
  final int id;
  final String name;
  Ingredient({@required this.id, @required this.name});
  factory Ingredient.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Ingredient(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory Ingredient.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Ingredient(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  @override
  IngredientsCompanion createCompanion(bool nullToAbsent) {
    return IngredientsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  Ingredient copyWith({int id, String name}) => Ingredient(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Ingredient(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Ingredient && other.id == this.id && other.name == this.name);
}

class IngredientsCompanion extends UpdateCompanion<Ingredient> {
  final Value<int> id;
  final Value<String> name;
  const IngredientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  IngredientsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
  }) : name = Value(name);
  IngredientsCompanion copyWith({Value<int> id, Value<String> name}) {
    return IngredientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

class $IngredientsTable extends Ingredients
    with TableInfo<$IngredientsTable, Ingredient> {
  final GeneratedDatabase _db;
  final String _alias;
  $IngredientsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false, maxTextLength: 30);
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $IngredientsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'ingredients';
  @override
  final String actualTableName = 'ingredients';
  @override
  VerificationContext validateIntegrity(IngredientsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ingredient map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Ingredient.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(IngredientsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    return map;
  }

  @override
  $IngredientsTable createAlias(String alias) {
    return $IngredientsTable(_db, alias);
  }
}

class RecepieToIngredient extends DataClass
    implements Insertable<RecepieToIngredient> {
  final int recepieId;
  final int ingredientId;
  final int amount;
  RecepieToIngredient(
      {@required this.recepieId,
      @required this.ingredientId,
      @required this.amount});
  factory RecepieToIngredient.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return RecepieToIngredient(
      recepieId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}recepie_id']),
      ingredientId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}ingredient_id']),
      amount: intType.mapFromDatabaseResponse(data['${effectivePrefix}amount']),
    );
  }
  factory RecepieToIngredient.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return RecepieToIngredient(
      recepieId: serializer.fromJson<int>(json['recepieId']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'recepieId': serializer.toJson<int>(recepieId),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'amount': serializer.toJson<int>(amount),
    };
  }

  @override
  RecepiesToIngredientsCompanion createCompanion(bool nullToAbsent) {
    return RecepiesToIngredientsCompanion(
      recepieId: recepieId == null && nullToAbsent
          ? const Value.absent()
          : Value(recepieId),
      ingredientId: ingredientId == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredientId),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
    );
  }

  RecepieToIngredient copyWith({int recepieId, int ingredientId, int amount}) =>
      RecepieToIngredient(
        recepieId: recepieId ?? this.recepieId,
        ingredientId: ingredientId ?? this.ingredientId,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('RecepieToIngredient(')
          ..write('recepieId: $recepieId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(recepieId.hashCode, $mrjc(ingredientId.hashCode, amount.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is RecepieToIngredient &&
          other.recepieId == this.recepieId &&
          other.ingredientId == this.ingredientId &&
          other.amount == this.amount);
}

class RecepiesToIngredientsCompanion
    extends UpdateCompanion<RecepieToIngredient> {
  final Value<int> recepieId;
  final Value<int> ingredientId;
  final Value<int> amount;
  const RecepiesToIngredientsCompanion({
    this.recepieId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.amount = const Value.absent(),
  });
  RecepiesToIngredientsCompanion.insert({
    @required int recepieId,
    @required int ingredientId,
    @required int amount,
  })  : recepieId = Value(recepieId),
        ingredientId = Value(ingredientId),
        amount = Value(amount);
  RecepiesToIngredientsCompanion copyWith(
      {Value<int> recepieId, Value<int> ingredientId, Value<int> amount}) {
    return RecepiesToIngredientsCompanion(
      recepieId: recepieId ?? this.recepieId,
      ingredientId: ingredientId ?? this.ingredientId,
      amount: amount ?? this.amount,
    );
  }
}

class $RecepiesToIngredientsTable extends RecepiesToIngredients
    with TableInfo<$RecepiesToIngredientsTable, RecepieToIngredient> {
  final GeneratedDatabase _db;
  final String _alias;
  $RecepiesToIngredientsTable(this._db, [this._alias]);
  final VerificationMeta _recepieIdMeta = const VerificationMeta('recepieId');
  GeneratedIntColumn _recepieId;
  @override
  GeneratedIntColumn get recepieId => _recepieId ??= _constructRecepieId();
  GeneratedIntColumn _constructRecepieId() {
    return GeneratedIntColumn('recepie_id', $tableName, false,
        $customConstraints: 'REFERENCES recepies(id)');
  }

  final VerificationMeta _ingredientIdMeta =
      const VerificationMeta('ingredientId');
  GeneratedIntColumn _ingredientId;
  @override
  GeneratedIntColumn get ingredientId =>
      _ingredientId ??= _constructIngredientId();
  GeneratedIntColumn _constructIngredientId() {
    return GeneratedIntColumn('ingredient_id', $tableName, false,
        $customConstraints: 'REFERENCES ingredients(id)');
  }

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  GeneratedIntColumn _amount;
  @override
  GeneratedIntColumn get amount => _amount ??= _constructAmount();
  GeneratedIntColumn _constructAmount() {
    return GeneratedIntColumn(
      'amount',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [recepieId, ingredientId, amount];
  @override
  $RecepiesToIngredientsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'recepies_to_ingredients';
  @override
  final String actualTableName = 'recepies_to_ingredients';
  @override
  VerificationContext validateIntegrity(RecepiesToIngredientsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.recepieId.present) {
      context.handle(_recepieIdMeta,
          recepieId.isAcceptableValue(d.recepieId.value, _recepieIdMeta));
    } else if (isInserting) {
      context.missing(_recepieIdMeta);
    }
    if (d.ingredientId.present) {
      context.handle(
          _ingredientIdMeta,
          ingredientId.isAcceptableValue(
              d.ingredientId.value, _ingredientIdMeta));
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (d.amount.present) {
      context.handle(
          _amountMeta, amount.isAcceptableValue(d.amount.value, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  RecepieToIngredient map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return RecepieToIngredient.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(RecepiesToIngredientsCompanion d) {
    final map = <String, Variable>{};
    if (d.recepieId.present) {
      map['recepie_id'] = Variable<int, IntType>(d.recepieId.value);
    }
    if (d.ingredientId.present) {
      map['ingredient_id'] = Variable<int, IntType>(d.ingredientId.value);
    }
    if (d.amount.present) {
      map['amount'] = Variable<int, IntType>(d.amount.value);
    }
    return map;
  }

  @override
  $RecepiesToIngredientsTable createAlias(String alias) {
    return $RecepiesToIngredientsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $RecepiesTable _recepies;
  $RecepiesTable get recepies => _recepies ??= $RecepiesTable(this);
  $IngredientsTable _ingredients;
  $IngredientsTable get ingredients => _ingredients ??= $IngredientsTable(this);
  $RecepiesToIngredientsTable _recepiesToIngredients;
  $RecepiesToIngredientsTable get recepiesToIngredients =>
      _recepiesToIngredients ??= $RecepiesToIngredientsTable(this);
  RecepiesDao _recepiesDao;
  RecepiesDao get recepiesDao =>
      _recepiesDao ??= RecepiesDao(this as MyDatabase);
  SmallRecepiesDao _smallRecepiesDao;
  SmallRecepiesDao get smallRecepiesDao =>
      _smallRecepiesDao ??= SmallRecepiesDao(this as MyDatabase);
  IngredientsDao _ingredientsDao;
  IngredientsDao get ingredientsDao =>
      _ingredientsDao ??= IngredientsDao(this as MyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [recepies, ingredients, recepiesToIngredients];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$SmallRecepiesDaoMixin on DatabaseAccessor<MyDatabase> {
  $RecepiesTable get recepies => db.recepies;
}
mixin _$RecepiesDaoMixin on DatabaseAccessor<MyDatabase> {
  $RecepiesTable get recepies => db.recepies;
  $IngredientsTable get ingredients => db.ingredients;
  $RecepiesToIngredientsTable get recepiesToIngredients =>
      db.recepiesToIngredients;
}
mixin _$IngredientsDaoMixin on DatabaseAccessor<MyDatabase> {
  $IngredientsTable get ingredients => db.ingredients;
}
