import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'package:recepies/entities/recepie.dart' as e;

part 'database.g.dart';

class Recepies extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 30)();
  TextColumn get body => text()();
}

class Ingredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(max: 30)();
}

@DataClassName("RecepieToIngredient")
class RecepiesToIngredients extends Table {
  IntColumn get recepieId => integer().customConstraint('REFERENCES recepies(id)')();
  IntColumn get ingredientId => integer().customConstraint('REFERENCES ingredients(id)')();
  IntColumn get amount => integer()();
}

@UseMoor(tables: [Recepies, Ingredients, RecepiesToIngredients], daos: [RecepiesDao, SmallRecepiesDao, IngredientsDao])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'recepies.sb'));

  @override
  int get schemaVersion => 2;
}

@UseDao(tables: [Recepies])
class SmallRecepiesDao extends DatabaseAccessor<MyDatabase> with _$SmallRecepiesDaoMixin {
  SmallRecepiesDao(MyDatabase db) : super(db);

  Future<List<e.SmallRecepie>> getAll() => select(recepies).get().then((l) => l.map((r) => r.into()).toList());
  Stream<List<e.SmallRecepie>> watchAll() => select(recepies).watch().map((l) => l.map((r) => r.into()).toList());
}

@UseDao(tables: [Recepies, Ingredients, RecepiesToIngredients])
class RecepiesDao extends DatabaseAccessor<MyDatabase> with _$RecepiesDaoMixin {
  RecepiesDao(MyDatabase db) : super(db);

  Future<e.Recepie> getById(int id) async {
    var recepieFut = (select(recepies)..where((r) => r.id.equals(id))).getSingle();
    var ingredientFut = getIngredients(id);
    return _makeRecepie(await recepieFut, await ingredientFut);
  }

  Future<e.Recepie> insertRecepie(e.Recepie recepie) {
    assert(recepie.id == null);
    return db.transaction(() async {
      var id = await into(recepies).insert(RecepiesCompanion(title: Value(recepie.title), body: Value(recepie.body)));
      Future.wait(
          recepie.ingredients.entries.map((entry) => into(recepiesToIngredients)
              .insert(RecepieToIngredient(recepieId: id, ingredientId: entry.key.id, amount: entry.value))),
          eagerError: true);
      return e.Recepie(id: id, title: recepie.title, body: recepie.body, ingredients: recepie.ingredients);
    });
  }

  Future<int> deleteRecepie(e.Recepie recepie) =>
      delete(recepies).delete(RecepiesCompanion(id: Value(recepie.id), title: Value(recepie.title)));

  Future<Map<e.Ingredient, int>> getIngredients(int recepieId) => (select(recepiesToIngredients)
          .join([innerJoin(ingredients, ingredients.id.equalsExp(recepiesToIngredients.ingredientId))])
            ..where(recepiesToIngredients.recepieId.equals(recepieId)))
      .get()
      .then((rows) => Map.fromIterable(rows,
          key: (row) => (row as TypedResult).readTable(ingredients).into(),
          value: (row) => (row as TypedResult).readTable(recepiesToIngredients).amount));
  // rows.map((row) => MapEntry(row.readTable(ingredients).into(), row.readTable(recepiesToIngredients).amount))));

  Stream<Map<e.Ingredient, int>> watchIngredients(int recepieId) => (select(recepiesToIngredients)
          .join([innerJoin(ingredients, ingredients.id.equalsExp(recepiesToIngredients.ingredientId))])
            ..where(recepiesToIngredients.recepieId.equals(recepieId)))
      .watch()
      .map((rows) => Map.fromIterable(rows,
          key: (row) => (row as TypedResult).readTable(ingredients).into(),
          value: (row) => (row as TypedResult).readTable(recepiesToIngredients).amount));

  ///adds ingredients of [Recepie] references by recepieId to [ingredients] (keeps old ingredients, if any exist)
  ///requires ingredients to already exist in database
  Future<void> addIngredients(int recepieId, Map<e.Ingredient, int> theIngredients) => db.batch((b) {
        b.insertAll(recepiesToIngredients, [
          for (var entry in theIngredients.entries)
            RecepieToIngredient(recepieId: recepieId, ingredientId: entry.key.id, amount: entry.value)
        ]);
      });
}

@UseDao(tables: [Ingredients])
class IngredientsDao extends DatabaseAccessor<MyDatabase> with _$IngredientsDaoMixin {
  IngredientsDao(MyDatabase db) : super(db);

  Future<List<e.Ingredient>> getAll() => select(ingredients).get().then((l) => l.map((ing) => ing.into()).toList());
  Stream<List<e.Ingredient>> watchAll() => select(ingredients).watch().map((l) => l.map((ing) => ing.into()).toList());

  Future<e.Ingredient> insertIngredient(e.Ingredient ingredient) async {
    var id = await into(ingredients).insert(ingredient.into());
    return e.Ingredient(id: id, name: ingredient.name);
  }

  Future<int> deleteIngredient(e.Ingredient ingredient) => delete(ingredients).delete(ingredient.into());
}

// -- Extensions --

extension on Recepie {
  e.SmallRecepie into() => e.SmallRecepie(id: this.id, title: this.title);
}

extension on Ingredient {
  e.Ingredient into() => e.Ingredient(id: this.id, name: this.name);
}

extension on e.Ingredient {
  Ingredient into() => Ingredient(id: id, name: name);
}

e.Recepie _makeRecepie(Recepie r, Map<e.Ingredient, int> ings) =>
    e.Recepie(id: r.id, title: r.title, body: r.body, ingredients: ings);
