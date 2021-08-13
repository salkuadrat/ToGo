class Product {

  int id;
  String title;
  double price;
  String description;
  String image;
  String thumb;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.thumb,
  });

  Product.fromJson(Map json) :
    id = json['id'].toInt(),
    title = json['title'].toString(),
    price = json['price'].toDouble(),
    description = json['description'].toString(),
    image = json['image'].toString(),
    thumb = json['thumb'].toString();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'image': image,
    'thumb': thumb,
  };
}
