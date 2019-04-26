import 'dart:async';

class Product {
  final String productName;
  final String price;
  final String imagePath;
  final String tagLine;
  final String description;
  final int purchases;
  final int year;

  Product({
    this.productName = "",
    this.price = "\$0.00",
    this.imagePath = "",
    this.purchases = 0,
    this.year = 2019,
    this.tagLine = "",
    this.description = "",
  });
}

class Inventory {
  List<Product> products;
  static bool hasLoadedAtLeastOnce = false;

  get length => products.length;

  Future<Inventory> simulateServerRequest(String filter) {
    return Future.delayed(Duration(milliseconds: (hasLoadedAtLeastOnce) ? 500 : 3500), () {
      hasLoadedAtLeastOnce = true;

      products.clear();
    
      products
        ..add(
          Product(
            productName: "Google Home",
            price: "\$129",
            imagePath: "images/google_home.png",
            purchases: 9000,
            year: 2016,
            tagLine: "Hands-free help from the Google Assistant.",
            description: "Get answers, play songs, tackle your day, enjoy your entertainment, and control your smart devices.",
          ),
        )
        ..add(
          Product(
            productName: "Google Clips",
            price: "\$249",
            imagePath: "images/google_clips.png",
            purchases: 1,
            year: 2018,
            tagLine: "Wireless Smart Camera",
            description: "A hands-free camera built with Google’s smarts that lets you effortlessly capture and view more of the spontaneous moments with the people and pets who matter to you.",
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
            tagLine: "Dream with your eyes open",
            description: "Daydream is a comfortable, easy-to-use headset designed with choice in mind."
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
