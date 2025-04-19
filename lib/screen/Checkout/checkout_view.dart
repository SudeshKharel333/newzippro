import 'package:flutter/material.dart';
import '/core/app_managers/assets_managers.dart';
//import '/screen/Checkout/checkout_view.dart';

class Checkout extends StatelessWidget {
  // final String productName;
  // final String productDescription;
  // final double productPrice;
  // final List<String> imageUrls;

  const Checkout({
    Key? key,
    // required this.productName,
    // required this.productDescription,
    // required this.productPrice,
    // required this.imageUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return Scaffold();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight:
                FontWeight.bold, // Set the font size to 24 logical pixels
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Text(
            "Payment methods",
            style: TextStyle(
              fontSize: 20.0, // Set the font size to 24 logical pixels
            ),
          ),
          Divider(
            color: Colors.blue, // Change color
            thickness: 2, // Make the divider thicker
            indent: 20, // Add padding from the start
            endIndent: 20, // Add padding from the end
          ),
          Container(
            height: 50,
            child: Row(
              children: [
                Image.asset(AssetManager.esewa),
                SizedBox(
                  width: 20,
                ),
                const Center(
                    child: Text(
                  'Esewa',
                  style: TextStyle(
                    //fontSize: 30.0,
                    fontWeight: FontWeight
                        .bold, // Set the font size to 24 logical pixels
                  ),
                )),
              ],
            ),
          ),
          Divider(
            color: Colors.blue, // Change color
            thickness: 1, // Make the divider thicker
            indent: 20, // Add padding from the start
            endIndent: 20, // Add padding from the end
          ),
          Container(
            height: 50,
            child: Row(
              children: [
                Image.asset(AssetManager.khalti),
                SizedBox(
                  width: 20,
                ),
                const Center(
                    child: Text(
                  'Khalti',
                  style: TextStyle(
                    //fontSize: 30.0,
                    fontWeight: FontWeight
                        .bold, // Set the font size to 24 logical pixels
                  ),
                )),
              ],
            ),
          ),
          Divider(
            color: Colors.blue, // Change color
            thickness: 1, // Make the divider thicker
            indent: 20, // Add padding from the start
            endIndent: 20, // Add padding from the end
          ),
          Container(
            height: 50,
            child: Row(
              children: [
                Image.asset(
                  AssetManager.imepay,
                  width: 70,
                ),
                // SizedBox(
                //   width: 20,
                // ),
                const Center(
                    child: Text(
                  'IMEpay',
                  style: TextStyle(
                    //fontSize: 30.0,
                    fontWeight: FontWeight
                        .bold, // Set the font size to 24 logical pixels
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
