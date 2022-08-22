class Item {
  final int id;
  final bool is_new;
  final String title;
  final String subtitle;
  final String picture;
  final bool is_buy;

  const Item(
      {required this.id,
      required this.is_new,
      required this.title,
      required this.subtitle,
      required this.picture,
      required this.is_buy});
  // "id": 1,
  // "is_new": true,
  // "title": "Iphone 12",
  // "subtitle": "Súper. Mega. Rápido.",
  // "picture": "https://img.ibxk.com.br/2020/09/23/23104013057475.jpg?w=1120&h=420&mode=crop&scale=both",
  // "is_buy": true

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      is_new: map['is_new'] ?? false,
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      picture: map['picture'] ?? '',
      is_buy: map['is_buy'] as bool,
    );
  }
}
