// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem({
    required this.id,
    required this.title,
    this.quantity = 0,
    required this.price,
  });
}
