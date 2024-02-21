import 'package:flutter/material.dart';
import 'package:store/core/constant/imageasset.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  AppImageAsset.logo), // Replace with your asset image
            ),
            SizedBox(height: 20),
            Text(
              'eGift',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'eGift is a leading digital gifting platform, providing a wide range of gifts and baskets from top brands. Our mission is to make gifting easier and more accessible for everyone, everywhere. With eGift, you can send a thoughtful gift instantly to your loved ones for any occasion.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Contact Us'),
              subtitle: Text('support@egiftservice.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Call Us'),
              subtitle: Text('+123 456 7890'),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Visit Our Website'),
              subtitle: Text('www.egiftservice.com'),
            ),
            SizedBox(height: 20),
            Text(
              'Follow Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.facebook),
                  onPressed: () {
                    // Logic to open Facebook
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    // Logic to open Twitter
                  },
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt_outlined),
                  onPressed: () {
                    // Logic to open Instagram
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
