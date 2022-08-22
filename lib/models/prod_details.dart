class ProductDetails {
  final String CPU;
  final String camera;
  final List<int> capacity;
  final List<String> color;
  final String id;
  final List<String> images;
  final bool isFavorites;
  final int price;
  final double rating;
  final String sd;
  final String ssd;
  final String title;

  ProductDetails(
      {required this.CPU,
      required this.camera,
      required this.capacity,
      required this.color,
      required this.id,
      required this.images,
      required this.isFavorites,
      required this.price,
      required this.rating,
      required this.sd,
      required this.ssd,
      required this.title});

  // "CPU": "Exynos 990",
  // "camera": "108 + 12 mp",
  // "capacity": [
  // "126",
  // "252"
  // ],
  // "color": [
  // "#772D03",
  // "#010035"
  // ],
  // "id": "3",
  // "images": [
  // "https://avatars.mds.yandex.net/get-mpic/5235334/img_id5575010630545284324.png/orig",
  // "https://www.manualspdf.ru/thumbs/products/l/1260237-samsung-galaxy-note-20-ultra.jpg"
  // ],
  // "isFavorites": true,
  // "price": 1500,
  // "rating": 4.5,
  // "sd": "256 GB",
  // "ssd": "8 GB",
  // "title": "Galaxy Note 20 Ultra"

  factory ProductDetails.fromMap(Map<String, dynamic> data) {
    List<int> capacityList = [];
    final capacity = List.from(data['capacity']);
    for (var element in capacity) {
      capacityList.add(int.parse(element));
    }

    List<String> colorList = [];
    final color = List<String>.from(data['color']);
    for (var element in color) {
      colorList.add(element);
    }

    List<String> imagesList = [];
    final images = List<String>.from(data['images']);
    for (var element in images) {
      imagesList.add(element);
    }

    return ProductDetails(
      CPU: data['CPU'] ?? '',
      camera: data['camera'] ?? '',
      capacity: capacityList,
      color: colorList,
      id: data['id'] ?? '',
      images: imagesList,
      isFavorites: data['isFavorites'] as bool,
      price: data['price'] as int,
      rating: data['rating'] as double,
      sd: data['sd'] ?? '',
      ssd: data['ssd'] ?? '',
      title: data['title'] ?? '',
    );
  }
}
