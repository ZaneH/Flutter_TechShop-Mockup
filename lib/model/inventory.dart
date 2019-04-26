import 'dart:async';

class Product {
  final String productName;
  final String price;
  final String imagePath;
  final int purchases;
  final int year;

  Product({
    this.productName = "",
    this.price = "\$0.00",
    this.imagePath = "",
    this.purchases = 0,
    this.year = 2019,
  });
}

class Inventory {
  List<Product> products;

  get length => products.length;

  Future<Inventory> simulateServerRequest(String filter) {
    return Future.delayed(Duration(seconds: 2), () {
      products.clear();
    
      products
        ..add(
          Product(
            productName: "Google Home",
            price: "\$129",
            imagePath: "images/google_home.png",
            purchases: 9000,
            year: 2016,
          ),
        )
        ..add(
          Product(
            productName: "Google Clips",
            price: "\$249",
            imagePath: "images/google_clips.png",
            purchases: 1,
            year: 2018,
          ),
        )
        ..add(
          Product(
            productName: "Nest Protect",
            price: "\$119",
            imagePath: "images/nest_protect.png",
            purchases: 100,
            year: 2015,
          ),
        )
        ..add(
          Product(
            productName: "Google Daydream",
            price: "\$99",
            imagePath: "images/google_daydream.png",
            purchases: 200,
            year: 2016,
          ),
        );

      if (filter == "All") {
        products.sort((a, b) {
          // no sorting
          return 0;
        });
      } else if (filter == "Top") {
        products.sort((a, b) {
          // flip for asc
          if (a.purchases < b.purchases) {
            return 1;
          } else if (a.purchases > b.purchases) {
            return -1;
          } else {
            return 0;
          }
        });
      } else if (filter == "Recent") {
        products.sort((a, b) {
          // flip for asc
          if (a.year < b.year) {
            return 1;
          } else if (a.year > b.year) {
            return -1;
          } else {
            return 0;
          }
        });
      }

      return this;
    });
  }

  Inventory() {
    products = [];
  }
}
