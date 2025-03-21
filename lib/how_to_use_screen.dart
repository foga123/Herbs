import 'package:flutter/material.dart';

class HowToUseScreen extends StatelessWidget {
  HowToUseScreen({super.key});

  Widget _buildSection({required String title, required List<String> content}) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 8),
            ...content.map((item) => Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(item, style: TextStyle(fontSize: 16)),
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            title: 'General Guidelines',
            content: [
              '• Always consult a healthcare professional before using herbal remedies, especially if you’re pregnant, nursing, or on medication.',
              '• Use fresh or dried herbs from a trusted source to ensure quality.',
              '• Start with small doses to test for allergic reactions.',
              '• Store herbs in a cool, dry place away from sunlight to maintain potency.',
              '• Follow dosage recommendations carefully to avoid side effects.',
            ],
          ),
          _buildSection(
            title: 'Dosage Recommendations',
            content: [
              '• Tea: Steep 1-2 teaspoons of dried herbs in 1 cup of hot water for 5-10 minutes, drink 1-3 times daily.',
              '• Tincture: Take 1-2 mL (about 20-40 drops) in water, 2-3 times daily.',
              '• Poultice: Apply crushed herbs to the affected area, leave for 20-30 minutes, and repeat as needed.',
              '• Ointment/Salve: Apply a thin layer to the affected area 2-3 times daily.',
              '• Inhalation: Add 1-2 teaspoons of dried herbs to a bowl of hot water, inhale steam for 5-10 minutes.',
            ],
          ),
          _buildSection(
            title: 'Preparation Methods',
            content: [
              '• Infusion: Steep leaves or flowers in hot water (e.g., chamomile tea).',
              '• Decoction: Boil roots, bark, or seeds in water for 10-15 minutes (e.g., ginger tea).',
              '• Poultice: Crush fresh leaves or roots and apply directly to the skin.',
              '• Tincture: Soak herbs in alcohol or vinegar for 2-4 weeks, then strain.',
              '• Salve: Mix infused oil with beeswax and apply to skin.',
            ],
          ),
          _buildSection(
            title: 'Safety Tips',
            content: [
              '• Avoid overuse; more is not always better with herbal remedies.',
              '• Be aware of potential interactions with medications.',
              '• Discontinue use if you experience adverse reactions like rashes or nausea.',
              '• Keep herbs out of reach of children and pets.',
              '• Some plants (e.g., Nux Vomica) are toxic in large doses—always follow dosage guidelines.',
            ],
          ),
        ],
      ),
    );
  }
}
