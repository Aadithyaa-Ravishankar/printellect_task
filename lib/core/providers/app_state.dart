import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class AppState extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String? email;
  List<Product> products = [];
  List<CartItem> cartItems = [];
  String searchQuery = '';

  List<Product> get filteredProducts => products
      .where((p) => p.title.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();

  void login(String inputEmail) {
    email = inputEmail;
    db.collection('users').doc(email).set({'email': email});
    _loadProducts();
    _listenToCart();
    notifyListeners();
  }

  void logout() {
    email = null;
    cartItems.clear();
    searchQuery = '';
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
  }

  Future<void> _loadProducts() async {
    final snap = await db.collection('products').get();
    products = snap.docs
        .map((doc) => Product.fromMap(doc.id, doc.data()))
        .toList();
    notifyListeners();
  }

  void _listenToCart() {
    if (email == null) return;
    db.collection('cart').doc(email).collection('items').snapshots().listen((
      snap,
    ) {
      cartItems = snap.docs
          .map((doc) => CartItem.fromMap(doc.id, doc.data()))
          .toList();
      notifyListeners();
    });
  }

  Future<void> addToCart(Product p) async {
    if (email == null) return;
    final ref = db.collection('cart').doc(email).collection('items').doc(p.id);
    final doc = await ref.get();
    if (doc.exists) {
      ref.update({'quantity': FieldValue.increment(1)});
    } else {
      ref.set({'title': p.title, 'price': p.price, 'quantity': 1});
    }
  }

  Future<void> removeFromCart(String id) async {
    if (email == null) return;
    await db.collection('cart').doc(email).collection('items').doc(id).delete();
  }
}
