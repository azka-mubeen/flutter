import '../Functions/dress.dart';
class User {
  String firstName;
  String lastName;
  String shopName;
  String phoneNo;
  String email;
  String password;
  String address;
  String location;
  String role;
  String imgUrl;
  String uId;
  List<Dress> dresses = [];
  User({
    required this.imgUrl,
    required this.uId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNo,
    required this.shopName,
    required this.location,
    required this.role,
    required this.dresses,
  });
  // Method to add a dress to the dresses list
  void addDress(String description, String imageUrl) {
    dresses.add(Dress(description: description, imageUrl: imageUrl));
  }
  //Secondary empty constructor
  User.empty():
      uId = '',
        imgUrl = '',
        firstName = '',
        lastName = '',
        shopName = '',
        phoneNo = '',
        email = '',
        password = '',
        address = '',
        location = '',
        role = '';


  // Getter and setter for first name
  String get getFirstName => firstName;
  set setId(String newfirstName) => firstName = newfirstName;

  // Getter and setter for Lastname
  String get getLastName => lastName;
  set setName(String newlastName) => lastName = newlastName;

  // Getter and setter for email
  String get getEmail => email;
  set setEmail(String newEmail) => email = newEmail;

  // Getter and setter for location
  String get getLocation => location;
  set setLocation(String newLocation) => location = newLocation;

  // Getter and setter for role
  String get getRole => role;
  set setRole(String newRole) => location = newRole;

  // Getter and setter for Password
  String get getPassword => password;
  set setPassword(String newPassword) => location = newPassword;

  // Getter and setter for Phone number
  String get getPhoneNo => phoneNo;
  set setPhoneNO(String newPhoneNO) => location = newPhoneNO;

  // Getter and setter for Address
  String get getAddress => address;
  set setAddress(String newAddress) => location = newAddress;

  // Getter and setter for Shop name
  String get getShopName => shopName;
  set setShopName(String newShopName) => location = newShopName;


  Map<String, dynamic> createMap() {
    return {
      'userId': uId,
      'imgUrl': imgUrl,
      'firstName': firstName,
      'lastName': lastName,
      'shopName': shopName,
      'phoneNo': phoneNo,
      'email': email,
      'password': password,
      'address': address,
      'location': location,
      'role': role,
    };
  }

  void initializeVariablesFromMap(Map<String, dynamic> dataMap) {
     uId = dataMap['userId'];
     imgUrl = dataMap['imgUrl'];
     firstName = dataMap['firstName'];
     lastName = dataMap['lastName'];
     shopName = dataMap['shopName'];
     phoneNo = dataMap['phoneNo'];
     email = dataMap['email'];
     password = dataMap['password'];
     address = dataMap['address'];
     location = dataMap['location'];
     role = dataMap['role'];
}
  }
