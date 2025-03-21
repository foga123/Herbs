import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'plant_detail_screen.dart';

String getAdjustedImagePath(String path) {
  String adjustedPath = kReleaseMode ? path.replaceFirst('../', '') : path;
  return adjustedPath;
}

class AilmentsScreen extends StatefulWidget {
  AilmentsScreen({super.key});

  @override
  _AilmentsScreenState createState() => _AilmentsScreenState();
}

class _AilmentsScreenState extends State<AilmentsScreen> {
  final Box plantsBox = Hive.box('plants');
  String searchQuery = '';

  final Map<String, Map<String, dynamic>> ailments = {
    'Abdominal Pain': {
      'description': 'Pain between thorax and pelvis',
      'plants': ['Tsaang Gubat', 'Gotu Kola', 'Fennel'],
      'substitutes': ['Peppermint', 'Fennel'],
    },
    'Acne': {
      'description': 'Inflammatory skin condition',
      'plants': ['Akapulko', 'Calendula'],
      'substitutes': ['Tea Tree', 'Witch Hazel'],
    },
    'Anemia': {
      'description': 'Low red blood cell count',
      'plants': ['Malunggay', 'Dandelion'],
      'substitutes': ['Nettle', 'Spinach'],
    },
    'Anxiety': {
      'description': 'Excessive nervousness or worry',
      'plants': [
        'Chamomile',
        'Lemon Balm',
        'Catnip',
        'Valerian',
        'Passionflower'
      ],
      'substitutes': ['Kava', 'Chamomile'],
    },
    'Arthritis': {
      'description': 'Joint inflammation',
      'plants': ['Turmeric', 'Yerba Buena', 'Pandan'],
      'substitutes': ['Boswellia', 'Willow Bark'],
    },
    'Asthma': {
      'description': 'Chronic respiratory condition',
      'plants': ['Lagundi', 'Thyme'],
      'substitutes': ['Ephedra', 'Coffee'],
    },
    'Bad Breath': {
      'description': 'Unpleasant mouth odor',
      'plants': ['Parsley'],
      'substitutes': ['Cloves', 'Mint'],
    },
    'Burns': {
      'description': 'Skin injury from heat',
      'plants': ['Aloe Vera', 'Calendula'],
      'substitutes': ['Honey', 'Calendula'],
    },
    'Circulation Issues': {
      'description': 'Poor blood flow',
      'plants': ['Cayenne'],
      'substitutes': ['Ginkgo', 'Horse Chestnut'],
    },
    'Cold': {
      'description': 'Upper respiratory infection',
      'plants': [
        'Ginger',
        'Siling Labuyo',
        'Echinacea',
        'Oregano',
        'Elderberry',
        'Holy Basil'
      ],
      'substitutes': ['Honey', 'Elderberry'],
    },
    'Colic': {
      'description': 'Infant digestive distress',
      'plants': ['Fennel'],
      'substitutes': ['Dill', 'Chamomile'],
    },
    'Cough': {
      'description': 'Sudden air expulsion from lungs',
      'plants': ['Basil', 'Lagundi', 'Thyme', 'Mullein'],
      'substitutes': ['Honey', 'Thyme'],
    },
    'Depression': {
      'description': 'Persistent low mood',
      'plants': ['St. John’s Wort'],
      'substitutes': ['Saffron', 'Rhodiola'],
    },
    'Diabetes': {
      'description': 'High blood sugar levels',
      'plants': ['Ampalaya', 'Banaba', 'Cinnamon', 'Fenugreek'],
      'substitutes': ['Bitter Melon', 'Cinnamon'],
    },
    'Diarrhea': {
      'description': 'Frequent loose stools',
      'plants': ['Guava', 'Tsaang Gubat', 'Bilberry'],
      'substitutes': ['Blackberry', 'Guava'],
    },
    'Digestive Issues': {
      'description': 'Stomach discomfort',
      'plants': ['Basil', 'Peppermint', 'Mint'],
      'substitutes': ['Peppermint', 'Anise'],
    },
    'Earache': {
      'description': 'Pain in the ear',
      'plants': ['Mullein'],
      'substitutes': ['Garlic', 'Olive Oil'],
    },
    'Eye Strain': {
      'description': 'Tired or sore eyes',
      'plants': ['Bilberry'],
      'substitutes': ['Eyebright', 'Bilberry'],
    },
    'Fatigue': {
      'description': 'Persistent tiredness',
      'plants': ['Ginseng', 'Ashwagandha'],
      'substitutes': ['Rhodiola', 'Maca'],
    },
    'Fever': {
      'description': 'Elevated body temperature',
      'plants': ['Lagundi', 'Gotu Kola'],
      'substitutes': ['Willow Bark', 'Yarrow'],
    },
    'Flu': {
      'description': 'Viral respiratory illness',
      'plants': ['Echinacea', 'Elderberry'],
      'substitutes': ['Oregano', 'Elderberry'],
    },
    'Gallstones': {
      'description': 'Stones in gallbladder',
      'plants': ['Milk Thistle'],
      'substitutes': ['Artichoke', 'Dandelion'],
    },
    'Gout': {
      'description': 'Uric acid buildup in joints',
      'plants': ['Pansit-pansitan'],
      'substitutes': ['Cherry', 'Nettle'],
    },
    'Hair Loss': {
      'description': 'Thinning or loss of hair',
      'plants': ['Rosemary'],
      'substitutes': ['Aloe', 'Biotin'],
    },
    'Headache': {
      'description': 'Pain in head or neck',
      'plants': ['Yerba Buena', 'Peppermint', 'Pandan', 'Mint'],
      'substitutes': ['Feverfew', 'Lavender'],
    },
    'Heart Disease': {
      'description': 'Cardiovascular condition',
      'plants': ['Hawthorn'],
      'substitutes': ['Garlic', 'Hawthorn'],
    },
    'Hypertension': {
      'description': 'High blood pressure',
      'plants': ['Sambong', 'Garlic', 'Hawthorn'],
      'substitutes': ['Hibiscus', 'Garlic'],
    },
    'Indigestion': {
      'description': 'Upset stomach',
      'plants': ['Peppermint', 'Fennel', 'Mint'],
      'substitutes': ['Ginger', 'Fennel'],
    },
    'Infections': {
      'description': 'Bacterial or viral invasion',
      'plants': ['Garlic', 'Thyme', 'Oregano', 'Cinnamon'],
      'substitutes': ['Echinacea', 'Goldenseal'],
    },
    'Insect Bites': {
      'description': 'Skin irritation from bites',
      'plants': ['Plantain'],
      'substitutes': ['Aloe', 'Plantain'],
    },
    'Insomnia': {
      'description': 'Difficulty sleeping',
      'plants': [
        'Chamomile',
        'Lemon Balm',
        'Catnip',
        'Valerian',
        'Passionflower'
      ],
      'substitutes': ['Valerian', 'Chamomile'],
    },
    'Intestinal Worms': {
      'description': 'Parasites in intestines',
      'plants': ['Niyog-niyogan'],
      'substitutes': ['Wormwood', 'Pumpkin Seeds'],
    },
    'Kidney Health': {
      'description': 'Supports kidney function',
      'plants': ['Banaba'],
      'substitutes': ['Nettle', 'Corn Silk'],
    },
    'Kidney Stones': {
      'description': 'Hard deposits in kidneys',
      'plants': ['Sambong'],
      'substitutes': ['Lemon', 'Parsley'],
    },
    'Lactation Issues': {
      'description': 'Low milk supply',
      'plants': ['Fenugreek'],
      'substitutes': ['Fennel', 'Blessed Thistle'],
    },
    'Liver Issues': {
      'description': 'Liver dysfunction',
      'plants': ['Dandelion', 'Milk Thistle'],
      'substitutes': ['Schisandra', 'Artichoke'],
    },
    'Malnutrition': {
      'description': 'Nutrient deficiency',
      'plants': ['Malunggay'],
      'substitutes': ['Spirulina', 'Nettle'],
    },
    'Memory Loss': {
      'description': 'Difficulty remembering',
      'plants': ['Rosemary', 'Sage'],
      'substitutes': ['Ginkgo', 'Bacopa'],
    },
    'Menstrual Cramps': {
      'description': 'Pain or irregularity in menstruation',
      'plants': ['Gotu Kola'],
      'substitutes': ['Raspberry Leaf', 'Chasteberry'],
    },
    'Nausea': {
      'description': 'Feeling of sickness',
      'plants': ['Ginger'],
      'substitutes': ['Peppermint', 'Chamomile'],
    },
    'Nerve Pain': {
      'description': 'Pain from nerve damage',
      'plants': ['St. John’s Wort'],
      'substitutes': ['Cayenne', 'St. John’s Wort'],
    },
    'Pain': {
      'description': 'General body pain',
      'plants': ['Cayenne'],
      'substitutes': ['Willow Bark', 'Turmeric'],
    },
    'Poor Appetite': {
      'description': 'Lack of desire to eat',
      'plants': ['Siling Labuyo'],
      'substitutes': ['Gentian', 'Dandelion'],
    },
    'Rheumatism': {
      'description': 'Joint and muscle pain',
      'plants': ['Pansit-pansitan', 'Pandan'],
      'substitutes': [
        'Nettle',
        'Boswellia'
      ], // Replaced 'Stinging Nettle' with 'Nettle'
    },
    'Ringworm': {
      'description': 'Fungal skin infection',
      'plants': ['Akapulko'],
      'substitutes': ['Tea Tree', 'Neem'],
    },
    'Skin Infections': {
      'description': 'Bacterial or fungal skin issues',
      'plants': ['Akapulko'],
      'substitutes': ['Tea Tree', 'Oregano'],
    },
    'Skin Irritation': {
      'description': 'Itchy or inflamed skin',
      'plants': ['Calendula'],
      'substitutes': ['Aloe', 'Chamomile'],
    },
    'Sore Throat': {
      'description': 'Painful throat',
      'plants': ['Sage', 'Licorice'],
      'substitutes': ['Honey', 'Marshmallow'],
    },
    'Stress': {
      'description': 'Mental or emotional strain',
      'plants': ['Lavender', 'Ginseng', 'Ashwagandha', 'Holy Basil'],
      'substitutes': ['Ashwagandha', 'Lavender'],
    },
    'Ulcers': {
      'description': 'Sores in stomach or mouth',
      'plants': ['Licorice'],
      'substitutes': ['Slippery Elm', 'Aloe'],
    },
    'Wounds': {
      'description': 'Cuts or abrasions',
      'plants': ['Aloe Vera', 'Turmeric', 'Guava', 'Calendula', 'Plantain'],
      'substitutes': ['Comfrey', 'Honey'],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find Remedies for Ailments',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Search for common ailments to discover medicinal plants that can help. Always consult a healthcare professional before use.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 16),
              TextField(
                onChanged: (value) =>
                    setState(() => searchQuery = value.toLowerCase()),
                decoration: InputDecoration(
                  hintText: 'Search ailments...',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              Map<String, List<String>> groupedAilments = {};
              for (var ailmentName in ailments.keys) {
                if (ailmentName.toLowerCase().contains(searchQuery)) {
                  groupedAilments
                      .putIfAbsent(ailmentName[0].toUpperCase(), () => [])
                      .add(ailmentName);
                }
              }

              if (groupedAilments.isEmpty) {
                return Center(
                    child: Text('No ailments found.',
                        style: TextStyle(fontSize: 16)));
              }

              return ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: groupedAilments.length,
                itemBuilder: (context, index) {
                  final letter = groupedAilments.keys.elementAt(index);
                  final ailmentNames = groupedAilments[letter]!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          letter,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      ...ailmentNames.map((ailmentName) {
                        final ailmentData = ailments[ailmentName]!;
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            title: Text(ailmentName,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(
                              '${ailmentData['description']} - Recommended Plants: ${ailmentData['plants'].join(', ')}',
                            ),
                            onTap: () => _showAilmentDetails(
                                context, ailmentName, ailmentData),
                          ),
                        );
                      }).toList(),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showAilmentDetails(BuildContext context, String ailmentName,
      Map<String, dynamic> ailmentData) {
    final matchedPlants = <Map<String, dynamic>>[];
    for (var plantName in ailmentData['plants']) {
      if (plantsBox.containsKey(plantName)) {
        matchedPlants.add({
          'name': plantName,
          'data': plantsBox.get(plantName) as Map,
        });
      }
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ailmentName),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Description: ${ailmentData['description']}'),
              SizedBox(height: 10),
              Text('Recommended Plants:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              if (matchedPlants.isEmpty)
                Text('No matching plants found.')
              else
                ...matchedPlants.map((plant) {
                  final plantName = plant['name'] as String;
                  final plantData = plant['data'] as Map;
                  final imagePath = plantData['image'] as String?;
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: imagePath != null
                          ? Image.asset(
                              getAdjustedImagePath(imagePath),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.image_not_supported,
                                    size: 50);
                              },
                            )
                          : Icon(Icons.image_not_supported, size: 50),
                      title: Text(plantName),
                      subtitle: Text('Click to view details'),
                      onTap: () {
                        Navigator.pop(context);
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
                }),
              SizedBox(height: 10),
              Text('Substitutes (if unavailable):',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(ailmentData['substitutes'].join(', ')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
