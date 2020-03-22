import 'package:mobx/mobx.dart';
import 'package:recepies/data/database.dart' show MyDatabase;
import 'package:recepies/entities/recepie.dart';

part 'recepie_store.g.dart';

class RecepieStore = _RecepieStore with _$RecepieStore;

abstract class _RecepieStore with Store {
  final MyDatabase _db;

  _RecepieStore(this._db) {
    homepageEntries = ObservableStream(_db.smallRecepiesDao.watchAll());
  }

  ObservableStream<List<SmallRecepie>> homepageEntries;

  ObservableSet<SmallRecepie> selected = ObservableSet();

  @computed
  Future<Map<Ingredient, int>> get totalIngredients async {
    Map<Ingredient, int> result = Map();
    final ingredientList = await Future.wait(selected.map((recepie) => _db.recepiesDao.getIngredients(recepie.id)));
    ingredientList.forEach((element) =>
        element.forEach((key, value) => result.containsKey(key) ? result[key] += value : result[key] = value));
    return result;
  }

  Future<void> addRecepie(Recepie recepie) => _db.recepiesDao.insertRecepie(recepie);
  //Future<bool> updateRecepie(Recepie recepie) => _db.recepiesDao.updateRecepie(recepie);
  Future<int> deleteRecepie(Recepie recepie) => _db.recepiesDao.deleteRecepie(recepie);

  Future<Recepie> getFullRecepie(SmallRecepie recepie) => _db.recepiesDao.getById(recepie.id);
}
