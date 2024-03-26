import 'package:flutter/material.dart';

class EcoCoinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EcoCoin'),
        backgroundColor: Color.fromARGB(255, 102, 215, 106),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EcoCoin Balance:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '500 EcoCoins',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20),
            Text(
              'Transaction History:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Assuming there are 5 transactions
                itemBuilder: (context, index) {
                  // Dummy transaction data
                  String date = '2024-03-22';
                  String amount = '+100';
                  String description = 'Planted a tree';
                  return ListTile(
                    leading: Icon(Icons.monetization_on),
                    title: Text('$amount EcoCoins'),
                    subtitle: Text(description),
                    trailing: Text(date),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
