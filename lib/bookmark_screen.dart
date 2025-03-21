import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'plant_detail_screen.dart';

String getAdjustedImagePath(String path) {
  String adjustedPath = kReleaseMode ? path.replaceFirst('../', '') : path;
  return adjustedPath;
}

class BookmarkScreen extends StatelessWidget {
  BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('bookmarks').listenable(),
      builder: (context, Box bookmarksBox, _) {
        if (bookmarksBox.isEmpty) {
          return Center(child: Text('No bookmarks yet.'));
        }
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: bookmarksBox.length,
          itemBuilder: (context, index) {
            final plantName = bookmarksBox.keyAt(index);
            final plantData = bookmarksBox.get(plantName) as Map;
            final imagePath = plantData['image'] as String?;
            return Card(
              elevation: 4,
              margin: EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: imagePath != null
                    ? Image.asset(
                        getAdjustedImagePath(imagePath),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.image_not_supported, size: 50);
                        },
                      )
                    : Icon(Icons.image_not_supported, size: 50),
                title: Text(plantName),
                subtitle: Text('Click to view details'),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    bookmarksBox.delete(plantName);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$plantName removed from bookmarks'),
                        duration: Duration(milliseconds: 330),
                      ),
                    );
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PlantDetailScreen(plantName: plantName),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
