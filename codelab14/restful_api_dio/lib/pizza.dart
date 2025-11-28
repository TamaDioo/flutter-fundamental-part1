const keyId = 'id';
const keyName = 'pizzaName';
const keyDescription = 'description';
const keyPrice = 'price';
const keyImage = 'imageUrl';
const keyRating = 'rating';

class Pizza {
  int? id;
  String? pizzaName;
  String? description;
  double? price;
  String? imageUrl;
  double? rating;

  Pizza();

  Pizza.fromJson(Map<String, dynamic> json)
    : id = int.tryParse(json[keyId].toString()) ?? 0,
      pizzaName = json[keyName] != null ? json[keyName].toString() : 'No name',
      description = json[keyDescription] != null
          ? json[keyDescription].toString()
          : '',
      price = double.tryParse(json[keyPrice].toString()) ?? 0,
      imageUrl = json[keyImage] ?? '',
      rating = double.tryParse(json[keyRating]?.toString() ?? '0') ?? 0;

  Map<String, dynamic> toJson() {
    return {
      keyId: id,
      keyName: pizzaName,
      keyDescription: description,
      keyPrice: price,
      keyImage: imageUrl,
      keyRating: rating,
    };
  }
}
