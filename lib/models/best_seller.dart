class BestSeller {
  final int id;
  final bool is_favorites;
  final String title;
  final int price_without_discount;
  final int discount_price;
  final String picture;

  const BestSeller(
      {required this.id,
      required this.is_favorites,
      required this.title,
      required this.price_without_discount,
      required this.discount_price,
      required this.picture});

  // "id": 111,
  // "is_favorites": true,
  // "title": "Samsung Galaxy s20 Ultra",
  // "price_without_discount": 1047,
  // "discount_price": 1500,
  // "picture": "https://shop.gadgetufa.ru/images/upload/52534-smartfon-samsung-galaxy-s20-ultra-12-128-chernyj_1024.jpg"

  factory BestSeller.fromMap(Map<String, dynamic> map) {
    return BestSeller(
      id: map['id'] as int,
      is_favorites: map['is_favorites'] as bool,
      title: map['title'] ?? '',
      price_without_discount: map['price_without_discount'] as int,
      discount_price: map['discount_price'] as int,
      picture: map['picture'] ?? '',
    );
  }
}
