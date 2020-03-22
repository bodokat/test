import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:optional/optional_internal.dart';

import 'package:recepies/entities/recepie.dart';
import 'package:recepies/model/ingredient_store.dart';

class RecepieForm extends StatefulWidget {
  RecepieForm({Key key}) : super(key: key);

  @override
  _RecepieFormState createState() => _RecepieFormState();
}

class _RecepieFormState extends State<RecepieForm> {
  var _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Recepie"),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FormBuilderTextField(
                attribute: "title",
                decoration: InputDecoration(labelText: "Title"),
                validators: [FormBuilderValidators.required()],
              ),
              FormBuilderTextField(
                attribute: "body",
                decoration: InputDecoration(labelText: "Body"),
                validators: [FormBuilderValidators.required()],
              ),
              FormBuilderCustomField(
                attribute: "ingredients",
                formField: FormField(
                  builder: _buildIngredientForm,
                ),
                initialValue: Map<Ingredient, int>(),
                validators: [FormBuilderValidators.required()],
              )
            ],
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton(
          child: Text("OK"),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              String title = _formKey.currentState.value["title"];
              String body = _formKey.currentState.value["body"];
              Map<Ingredient, int> ingredients = _formKey.currentState.value["ingredients"];
              assert([title, body, ingredients].every((element) => element != null));
              Navigator.pop(context, Recepie(id: null, title: title, body: body, ingredients: ingredients));
            }
          },
        ),
      ],
    );
  }
}

Widget _buildIngredientForm(FormFieldState<Map<Ingredient, int>> field) {
  return ListView(
    children: <Widget>[
      ...field.value.entries.map((e) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Expanded(
                  child: Text(
                e.key.name,
                overflow: TextOverflow.ellipsis,
              )),
              Container(
                child: TextField(
                  controller: TextEditingController.fromValue(TextEditingValue(text: e.value.toString())),
                  onChanged: (s) {
                    field.value[e.key] = int.parse(s);
                  },
                ),
                width: 64,
              ),
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: () {
                  field.value.remove(e.key);
                  field.didChange(field.value);
                },
              )
            ]),
          )),
      IngredientRow(
        onSubmit: (ing, amount) {
          field.value[ing] = amount;
          field.didChange(field.value);
        },
      )
    ],
    shrinkWrap: true,
  );
}

class IngredientRow extends StatefulWidget {
  const IngredientRow({
    Key key,
    @required this.onSubmit,
  }) : super(key: key);

  final void Function(Ingredient, int) onSubmit;

  @override
  _IngredientRowState createState() => _IngredientRowState();
}

class _IngredientRowState extends State<IngredientRow> {
  var _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Flexible(
            child: IngredientDropdown(),
            fit: FlexFit.loose,
          ),
          Container(
            child: FormBuilderTextField(
              attribute: "amount",
              keyboardType: TextInputType.number,
              validators: [
                FormBuilderValidators.required(errorText: null),
                FormBuilderValidators.numeric(errorText: null)
              ],
            ),
            width: 64,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              if (_formKey.currentState.saveAndValidate()) {
                Ingredient ing = _formKey.currentState.value["ingredient"];
                int amount = int.parse(_formKey.currentState.value["amount"]);
                widget.onSubmit(ing, amount);
              }
            },
          )
        ]),
      ),
    );
  }
}

class IngredientDropdown extends StatefulWidget {
  IngredientDropdown({
    Key key,
  }) : super(key: key);

  @override
  _IngredientDropdownState createState() => _IngredientDropdownState();
}

class _IngredientDropdownState extends State<IngredientDropdown> {
  final Observable<Ingredient> _current = Observable(null);

  var store = GetIt.I<IngredientStore>();

  @override
  Widget build(BuildContext context) {
    return FormBuilderCustomField(
        attribute: "ingredient",
        validators: [FormBuilderValidators.required()],
        formField: FormField(builder: (field) {
          return Observer(builder: (context) {
            final stream = store.allIngredients;

            // Loading or error

            if (stream.hasError) {
              Navigator.pop(context, null);
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("could not get ingredients: ${stream.error}")));
            }
            if (stream.value == null)
              return DropdownButton(
                hint: Text("Loading..."),
                items: null,
                onChanged: null,
              );

            final allIngredients = stream.value;
            return DropdownButton<Optional<Ingredient>>(
                isExpanded: true,
                value: allIngredients.contains(_current.value) ? _current.value.toOptional : null,
                hint: Text("add an ingredient"),
                items: [
                  for (var ingredient in allIngredients)
                    DropdownMenuItem(
                      child: Text(ingredient.name),
                      value: Optional.of(ingredient),
                    ),
                  DropdownMenuItem(value: Optional<Ingredient>.empty(), child: Text("new..."))
                ],
                onChanged: (Optional<Ingredient> val) async {
                  Ingredient ing;
                  if (val.isEmpty) {
                    Ingredient newIngredient = await showAddIngredientDialog(context);
                    if (newIngredient == null) {
                      return;
                    } else {
                      ing = await store.addIngredient(newIngredient);
                    }
                  } else {
                    ing = val.value;
                  }
                  runInAction(() => _current.value = ing);
                  field.didChange(ing);
                });
          });
        }));
  }
}

Future<Ingredient> showAddIngredientDialog(BuildContext context) => showDialog<Ingredient>(
    context: context,
    builder: (context) {
      String ingredientName;
      return AlertDialog(
        title: Text("Create new ingredient"),
        content: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: "Ingredient Name"),
                onChanged: (val) => ingredientName = val,
              ),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context, null),
          ),
          FlatButton(
            child: const Text("Ok"),
            onPressed: () => Navigator.pop(context, Ingredient(id: null, name: ingredientName)),
          )
        ],
      );
    });
