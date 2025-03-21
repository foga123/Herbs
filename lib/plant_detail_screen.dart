import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

String getAdjustedImagePath(String path) {
  String adjustedPath = kReleaseMode ? path.replaceFirst('../', '') : path;
  return adjustedPath;
}

class PlantDetailScreen extends StatelessWidget {
  final String plantName;

  const PlantDetailScreen({super.key, required this.plantName});

  @override
  Widget build(BuildContext context) {
    final Box plantsBox = Hive.box('plants');
    final plantData = plantsBox.get(plantName) as Map?;
    final imagePath = plantData?['image'] as String?;

    if (plantData == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Plant Not Found'),
          backgroundColor: Colors.green,
        ),
        body: const Center(child: Text('Plant data not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(plantName, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imagePath != null)
              Center(
                child: Image.asset(
                  getAdjustedImagePath(imagePath),
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, size: 100);
                  },
                ),
              )
            else
              const Center(child: Icon(Icons.image_not_supported, size: 100)),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Plant Information',
              content: plantData['plantInfo'] ?? 'No information available.',
            ),
            _buildSection(
              title: 'Medical Uses',
              content: (plantData['medicalUse'] as Map?)
                      ?.entries
                      .map((entry) => '${entry.key}: ${entry.value}')
                      .join('\n') ??
                  'No medical uses available.',
            ),
            _buildSection(
              title: 'Parts Used',
              content: plantData['partsUsed'] ?? 'Not specified.',
            ),
            _buildSection(
              title: 'How to Use',
              content: plantData['howToUse'] ?? 'No instructions available.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 4,
      color: Colors
          .grey[200], // Match the light grey background from the screenshot
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(content, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
