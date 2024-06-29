import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app_state_management/models/cart.dart';
import 'package:simple_app_state_management/models/catalog.dart';

class CartScreen extends StatelessWidget {
   const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    return Scaffold(
      appBar: AppBar(
        title:  Text("Cart",
          style: Theme.of(context).textTheme.displayLarge,
        )
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index){
                return _MyCartList(index: index, listItem: cart.items);
              },
            ),
          ),
            const Divider(height: 4, color: Colors.black),
          _CartTotal()
          
        ]
        )
      )

    );
  }
}


class _MyCartList extends StatelessWidget {
  final int index;
  final List listItem;
  const _MyCartList({super.key, required this.index, required this.listItem});

  @override
  Widget build(BuildContext context) {
    
    return ListTile(
      leading:  const Icon(Icons.done),
      title: Text(listItem[index].name),
      trailing:  IconButton(
        icon: const Icon(Icons.remove_circle_outline),
        onPressed: (){
          context.read<CartModel>().remove(listItem[index]);
        },
      ),

    );
  }
}


class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Another way to listen to a model's change is to include
            // the Consumer widget. This widget will automatically listen
            // to CartModel and rerun its builder on every change.
            //
            // The important thing is that it will not rebuild
            // the rest of the widgets in this build method.
            Consumer<CartModel>(
                builder: (context, cart, child) =>
                    Text('\$${cart.totalPrice}', style: hugeStyle)),
            const SizedBox(width: 24),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Buying not supported yet.')));
              },
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('BUY')
            ),
          ],
        ),
      ),
    );
  }
}