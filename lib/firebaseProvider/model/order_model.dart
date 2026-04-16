class Order {
  final String id;
  final String name;
  final String mobile;
  final String address;
  final String city;
  final String pincode;
  final double totalPrice;
  final DateTime date;

  Order({
    required this.id,
    required this.name,
    required this.mobile,
    required this.address,
    required this.city,
    required this.pincode,
    required this.totalPrice,
    required this.date,
  });
}
