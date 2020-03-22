import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:recepies/entities/recepie.dart';
import 'package:recepies/model/recepie_store.dart';
import 'package:recepies/ui/shopping_list.dart';

import 'recepie_form.dart';
import 'recepie_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  RecepieStore _store = GetIt.I<RecepieStore>();

  List<Tab> _tabs = [
    Tab(
      text: "Home",
    ),
    Tab(
      text: "List",
    )
  ];

  List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      Observer(builder: (_) {
        final stream = _store.homepageEntries;
        if (stream.value != null) {
          return RecepieList(stream.value);
        } else {
          return !stream.hasError
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Text("Error: ${stream.error}");
        }
      }),
      Observer(builder: (_) {
        final shoppingListFuture = _store.totalIngredients;
        return FutureBuilder(
            future: shoppingListFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ShoppingList(snapshot.data);
            });
      }),
    ];
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rezepte App"),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.push(context, MaterialPageRoute<Recepie>(builder: (_) => RecepieForm()));
          if (result != null) {
            _store.addRecepie(result);
          }
        },
      ),
    );
  }
}
