import 'package:cloud_firestore/cloud_firestore.dart';

class FaultTypeModel {
  static const NAME = "name";
  static const DESC = "desc";
  // static const STRIPE_ID = "stripeId";

  String _name;
  String _desc;
  // String _stripeId;

//  getters
  String get name => _name;
  String get desc => _desc;
  // String get stripeId => _stripeId;

  //  public variable
  // List<CartItemModel> cart;
  // int totalCartPrice;

  FaultTypeModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _desc = snapshot.data[DESC];
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
