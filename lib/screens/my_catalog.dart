import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simple_app_state_management/models/cart.dart';
import 'package:simple_app_state_management/models/catalog.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: ListView.builder(
        itemCount: CatalogModel.itemNames.length,
        itemBuilder: (context, index){
          return _MyListItem(index: index);
          
        }
        
      )
    );
  }
}

AppBar appBar(BuildContext context){
  return AppBar(
    title: Text("Catalog",
      style: Theme.of(context).textTheme.displayLarge
    ),
    actions:  [
      GestureDetector(
        onTap: () {
          context.go('/catalog/cart');
        },
        child: const Icon(Icons.shopping_cart)
      )
    ],

  );
}


class _MyListItem extends StatelessWidget {
  int index;
   _MyListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final item = context.select<CatalogModel, Item>((catalog) => catalog.getById(index));
    return ListTile(
            leading: Container(
              height: 20,
              width: 20,
              decoration:  BoxDecoration(color: CatalogModel().getById(index).color),
            ),
            title: 
              Text(item.name)
            ,
            trailing:  _AddButton(item: item),
          );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;
  const  _AddButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isInCart = context.select<CartModel, bool>((cart) => cart.items.contains(item));

    return GestureDetector(
        onTap: () {
          isInCart? null:
            context.read<CartModel>().add(item);
          
          
          
        },
        child:  
          isInCart? const Icon(Icons.done): const Text("ADD")
        
        
        );
  }
}
