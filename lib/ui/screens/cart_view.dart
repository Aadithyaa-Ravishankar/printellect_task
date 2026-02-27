import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_state.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<AppState>().cartItems;
    if (cart.isEmpty) return const Center(child: Text('Cart is empty'));

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: cart.length,
      separatorBuilder: (ctx, i) => const Divider(),
      itemBuilder: (ctx, i) {
        final c = cart[i];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          title: Text(
            c.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              'Qty: ${c.quantity}  •  \$${(c.price * c.quantity).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 15),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: () => context.read<AppState>().removeFromCart(c.id),
          ),
        );
      },
    );
  }
}
