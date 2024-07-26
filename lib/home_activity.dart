import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jagruk/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:carousel_slider/carousel_slider.dart';
class HomeActivity extends StatelessWidget {
 final String mobileNumber;

  const HomeActivity({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             SizedBox(height: 50),
            ImageSlider(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'आप इन योजनाओ के पात्र हो सकते है  :',
                style: TextStyle(
                  color: Color(0xFF577B8D),
                  fontFamily: 'Roboto',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ), // Image Slider
      
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    CategoryBox(
                      color: Color(0xFF3F588F), // Custom color
                      categoryName: 'Finance',
                      onTap: () => _showCategoryContent(context, 'Finance'),
                    ),
                    SizedBox(height: 10),
                    CategoryBox(
                      color: Color(0xFF79D7D2), // Custom color
                      categoryName: 'Health',
                      onTap: () => _showCategoryContent(context, 'Health'),
                    ),
                    SizedBox(height: 10),
                    CategoryBox(
                      color: Color(0xFFF7A0E4), // Custom color
                      categoryName: 'Education',
                      onTap: () => _showCategoryContent(context, 'Education'),
                    ),
                    SizedBox(height: 10),
                    CategoryBox(
                      color: Color(0xFFF49494), // Custom color
                      categoryName: 'Agriculture',
                      onTap: () => _showCategoryContent(context, 'Agriculture'),
                    ),
                    SizedBox(height: 10),
                    CategoryBox(
                      color: Color(0xFF96C3E4), // Custom color
                      categoryName: 'Employment',
                      onTap: () => _showCategoryContent(context, 'Employment'),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showDatabaseContent(context);
              },
              child: const Text('Show Database Content'),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryContent(BuildContext context, String category) async {
    // Fetch schemes based on category from database
    final databaseHelper = DatabaseHelper.instance;
    final db = await databaseHelper.database;

    final schemes = await db.query(DatabaseHelper.TABLE_YOJNA,
        where: '${DatabaseHelper.COL_Y_CATEGORY} = ?', whereArgs: [category]);

    // Show schemes in UI (you can customize this as per your UI requirements)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$category Schemes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: schemes.map((scheme) {
              return Text(
                  'Name: ${scheme[DatabaseHelper.COL_Y_NAME]}, Desc: ${scheme[DatabaseHelper.COL_Y_DESC]}');
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showDatabaseContent(BuildContext context) async {
    // Initialize the database
    final databaseHelper = DatabaseHelper.instance;
    final db = await databaseHelper.database;

    // Query users and yojnas
    final users = await db.query(DatabaseHelper.TABLE_USER);
    final yojnas = await db.query(DatabaseHelper.TABLE_YOJNA);

    // Display the content in console (you can modify this to display in UI)
    print('Users:');
    users.forEach((user) {
      print(
          'Mobile: ${user[DatabaseHelper.COL_MOBILE]}, Name: ${user[DatabaseHelper.COL_NAME]}, Gender: ${user[DatabaseHelper.COL_GENDER]}');
    });

    print('Yojnas:');
    yojnas.forEach((yojna) {
      print(
          'Name: ${yojna[DatabaseHelper.COL_Y_NAME]}, Category: ${yojna[DatabaseHelper.COL_Y_CATEGORY]}, Gender: ${yojna[DatabaseHelper.COL_Y_GENDER]}, Desc: ${yojna[DatabaseHelper.COL_Y_DESC]}');
    });

    // Example to show content in UI, replace with your preferred UI logic
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Database Content'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Users:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: users.map((user) {
                  return Text(
                      'Mobile: ${user[DatabaseHelper.COL_MOBILE]}, Name: ${user[DatabaseHelper.COL_NAME]}, Gender: ${user[DatabaseHelper.COL_GENDER]}');
                }).toList(),
              ),
              SizedBox(height: 16),
              Text('Yojnas:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: yojnas.map((yojna) {
                  return Text(
                      'Name: ${yojna[DatabaseHelper.COL_Y_NAME]}, Category: ${yojna[DatabaseHelper.COL_Y_CATEGORY]}, Gender: ${yojna[DatabaseHelper.COL_Y_GENDER]}, Desc: ${yojna[DatabaseHelper.COL_Y_DESC]}');
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class ImageSlider extends StatelessWidget {
  final List<String> imgUrls = [
    'https://www.india.gov.in/sites/upload_files/npi/files/spotlights/jan-dhan-yojna-inner-new.jpg',
    'https://www.india.gov.in/sites/upload_files/npi/files/spotlights/ujjwala-yojana-inner.jpg',
    'https://www.newsclick.in/sites/default/files/styles/responsive_885/public/2024-01/Untitled%20design%20%2820%29.jpg?itok=BvM_GND3',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: imgUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class CategoryBox extends StatelessWidget {
  final Color color;
  final String categoryName;
  final VoidCallback onTap;

  const CategoryBox({
    Key? key,
    required this.color,
    required this.categoryName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth - 20, // screen width with 10 padding on each side
        height: 90,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              categoryName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
