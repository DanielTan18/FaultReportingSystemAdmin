import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NAME = "name";
  static const EMAIL = "email";
  static const ID = "uid";
  // static const STRIPE_ID = "stripeId";

  String _name;
  String _email;
  String _id;
  // String _stripeId;

//  getters
  String get name => _name;
  String get email => _email;
  String get id => _id;
  // String get stripeId => _stripeId;

  //  public variable
  // List<CartItemModel> cart;
  // int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    // _stripeId = snapshot.data[STRIPE_ID];

    // cart = _convertCartItems(snapshot.data[CART]) ?? [];
    // totalCartPrice = snapshot.data[CART] == null ? 0 :getTotalPrice(cart: snapshot.data[CART]);
  }

  // int getTotalPrice({List cart}){
  //   if(cart==null){
  //     return 0;
  //   }
  //   for(Map cartItem in cart){
  //     _priceSum +=cartItem["price"]*cartItem["quantity"];
  //   }

  //   int total = _priceSum;

  //   print("The total is $total");
  //   print("The total is $total");

  //   return total;

  // }

  // List<CartItemModel> _convertCartItems(List cart){
  //   List<CartItemModel> convertedCart = [];
  //   for(Map cartItem in cart){
  //     convertedCart.add(CartItemModel.fromMap(cartItem));
  //   }
  //   return convertedCart;
  // }

}
