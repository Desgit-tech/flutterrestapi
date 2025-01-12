class Hospital {
  final int id;
  final String name;
  final String location;
  final double price;
  final double rating;
  final String description;
  final String imageUrl;

  Hospital({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.description,
    required this.imageUrl,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'],
      location: json['location'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'price': price,
      'rating': rating,
      'description': description,
      'image_url': imageUrl,
    };
  }
}
