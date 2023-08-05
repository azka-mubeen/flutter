class Dress {
  String description;
  String imageUrl;

  Dress({required this.description, required this.imageUrl});

  // Getter and setter for description
  String get getDescription => description;
  set setDescription(String newDescription) => description = newDescription;

  // Getter and setter for imageUrl
  String get getImageUrl => imageUrl;
  set setImageUrl(String newImageUrl) => imageUrl = newImageUrl;
}
