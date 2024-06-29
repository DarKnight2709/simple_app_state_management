
import 'package:flutter/material.dart';
import 'package:simple_app_state_management/models/catalog.dart';

class CartModel extends ChangeNotifier{
  final List<int> _itemIds = [];

  late CatalogModel _catalog;

  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog){
    _catalog = newCatalog;
    notifyListeners();
  }

  List<Item> get items => _itemIds.map((id) => catalog.getById(id)).toList();

  int get totalPrice => items.fold(0, (total, current) => total + current.price);

  void add(Item item){
    _itemIds.add(item.id);
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }


}





