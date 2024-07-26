import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final String category;

  const CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample static data
    final List<Map<String, String>> schemes = [
      {
        'name': 'Mahatma Gandhi National Rural Employment Guarantee Act (MGNREGA)',
        'description': 'Provides employment to rural households. Guarantees 100 days of wage employment in a financial year.'
      },
      {
        'name': 'Pradhan Mantri Awas Yojana (PMAY)',
        'description': 'Aims to provide affordable housing to the urban poor by 2022.'
      },
      {
        'name': 'National Health Mission (NHM)',
        'description': 'Seeks to improve healthcare delivery across the state, focusing on rural areas.'
      },
      {
        'name': 'Madhya Pradesh Ujjwala Yojana',
        'description': 'Provides LPG connections to women from below-poverty-line households.'
      },
      {
        'name': 'Madhya Pradesh Skill Development Mission',
        'description': 'Aims to enhance the employability of youth by providing skill training.'
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Schemes'),
      ),
      body: ListView.builder(
        itemCount: schemes.length,
        itemBuilder: (context, index) {
          final scheme = schemes[index];
          return Card(
            child: ListTile(
              title: Text(scheme['name'] ?? ''),
              subtitle: Text(scheme['description'] ?? ''),
            ),
          );
        },
      ),
    );
  }
}
