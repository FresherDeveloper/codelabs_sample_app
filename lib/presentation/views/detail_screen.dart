import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final dynamic item;
  const DetailScreen({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    var style = const TextStyle(fontSize: 18, color: Colors.white);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 25, 41),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 25, 41),
        foregroundColor: Colors.white,
        title: Text(item['Name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  item['ImgUrlPath'] != null
                      ? Hero(
                          tag: 'image${item['Id']}',
                          child: Image.network(
                            "https://coinoneglobal.in/crm/${item['ImgUrlPath']}",
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 2,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Placeholder(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item['Name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'ID: ${item['Id']}',
              style: style,
            ),
            Text(
              'Code: ${item['Code']}',
              style: style,
            ),
            Text(
              'Order Index: ${item['OrderIndex']}',
              style: style,
            ),
            Text(
              'Parent: ${item['Parent']}',
              style: style,
            ),
            Text(
              'Remarks: ${item['Remarks']}',
              style: style,
            ),
            Text(
              'Update Date: ${item['UpdateDate']}',
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}

//here is my code according to question qiven.Due to wrong url I am not able view detailscreen so I modied my code with the above codes
/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class DetailScreen extends StatelessWidget {
   DetailScreen({super.key, });
 
final String apiUrl = 'https://coinoneglobal.in/teresa_trial/webtemplate.asmx/FnGetTemplateSubCategoryList?'; // Replace with your API URL

  Future<List<dynamic>> fetchImageDetails(int imageId) async {
    final response = await http.get(Uri.parse('$apiUrl&PrmCategoryId="$imageId"'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load image details');
    }
  }
  

  @override
  Widget build(BuildContext context) {
     final int imgId = ModalRoute.of(context)!.settings.arguments as int;

    var style = const TextStyle(fontSize: 18,color: Colors.white);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 25, 41),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 25, 41),
        foregroundColor: Colors.white,
        title: const Text("Image Detail"),
      ),
      body:FutureBuilder<List<dynamic>>(
        future: fetchImageDetails(imgId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> imageDetails = snapshot.data!;
            // Assuming "ImgUrlPath" is a parameter in the response
            String imgUrlPath = imageDetails[0]['ImgUrlPath'];
            String fullImageUrl = 'https://example.com/${imgUrlPath}'; // Adjust URL construction based on your API response
            return Center(
              child: Hero(
                 tag: 'image${imageDetails[0]['Id']}',
                child: Image.network(fullImageUrl)),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    
    );
  }
}

*/