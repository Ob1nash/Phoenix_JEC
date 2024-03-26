import 'package:flutter/material.dart';
import 'product_page.dart';

class ShopScreen extends StatelessWidget {
  final List<String> dummyImageUrls = [
    'https://cdn.shopify.com/s/files/1/0070/7032/files/blank_tote_merch_swag_fashion_print_on_demand.jpg?v=1689965049',
    'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTExL3JtMzYyLTAxYS1tb2NrdXAuanBn.jpg',
    'https://images.pexels.com/photos/4041392/pexels-photo-4041392.jpeg?cs=srgb&dl=pexels-karolina-grabowska-4041392.jpg&fm=jpg',
    'https://images.pexels.com/photos/4041392/pexels-photo-4041392.jpeg?cs=srgb&dl=pexels-karolina-grabowska-4041392.jpg&fm=jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        backgroundColor: Color.fromARGB(255, 102, 215, 106),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: dummyImageUrls.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          double price = 99.99; // Example price
          int coins = 1000; // Example coins
          return _buildProductCard(context, dummyImageUrls[index], price, coins);
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String imageUrl, double price, int coins) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Container(color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Product Description',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$$price',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '$coins',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Icon(
                          Icons.monetization_on,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 80, // Adjusted button width
                      child: ElevatedButton(
                        onPressed: () {
                          navigateToProductPage(context, imageUrl);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF75EE7B)),
                        ),
                        child: FittedBox(
                          child: Text('Buy', style: TextStyle(fontSize: 10.0, color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80, // Adjusted button width
                      child: ElevatedButton(
                        onPressed: () {
                          navigateToProductPage(context, imageUrl);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF75EE7B)),
                        ),
                        child: FittedBox(
                          child: Text('Redeem', style: TextStyle(fontSize: 14.0, color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToProductPage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductPage(imageUrl: imageUrl)),
    );
  }
}
