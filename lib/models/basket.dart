class Basket {
  final List<BasketItem>? basket;
  final String delivery;
  final String id;
  final int total;

  const Basket(
      {this.basket,
      required this.delivery,
      required this.id,
      required this.total});
  // "delivery": "Free",
  // "id": "4",
  // "total": 3300

}

class BasketItem {
  final int id;
  final String images;
  final int price;
  final String title;

  const BasketItem({
    required this.id,
    required this.images,
    required this.price,
    required this.title,
  });

  // "id": 1,
  // "images": "https://www.manualspdf.ru/thumbs/products/l/1260237-samsung-galaxy-note-20-ultra.jpg",
  // "price": 1500,
  // "title": "Galaxy Note 20 Ultra"

  factory BasketItem.fromMap(Map<String, dynamic> map) {
    return BasketItem(
      id: map['id'] ?? '',
      images: map['images'] ?? '',
      price: map['price'] as int,
      title: map['title'] ?? '',
    );
  }
}
