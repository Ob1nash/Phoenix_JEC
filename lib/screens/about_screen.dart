import 'package:flutter/material.dart';

// Custom AppBar widget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('EcoFront'),
      backgroundColor: Color.fromARGB(255, 102, 215, 106),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Use the CustomAppBar here
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About EcoFront',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'EcoFront is an app dedicated to promoting eco-friendly habits and activities. Our mission is to incentivize users to adopt sustainable practices in their daily lives by rewarding them for completing eco-friendly tasks.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Email: contact@ecofront.com\nPhone: 123-456-7890',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
