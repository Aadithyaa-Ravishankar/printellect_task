import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_state.dart';

class WebCartScreen extends StatelessWidget {
  const WebCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<AppState>().cartItems;
    final email = context.watch<AppState>().email;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Sync ($email)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AppState>().logout(),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(24),
          child: cart.isEmpty
              ? const Center(
                  child: Text(
                    'Your cart is empty. Add items from the mobile app!',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                )
              : ListView.separated(
                  itemCount: cart.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (ctx, i) {
                    final c = cart[i];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      title: Text(
                        c.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Quantity: ${c.quantity}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '\$${(c.price * c.quantity).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                context.read<AppState>().removeFromCart(c.id),
                            tooltip: 'Remove',
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
