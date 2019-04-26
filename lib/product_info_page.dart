import 'package:flutter/material.dart';
import 'model/inventory.dart';
import 'styles.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    SizedBox(height: 8,),
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
                    SizedBox(height: 24,),
                    Text(
                      "Hands-free help from the Google Assistant.",
                      style: infoSemibold,
                    ),
                    SizedBox(height: 24,),
                    Text(
                      "Get answers, play songs, tackle your day, enjoy your entertainment, and control your smart devices.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: infoText,
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
