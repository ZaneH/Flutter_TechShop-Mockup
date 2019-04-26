import 'package:flutter/material.dart';
import 'model/inventory.dart';
import 'styles.dart';
import 'package:flutter/services.dart';

class ProductInfoPage extends StatefulWidget {
  final Product displayProduct;

  ProductInfoPage(
    this.displayProduct,
  );

  @override
  State<StatefulWidget> createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  int _currentPage;
  PageController _pageController;

  @override
  void initState() {
    super.initState();

    _currentPage = 0;
    _pageController = PageController(initialPage: 0);

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page.round();
      });
    });
  }

  _buildIndicators(int numOfIndicators) {
    List<Widget> indicators = [];

    for (int i = 0; i < numOfIndicators; i++) {
      indicators
        ..add(
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (i == _currentPage) ? Colors.black : Colors.grey,
            ),
          ),
        )
        ..add(
          SizedBox(
            width: 10,
          ),
        );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: indicators,
    );
  }

  _buildHeartButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color(0xfff1f0f6).withOpacity(1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Icon(Icons.favorite_border),
    );
  }

  _buildAddToCartButton() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff5fc9d7),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 16,
            ),
            SizedBox(
              width: 18,
            ),
            Text(
              "ADD TO CART",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Color(0xffe5e5e3),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Overview",
          style: titleTextStyle,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                color: Color(0xffe5e5e3),
                height: MediaQuery.of(context).size.height / 2.1,
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 30,
                bottom: 80,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 80,
                bottom: 50,
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Image.asset(widget.displayProduct.imagePath),
                    Image.asset(widget.displayProduct.imagePath),
                    Image.asset(widget.displayProduct.imagePath),
                  ],
                ),
              ),
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: _buildIndicators(3),
              )
            ],
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 36,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.displayProduct.productName,
                          style: infoTitle,
                        ),
                        Spacer(),
                        Text(
                          widget.displayProduct.price,
                          style: infoTitle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      widget.displayProduct.tagLine,
                      style: infoSemibold,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      widget.displayProduct.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: infoText,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _buildHeartButton(),
                        SizedBox(
                          width: 24,
                        ),
                        _buildAddToCartButton(),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
