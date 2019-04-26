import 'package:flutter/material.dart';
import 'model/inventory.dart';
import 'product_grid.dart';
import 'styles.dart';
import 'product_info_page.dart';
import 'package:flutter/services.dart';

class ProductsPage extends StatefulWidget {
  final Inventory inventory;

  ProductsPage() : inventory = Inventory();

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    with SingleTickerProviderStateMixin {
  String filterBy;
  String displayingFilterBy;

  AnimationController _controller;
  Animation<double> fadeFilterLabelAnimation;

  @override
  void initState() {
    super.initState();

    filterBy = "All";
    displayingFilterBy = "All";

    _controller =
        AnimationController(duration: Duration(milliseconds: 215), vsync: this);
    fadeFilterLabelAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(curve: Curves.easeOutSine, parent: _controller));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        displayingFilterBy = filterBy;
        _controller.reverse();
      }
    });
  }

  _buildFilterMenu() {
    return DropdownButton(
      value: filterBy,
      iconSize: 0,
      onChanged: (f) {
        setState(() {
          filterBy = '$f';

          _controller.reset();
          _controller.forward();
        });
      },
      items: <String>['All', 'Top', 'Recent']
          .map<DropdownMenuItem<String>>((text) {
        return DropdownMenuItem(
          child: Text(text),
          value: text,
        );
      }).toList(),
    );
  }

  _buildHeader() {
    return Container(
      height: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: kToolbarHeight,
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                  Image.asset('images/dots.png', width: 50, height: 50, fit: BoxFit.cover,),
                  Icon(Icons.shopping_cart),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Opacity(
                      opacity: fadeFilterLabelAnimation.value,
                      child: Text(
                        displayingFilterBy,
                        style: activeHeaderTitle,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Products",
                      style: inactiveHeaderTitle,
                      overflow: TextOverflow.fade,
                    ),
                    Spacer(),
                    _buildFilterMenu(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FutureBuilder(
                    // simulateServerRequest() returns Future<Inventory>
                    future: widget.inventory.simulateServerRequest(filterBy),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 4,
                            ),
                          ),
                        );
                      }

                      return ProductGridBuilder(
                        itemCount: snapshot.data.length,
                        builder: (_, idx) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  fullscreenDialog: false,
                                  builder: (_) => ProductInfoPage(
                                        snapshot.data.products[idx],
                                      ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    color: (idx % 3 == 0) ? Color(0xffe5e5e3) : Color(0xffededed),
                                    height: 320,
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      width: 140,
                                      height: 140,
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 70,
                                    height: 140,
                                    child: Image.asset(
                                      snapshot.data.products[idx].imagePath,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 30,
                                    left: 0,
                                    right: 0,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          snapshot
                                              .data.products[idx].productName,
                                          style: cardTextStyle,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          snapshot.data.products[idx].price,
                                          style: cardTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
