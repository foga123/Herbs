import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'plant_detail_screen.dart';

String getAdjustedImagePath(String path) {
  String adjustedPath = kReleaseMode ? path.replaceFirst('../', '') : path;
  return adjustedPath;
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Box plantsBox;
  late final Box bookmarksBox;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    plantsBox = Hive.box('plants');
    bookmarksBox = Hive.box('bookmarks');
    _initializePlants();
  }

  void _initializePlants() {
    if (plantsBox.isEmpty) {
      plantsBox.putAll({
        'Aloe Vera': {
          'image': '../assets/images/aloe_vera.jpg',
          'plantInfo':
              'Aloe Vera (Aloe barbadensis miller) is a succulent plant native to the Arabian Peninsula and North Africa, widely cultivated for its thick, fleshy leaves filled with a soothing gel. Historically used by ancient Egyptians for skin ailments and dubbed the "plant of immortality," it thrives in arid climates and is now a popular houseplant and ingredient in cosmetics.',
          'medicalUse': {
            'Burns': 'Soothes minor burns',
            'Wounds': 'Promotes healing',
          },
          'partsUsed': 'Leaves (gel)',
          'howToUse':
              'Cut a fresh leaf lengthwise, scoop out the clear gel with a spoon, and apply it directly to the affected skin area. For burns or wounds, cover with a clean bandage and leave for 20-30 minutes, repeating 2-3 times daily until healed.',
        },
        'Basil': {
          'image': '../assets/images/basil.jpg',
          'plantInfo':
              'Basil (Ocimum basilicum), also known as Tulsi or holy basil in parts of Asia, is an aromatic herb native to India and Southeast Asia, revered in Ayurvedic medicine and Hindu culture. Its vibrant green leaves release a peppery, slightly sweet scent, and it’s commonly grown in warm climates as both a culinary spice and a medicinal plant.',
          'medicalUse': {
            'Cough': 'Reduces irritation',
            'Digestive Issues': 'Eases bloating'
          },
          'partsUsed': 'Leaves and Flowers',
          'howToUse':
              'Boil 10-15 fresh leaves and a few flowers in 2 cups of water for 10 minutes, strain, and sip as tea to relieve cough or bloating. Alternatively, chew 3-5 fresh leaves daily to aid digestion.',
        },
        'Chamomile': {
          'image': '../assets/images/chamomile.jpg',
          'plantInfo':
              'Chamomile (Matricaria chamomilla) is a daisy-like herb native to Europe and Western Asia, prized for its small, white flowers with yellow centers that have been used since ancient times to calm nerves and aid sleep. Often found in temperate regions, it grows as a low, feathery plant and is a staple in herbal teas worldwide.',
          'medicalUse': {
            'Anxiety': 'Calms nerves',
            'Sleep Disorders': 'Promotes sleep'
          },
          'partsUsed': 'Flowers',
          'howToUse':
              'Steep 1-2 teaspoons of dried flowers in 1 cup of hot water for 5-10 minutes, strain, and drink 30 minutes before bedtime to promote sleep or reduce anxiety. Add honey if desired.',
        },
        'Ginger': {
          'image': '../assets/images/ginger.jpg',
          'plantInfo':
              'Ginger (Zingiber officinale) is a flowering plant native to Southeast Asia, valued for its knobby, aromatic rhizomes that have been a cornerstone of traditional Chinese and Indian medicine for centuries. With its spicy, warming flavor, this tropical perennial thrives in humid climates and is used both as a spice and a remedy for digestive and cold-related ailments.',
          'medicalUse': {'Nausea': 'Reduces vomiting', 'Cold': 'Warms body'},
          'partsUsed': 'Roots',
          'howToUse':
              'Peel and grate 1-2 teaspoons of fresh ginger root, boil in 2 cups of water for 10-15 minutes, strain, and drink warm to ease nausea or colds. Add lemon or honey for taste.',
        },
        'Turmeric': {
          'image': '../assets/images/turmeric.jpg',
          'plantInfo':
              'Turmeric (Curcuma longa), known as Luyang Dilaw in the Philippines, is a bright yellow-orange rhizome native to South Asia, celebrated in Ayurvedic and Chinese medicine for its anti-inflammatory properties. A member of the ginger family, it grows in tropical regions and has been used for over 4,000 years as a dye, spice, and healing agent.',
          'medicalUse': {
            'Arthritis': 'Reduces inflammation',
            'Wounds': 'Aids healing'
          },
          'partsUsed': 'Roots',
          'howToUse':
              'Grate 1 teaspoon of fresh turmeric root, mix with 1 cup of warm milk and a pinch of black pepper (to enhance absorption), and drink daily for arthritis relief. For wounds, make a paste with water and apply to the area, covering with a bandage for 20 minutes.',
        },
        'Lagundi': {
          'image': '../assets/images/lagundi.jpg',
          'plantInfo':
              'Lagundi (Vitex negundo) is a shrub or small tree native to Southeast Asia, particularly the Philippines, where it’s recognized as one of the country’s ten medicinal plants approved by the Department of Health. With its clusters of purple flowers and serrated leaves, it’s traditionally used by indigenous communities to treat respiratory issues and fevers.',
          'medicalUse': {'Cough': 'Relieves asthma', 'Fever': 'Reduces fever'},
          'partsUsed': 'Leaves',
          'howToUse':
              'Boil 10-15 fresh leaves in 2 cups of water for 15 minutes, strain, and drink 1 cup 2-3 times daily to relieve cough or reduce fever. For asthma, inhale the steam from the boiling leaves.',
        },
        'Sambong': {
          'image': '../assets/images/sambong.jpg',
          'plantInfo':
              'Sambong (Blumea balsamifera) is a tall, leafy shrub native to Southeast Asia, including the Philippines, where it’s valued for its camphor-scented leaves and traditional use in treating kidney stones and hypertension. Often found in open fields and grasslands, it grows up to 4 meters and has been a key part of Filipino herbal medicine for generations.',
          'medicalUse': {
            'Kidney Stones': 'Dissolves stones',
            'Hypertension': 'Lowers pressure'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Boil 2 handfuls of fresh leaves in 4 cups of water for 20 minutes, strain, and drink 1 cup 3 times daily to help dissolve kidney stones or lower blood pressure. Consult a doctor for prolonged use.',
        },
        'Ampalaya': {
          'image': '../assets/images/ampalaya.jpg',
          'plantInfo':
              'Ampalaya (Momordica charantia), commonly known as bitter melon, is a climbing vine native to tropical Asia and Africa, distinguished by its wrinkled, green fruit that’s a staple in Filipino cuisine and medicine. Rich in vitamins and antioxidants, it’s been used for centuries in traditional practices to manage diabetes and boost immunity.',
          'medicalUse': {'Diabetes': 'Lowers blood sugar'},
          'partsUsed': 'Fruits and Leaves',
          'howToUse':
              'Juice 1 small fresh fruit (remove seeds) or boil 10 leaves in 2 cups of water for 15 minutes, strain, and drink 1 cup daily to help manage blood sugar. Monitor levels closely and consult a healthcare provider.',
        },
        'Guava': {
          'image': '../assets/images/guava.jpg',
          'plantInfo':
              'Guava (Psidium guajava) is a tropical tree native to Central America and the Caribbean, now widespread in Asia, including the Philippines, where its leaves are prized for their medicinal properties. The plant produces sweet, juicy fruits, but its leaves are often used in herbal remedies for their antimicrobial and astringent effects.',
          'medicalUse': {
            'Diarrhea': 'Reduces symptoms',
            'Wounds': 'Promotes healing'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Boil 10-15 fresh leaves in 2 cups of water for 10 minutes, strain, and drink 1 cup 2-3 times daily to reduce diarrhea. For wounds, crush fresh leaves, apply as a poultice, and cover with a bandage for 30 minutes.',
        },
        'Tsaang Gubat': {
          'image': '../assets/images/tsaang_gubat.jpg',
          'plantInfo':
              'Tsaang Gubat (Ehretia microphylla) is a small, evergreen shrub native to the Philippines, often found in forests and used in traditional medicine for its anti-inflammatory properties. Known as "wild tea," its leaves resemble tea leaves and have been used by Filipino communities to treat stomach issues and skin conditions.',
          'medicalUse': {
            'Abdominal Pain': 'Relieves pain',
            'Diarrhea': 'Reduces symptoms'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Boil 1 handful of fresh leaves in 2 cups of water for 15 minutes, strain, and drink 1 cup 2 times daily to relieve abdominal pain or diarrhea. Alternatively, use the cooled tea as a wash for skin irritations.',
        },
        'Yerba Buena': {
          'image': '../assets/images/yerba_buena.jpg',
          'plantInfo':
              'Yerba Buena (Mentha cordifolia) is a creeping herb native to Asia, including the Philippines, known for its minty aroma and cooling effect. Often called "peppermint" in the Philippines, it’s a popular remedy in Filipino households, used for its analgesic and anti-inflammatory properties in treating pain and swelling.',
          'medicalUse': {
            'Headache': 'Relieves pain',
            'Arthritis': 'Reduces inflammation'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Crush 10-12 fresh leaves, wrap in a clean cloth, and apply as a poultice to the forehead for headaches or joints for arthritis relief, leaving it on for 20-30 minutes. Alternatively, boil leaves in water and inhale the steam.',
        },
        'Niyog-niyogan': {
          'image': '../assets/images/niyog_niyogan.jpg',
          'plantInfo':
              'Niyog-niyogan (Quisqualis indica) is a climbing shrub native to Southeast Asia, known in the Philippines for its seeds that resemble small coconuts, hence the name "coconut-like." Traditionally used as an anthelmintic, its seeds are consumed to expel intestinal worms, and the plant is often grown as an ornamental vine.',
          'medicalUse': {'Intestinal Worms': 'Expels worms'},
          'partsUsed': 'Seeds',
          'howToUse':
              'Dry and roast 5-10 mature seeds, eat them directly (chew well) 2 hours after a meal to expel intestinal worms. Limit to 1 dose per day and consult a doctor, especially for children.',
        },
        'Akapulko': {
          'image': '../assets/images/akapulko.jpg',
          'plantInfo':
              'Akapulko (Senna alata), also known as "ringworm bush," is a flowering shrub native to tropical regions, including the Philippines, where it’s widely used for treating skin infections. Its yellow flowers and long pods are distinctive, and its leaves contain antifungal compounds effective against fungal conditions like ringworm.',
          'medicalUse': {
            'Ringworm': 'Treats infection',
            'Skin Infections': 'Fights bacteria'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Crush 5-10 fresh leaves into a paste, apply directly to the affected skin area, and leave for 30 minutes before rinsing off. Repeat twice daily for ringworm or skin infections until cleared.',
        },
        'Pansit-pansitan': {
          'image': '../assets/images/pansit_pansitan.jpg',
          'plantInfo':
              'Pansit-pansitan (Peperomia pellucida) is a small, succulent herb native to tropical and subtropical regions, including the Philippines, where it’s commonly found in shady, damp areas. Known as "shiny bush," its heart-shaped leaves are used in traditional medicine for their anti-inflammatory and analgesic properties.',
          'medicalUse': {
            'Gout': 'Reduces uric acid',
            'Rheumatism': 'Relieves pain'
          },
          'partsUsed': 'Leaves and Stems',
          'howToUse':
              'Eat 1 cup of fresh leaves and stems raw as a salad daily to reduce uric acid levels in gout. Alternatively, boil 1 handful in 2 cups of water for 10 minutes, strain, and drink 1 cup twice daily for rheumatism relief.',
        },
        'Banaba': {
          'image': '../assets/images/banaba.jpg',
          'plantInfo':
              'Banaba (Lagerstroemia speciosa) is a flowering tree native to Southeast Asia, including the Philippines, known for its vibrant purple flowers and medicinal leaves. Used in traditional medicine for centuries, its leaves contain corosolic acid, which is believed to help regulate blood sugar and support kidney health.',
          'medicalUse': {
            'Diabetes': 'Lowers blood sugar',
            'Kidney Health': 'Supports function'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Boil 10-15 dried leaves in 3 cups of water for 15 minutes, strain, and drink 1 cup 2-3 times daily to manage blood sugar or support kidney health. Monitor blood sugar levels and consult a doctor.',
        },
        'Gotu Kola': {
          'image': '../assets/images/gotu_kola.jpg',
          'plantInfo':
              'Gotu Kola (Centella asiatica) is a small, creeping herb native to wetlands in Asia, including the Philippines, where it’s valued in traditional medicine for its cognitive and healing benefits. Known as a "longevity herb" in Ayurveda, its fan-shaped leaves are often used to improve memory and heal wounds.',
          'medicalUse': {
            'Fever': 'Reduces fever',
            'Menstrual Complaints': 'Eases pain'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Boil 1 handful of fresh leaves in 2 cups of water for 10 minutes, strain, and drink 1 cup twice daily to reduce fever or ease menstrual pain. Alternatively, crush leaves into a paste and apply to minor wounds for healing.',
        },
        'Siling Labuyo': {
          'image': '../assets/images/siling_labuyo.jpg',
          'plantInfo':
              'Siling Labuyo (Capsicum frutescens) is a small, fiery chili pepper native to the Philippines, known for its intense heat and bright red or green fruits. Used in both cuisine and traditional medicine, it contains capsaicin, which provides its warming effects and stimulates circulation and digestion.',
          'medicalUse': {
            'Cold': 'Clears congestion',
            'Poor Appetite': 'Stimulates appetite'
          },
          'partsUsed': 'Fruits',
          'howToUse':
              'Chop 1-2 fresh chilis, boil in 2 cups of water for 10 minutes, strain, and sip slowly to clear congestion or boost appetite. Alternatively, add finely chopped chilis to meals for a warming effect.',
        },
        'Malunggay': {
          'image': '../assets/images/malunggay.jpg',
          'plantInfo':
              'Malunggay (Moringa oleifera), often called the "miracle tree," is a fast-growing tree native to South Asia but widely cultivated in the Philippines, where it’s a nutritional powerhouse. Its leaves are rich in vitamins, minerals, and antioxidants, making it a popular remedy for malnutrition and anemia.',
          'medicalUse': {
            'Malnutrition': 'Boosts nutrition',
            'Anemia': 'Increases iron'
          },
          'partsUsed': 'Leaves and Pods',
          'howToUse':
              'Cook 1 cup of fresh leaves in soups or stews daily to boost nutrition and combat anemia. Alternatively, boil 1 handful of leaves in 2 cups of water for 10 minutes, strain, and drink as tea twice daily.',
        },
        'Pandan': {
          'image': '../assets/images/pandan.jpg',
          'plantInfo':
              'Pandan (Pandanus amaryllifolius) is a tropical plant native to Southeast Asia, including the Philippines, known for its long, fragrant leaves that are widely used in cooking for their sweet, grassy aroma. In traditional medicine, its leaves are used for their analgesic properties to relieve pain.',
          'medicalUse': {
            'Headache': 'Relieves pain',
            'Rheumatism': 'Eases discomfort'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Boil 5-7 fresh leaves in 3 cups of water for 15 minutes, strain, and drink 1 cup twice daily for headache relief. For rheumatism, soak crushed leaves in warm water and use as a bath soak for 20 minutes.',
        },
        'Calendula': {
          'image': '../assets/images/calendula.jpg',
          'plantInfo':
              'Calendula (Calendula officinalis), commonly known as marigold, is a bright orange or yellow flowering herb native to the Mediterranean, used for centuries in European and Ayurvedic medicine. Its flowers are known for their anti-inflammatory and antimicrobial properties, making it a go-to for skin issues.',
          'medicalUse': {
            'Burns': 'Soothes burns',
            'Wounds': 'Promotes healing'
          },
          'partsUsed': 'Flowers',
          'howToUse':
              'Steep 1 tablespoon of dried flowers in 1 cup of hot water for 10 minutes, strain, and use the cooled liquid to wash burns or wounds. Alternatively, mix petals with a carrier oil (like olive oil) to create a salve and apply to skin twice daily.',
        },
        'Ashwagandha': {
          'image': '../assets/images/ashwagandha.jpg',
          'plantInfo':
              'Ashwagandha (Withania somnifera) is a small shrub native to India, the Middle East, and parts of Africa, revered in Ayurvedic medicine as an adaptogen for over 3,000 years. Known as "Indian ginseng," its roots and berries are used to reduce stress and boost vitality, thriving in dry, subtropical climates.',
          'medicalUse': {
            'Stress': 'Reduces stress',
            'Fatigue': 'Boosts energy'
          },
          'partsUsed': 'Roots and Berries',
          'howToUse':
              'Boil 1 teaspoon of dried root powder in 2 cups of water for 15 minutes, strain, and drink 1 cup daily to reduce stress or fatigue. Alternatively, mix 1/2 teaspoon of root powder with warm milk and honey before bed.',
        },
        'Catnip': {
          'image': '../assets/images/catnip.jpg',
          'plantInfo':
              'Catnip (Nepeta cataria) is a perennial herb native to Europe and Asia, now naturalized in North America, famous for its euphoric effect on cats but also valued in herbal medicine for humans. With its heart-shaped leaves and small white or purple flowers, it’s often used to calm nerves and aid sleep.',
          'medicalUse': {
            'Anxiety': 'Calms nerves',
            'Insomnia': 'Promotes sleep'
          },
          'partsUsed': 'Leaves and Flowers',
          'howToUse':
              'Steep 1-2 teaspoons of dried leaves and flowers in 1 cup of hot water for 10 minutes, strain, and drink 30 minutes before bed to ease anxiety or promote sleep. Add a pinch of honey for flavor.',
        },
        'Cayenne': {
          'image': '../assets/images/cayenne.jpg',
          'plantInfo':
              'Cayenne (Capsicum annuum) is a type of chili pepper native to Central and South America, now cultivated worldwide for its fiery red fruits packed with capsaicin. Used in traditional medicine for its warming properties, it’s a staple in both culinary and medicinal practices to boost circulation and relieve pain.',
          'medicalUse': {
            'Pain': 'Relieves pain',
            'Circulation Issues': 'Improves blood flow'
          },
          'partsUsed': 'Fruits',
          'howToUse':
              'Mix 1/4 teaspoon of dried cayenne powder with 1 tablespoon of a carrier oil (like coconut oil) to make a salve, and apply sparingly to painful areas for relief. For circulation, add a pinch to food or boil in water for a spicy tea, drinking once daily.',
        },
        'Cinnamon': {
          'image': '../assets/images/cinnamon.jpg',
          'plantInfo':
              'Cinnamon (Cinnamomum verum) is a spice derived from the inner bark of trees native to Sri Lanka and South India, used for thousands of years in cooking and medicine. Known for its warm, sweet flavor and aroma, it’s harvested from evergreen trees and valued for its antimicrobial and blood sugar-regulating properties.',
          'medicalUse': {
            'Diabetes': 'Lowers blood sugar',
            'Infections': 'Fights bacteria'
          },
          'partsUsed': 'Bark',
          'howToUse':
              'Boil 1 small cinnamon stick (or 1/2 teaspoon powder) in 2 cups of water for 10 minutes, strain, and drink 1 cup daily to help regulate blood sugar or fight infections. Add to oatmeal or tea for flavor.',
        },
        'Dandelion': {
          'image': '../assets/images/dandelion.jpg',
          'plantInfo':
              'Dandelion (Taraxacum officinale) is a flowering plant native to Eurasia and North America, often considered a weed but prized in herbal medicine for its detoxifying properties. With its bright yellow flowers and jagged leaves, every part of the plant—root, leaf, and flower—is used to support liver and kidney health.',
          'medicalUse': {
            'Liver Issues': 'Detoxifies liver',
            'Anemia': 'Boosts iron'
          },
          'partsUsed': 'Roots and Leaves',
          'howToUse':
              'Roast 1 tablespoon of dried roots, boil in 2 cups of water for 15 minutes, strain, and drink 1 cup daily for liver detox. For anemia, steep 1 handful of fresh leaves in hot water for 10 minutes and drink as tea twice daily.',
        },
        'Echinacea': {
          'image': '../assets/images/echinacea.jpg',
          'plantInfo':
              'Echinacea (Echinacea purpurea) is a flowering herb native to North America, widely used by Native Americans for its immune-boosting properties. Known as purple coneflower, its vibrant pinkish-purple petals and spiky center make it a popular garden plant, often used to prevent and treat colds and infections.',
          'medicalUse': {'Cold': 'Boosts immunity', 'Flu': 'Reduces symptoms'},
          'partsUsed': 'Roots and Flowers',
          'howToUse':
              'Steep 1 teaspoon of dried roots or flowers in 1 cup of hot water for 10-15 minutes, strain, and drink 2-3 times daily at the onset of a cold or flu to boost immunity and reduce symptoms.',
        },
        'Elderberry': {
          'image': '../assets/images/elderberry.jpg',
          'plantInfo':
              'Elderberry (Sambucus nigra) is a small tree or shrub native to Europe and North America, known for its clusters of dark purple berries and white flowers, used for centuries in traditional medicine. Rich in antioxidants, it’s a popular remedy for colds and flu, often found in temperate regions near woodlands.',
          'medicalUse': {'Cold': 'Reduces symptoms', 'Flu': 'Boosts immunity'},
          'partsUsed': 'Berries and Flowers',
          'howToUse':
              'Simmer 1 cup of fresh (or 1/2 cup dried) berries in 3 cups of water for 20 minutes, strain, and drink 1 cup 2-3 times daily for cold or flu relief. Alternatively, steep dried flowers for tea to boost immunity.',
        },
        'Fennel': {
          'image': '../assets/images/fennel.jpg',
          'plantInfo':
              'Fennel (Foeniculum vulgare) is a flowering plant native to the Mediterranean, now cultivated worldwide for its feathery leaves, yellow flowers, and aromatic seeds. Used in both culinary and medicinal practices, its anise-like flavor comes from compounds that aid digestion and soothe colic, thriving in sunny, well-drained soils.',
          'medicalUse': {
            'Abdominal Pain': 'Relieves pain',
            'Colic': 'Soothes infants'
          },
          'partsUsed': 'Seeds and Leaves',
          'howToUse':
              'Crush 1 teaspoon of fennel seeds, steep in 1 cup of hot water for 10 minutes, strain, and drink after meals to relieve abdominal pain. For colic, give infants 1-2 teaspoons of cooled tea (consult a pediatrician first).',
        },
        'Fenugreek': {
          'image': '../assets/images/fenugreek.jpg',
          'plantInfo':
              'Fenugreek (Trigonella foenum-graecum) is an annual herb native to the Mediterranean, southern Europe, and western Asia, known for its small, golden seeds and clover-like leaves. Used in traditional medicine and cooking, it’s valued for its ability to support lactation and manage blood sugar, thriving in semi-arid climates.',
          'medicalUse': {
            'Diabetes': 'Lowers blood sugar',
            'Lactation Issues': 'Boosts milk supply'
          },
          'partsUsed': 'Seeds',
          'howToUse':
              'Soak 1 teaspoon of seeds in water overnight, boil in 2 cups of water for 10 minutes, strain, and drink daily to lower blood sugar. For lactation, chew soaked seeds or drink the tea 2-3 times daily.',
        },
        'Garlic': {
          'image': '../assets/images/garlic.jpg',
          'plantInfo':
              'Garlic (Allium sativum) is a bulbous plant native to Central Asia, cultivated for over 5,000 years for its pungent bulbs, used in cooking and medicine across cultures. Known for its antimicrobial and cardiovascular benefits, it grows in temperate climates and is a staple in natural remedies worldwide.',
          'medicalUse': {
            'Infections': 'Fights bacteria',
            'Hypertension': 'Lowers pressure'
          },
          'partsUsed': 'Bulbs',
          'howToUse':
              'Crush 1-2 fresh cloves, let sit for 10 minutes, then eat raw with honey or add to food to fight infections. For hypertension, roast cloves and consume 1-2 daily or steep in hot water for tea.',
        },
        'Ginseng': {
          'image': '../assets/images/ginseng.jpg',
          'plantInfo':
              'Ginseng (Panax ginseng) is a slow-growing perennial herb native to East Asia, particularly Korea and China, prized for its fleshy roots that have been used in traditional Chinese medicine for over 2,000 years. Known as an adaptogen, it helps combat stress and fatigue, thriving in cool, shaded forests.',
          'medicalUse': {
            'Fatigue': 'Boosts energy',
            'Stress': 'Reduces stress'
          },
          'partsUsed': 'Roots',
          'howToUse':
              'Boil 1-2 teaspoons of dried root slices in 2 cups of water for 20 minutes, strain, and drink 1 cup daily to boost energy or reduce stress. Alternatively, mix 1/2 teaspoon of ginseng powder into tea or smoothies.',
        },
        'Hawthorn': {
          'image': '../assets/images/hawthorn.jpg',
          'plantInfo':
              'Hawthorn (Crataegus monogyna) is a thorny shrub or small tree native to Europe, North America, and Asia, known for its white flowers, red berries, and heart-supporting properties. Used in traditional European medicine since the Middle Ages, it grows in temperate regions and is often planted as a hedge.',
          'medicalUse': {
            'Heart Disease': 'Supports heart',
            'Hypertension': 'Lowers pressure'
          },
          'partsUsed': 'Berries and Leaves',
          'howToUse':
              'Boil 1 tablespoon of dried berries or leaves in 2 cups of water for 15 minutes, strain, and drink 1 cup twice daily to support heart health or lower blood pressure. Consult a doctor for heart conditions.',
        },
        'Holy Basil': {
          'image': '../assets/images/holy_basil.jpg',
          'plantInfo':
              'Holy Basil (Ocimum tenuiflorum), also known as Tulsi, is a sacred herb native to India, revered in Hinduism and used in Ayurvedic medicine for its adaptogenic properties. With its purple-tinged leaves and clove-like aroma, it’s grown in tropical climates and used to reduce stress and boost immunity.',
          'medicalUse': {'Cold': 'Boosts immunity', 'Stress': 'Reduces stress'},
          'partsUsed': 'Leaves',
          'howToUse':
              'Boil 10-12 fresh leaves in 2 cups of water for 10 minutes, strain, and drink 1 cup twice daily to boost immunity or reduce stress. Chew 5-7 leaves daily as an alternative.',
        },
        'Lavender': {
          'image': '../assets/images/lavender.jpg',
          'plantInfo':
              'Lavender (Lavandula angustifolia) is a fragrant herb native to the Mediterranean, known for its purple flowers and calming scent, used in aromatherapy and herbal medicine for centuries. Thriving in sunny, well-drained soils, it’s a popular garden plant and remedy for stress and sleep issues.',
          'medicalUse': {
            'Stress': 'Calms nerves',
            'Insomnia': 'Promotes sleep'
          },
          'partsUsed': 'Flowers',
          'howToUse':
              'Steep 1-2 teaspoons of dried flowers in 1 cup of hot water for 10 minutes, strain, and drink before bed to reduce stress or aid sleep. Alternatively, add dried flowers to a pillow for aromatherapy.',
        },
        'Lemon Balm': {
          'image': '../assets/images/lemon_balm.jpg',
          'plantInfo':
              'Lemon Balm (Melissa officinalis) is a perennial herb native to Europe and the Mediterranean, known for its lemon-scented leaves and calming effects, used since the Middle Ages to reduce anxiety. A member of the mint family, it grows in temperate climates and is often used in teas and aromatherapy.',
          'medicalUse': {
            'Anxiety': 'Reduces anxiety',
            'Insomnia': 'Promotes sleep'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Steep 1 tablespoon of fresh (or 1 teaspoon dried) leaves in 1 cup of hot water for 10 minutes, strain, and drink 1-2 times daily to ease anxiety or promote sleep. Add honey for taste.',
        },
        'Licorice': {
          'image': '../assets/images/licorice.jpg',
          'plantInfo':
              'Licorice (Glycyrrhiza glabra) is a perennial herb native to southern Europe and parts of Asia, valued for its sweet roots that have been used in medicine and confections for thousands of years. Known for its soothing properties, it grows in sandy soils and is used to treat throat and digestive issues.',
          'medicalUse': {
            'Sore Throat': 'Soothes throat',
            'Ulcers': 'Protects stomach'
          },
          'partsUsed': 'Roots',
          'howToUse':
              'Boil 1 teaspoon of dried root in 2 cups of water for 10-15 minutes, strain, and drink 1 cup twice daily to soothe a sore throat or protect against ulcers. Avoid prolonged use due to potential side effects.',
        },
        'Milk Thistle': {
          'image': '../assets/images/milk_thistle.jpg',
          'plantInfo':
              'Milk Thistle (Silybum marianum) is a prickly herb native to the Mediterranean, recognized by its purple flowers and white-veined leaves, used for over 2,000 years to support liver health. Its seeds contain silymarin, a compound known for its detoxifying effects, and it thrives in dry, rocky soils.',
          'medicalUse': {
            'Liver Issues': 'Protects liver',
            'Gallstones': 'Supports detox'
          },
          'partsUsed': 'Seeds',
          'howToUse':
              'Grind 1 teaspoon of seeds into a powder, boil in 2 cups of water for 15 minutes, strain, and drink 1 cup daily to support liver health or detoxify. Alternatively, take as a supplement after consulting a doctor.',
        },
        'Mint': {
          'image': '../assets/images/mint.jpg',
          'plantInfo':
              'Mint (Mentha) encompasses a variety of species, including spearmint and peppermint, native to Europe and Asia but now grown worldwide for their refreshing aroma and flavor. Used in traditional medicine for its cooling and digestive properties, it’s a hardy perennial that thrives in moist, shaded areas.',
          'medicalUse': {
            'Digestive Issues': 'Eases bloating',
            'Headache': 'Relieves pain'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Steep 10-15 fresh leaves in 1 cup of hot water for 10 minutes, strain, and drink after meals to ease bloating. For headaches, crush leaves, wrap in a cloth, and apply to the forehead for 20 minutes.',
        },
        'Mullein': {
          'image': '../assets/images/mullein.jpg',
          'plantInfo':
              'Mullein (Verbascum thapsus) is a tall, fuzzy-leaved herb native to Europe and Asia, naturalized in North America, where it’s been used by Native Americans for respiratory ailments. Known for its yellow flower spikes, it grows in dry, sunny areas and is often used to soothe coughs and earaches.',
          'medicalUse': {'Cough': 'Soothes lungs', 'Earache': 'Relieves pain'},
          'partsUsed': 'Leaves and Flowers',
          'howToUse':
              'Steep 1-2 teaspoons of dried leaves or flowers in 1 cup of hot water for 10-15 minutes, strain, and drink 2-3 times daily to soothe coughs. For earaches, infuse flowers in olive oil, strain, and apply 2-3 drops to the affected ear (consult a doctor).',
        },
        'Oregano': {
          'image': '../assets/images/oregano.jpg',
          'plantInfo':
              'Oregano (Origanum vulgare) is a perennial herb native to the Mediterranean, known for its aromatic leaves used in cooking and medicine, particularly for their antimicrobial properties. Thriving in warm, sunny climates, it’s a staple in herbal remedies for infections and respiratory issues.',
          'medicalUse': {
            'Cold': 'Fights infection',
            'Infections': 'Antimicrobial'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Boil 1 tablespoon of fresh (or 1 teaspoon dried) leaves in 2 cups of water for 10 minutes, strain, and drink 1 cup 2-3 times daily to fight colds or infections. Alternatively, use as a steam inhalation for respiratory relief.',
        },
        'Parsley': {
          'image': '../assets/images/parsley.jpg',
          'plantInfo':
              'Parsley (Petroselinum crispum) is a biennial herb native to the Mediterranean, widely used as a garnish but also valued in herbal medicine for its diuretic and breath-freshening properties. With its bright green, curly or flat leaves, it grows in temperate climates and is rich in vitamins A, C, and K.',
          'medicalUse': {'Bad Breath': 'Freshens breath'},
          'partsUsed': 'Leaves',
          'howToUse':
              'Chew a small handful of fresh leaves after meals to freshen breath. Alternatively, boil 1 cup of chopped leaves in 2 cups of water for 10 minutes, strain, and use as a mouth rinse twice daily.',
        },
        'Passionflower': {
          'image': '../assets/images/passionflower.jpg',
          'plantInfo':
              'Passionflower (Passiflora incarnata) is a climbing vine native to the southeastern United States and Central America, known for its striking purple and white flowers and calming effects. Used by Native Americans for anxiety and sleep, it grows in warm climates and is often used in herbal teas for relaxation.',
          'medicalUse': {
            'Anxiety': 'Reduces anxiety',
            'Insomnia': 'Promotes sleep'
          },
          'partsUsed': 'Leaves and Flowers',
          'howToUse':
              'Steep 1 teaspoon of dried leaves and flowers in 1 cup of hot water for 10 minutes, strain, and drink 1 hour before bed to reduce anxiety or promote sleep. Repeat up to 2 times daily if needed.',
        },
        'Peppermint': {
          'image': '../assets/images/peppermint.jpg',
          'plantInfo':
              'Peppermint (Mentha × piperita) is a hybrid herb of watermint and spearmint, native to Europe and the Middle East, known for its strong, cooling menthol flavor and aroma. Used for centuries in medicine, it grows in moist, shaded areas and is a popular remedy for digestive issues and headaches.',
          'medicalUse': {
            'Digestive Issues': 'Relieves bloating',
            'Headache': 'Eases pain'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Steep 10-12 fresh leaves in 1 cup of hot water for 10 minutes, strain, and drink after meals to relieve bloating. For headaches, rub crushed leaves on the temples or inhale steam from a hot infusion.',
        },
        'Plantain': {
          'image': '../assets/images/plantain.jpg',
          'plantInfo':
              'Plantain (Plantago major) is a low-growing herb native to Europe and Asia, often considered a weed but used in herbal medicine for its anti-inflammatory and wound-healing properties. With its broad, ribbed leaves, it thrives in disturbed soils and has been used since ancient times for skin irritations.',
          'medicalUse': {
            'Wounds': 'Promotes healing',
            'Insect Bites': 'Soothes irritation'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Crush 5-7 fresh leaves into a paste, apply to wounds or insect bites, and cover with a bandage for 20-30 minutes to promote healing or soothe irritation. Repeat 2-3 times daily as needed.',
        },
        'Rosemary': {
          'image': '../assets/images/rosemary.jpg',
          'plantInfo':
              'Rosemary (Rosmarinus officinalis) is a woody, evergreen herb native to the Mediterranean, known for its needle-like leaves and piney aroma, used in cooking and medicine for centuries. Thriving in sunny, well-drained soils, it’s valued for improving memory and treating hair loss in traditional remedies.',
          'medicalUse': {
            'Memory Loss': 'Improves memory',
            'Hair Loss': 'Stimulates growth'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Boil 1 tablespoon of fresh leaves in 2 cups of water for 15 minutes, strain, and drink 1 cup daily to improve memory. For hair loss, cool the infusion, and use as a rinse after shampooing, massaging into the scalp.',
        },
        'Sage': {
          'image': '../assets/images/sage.jpg',
          'plantInfo':
              'Sage (Salvia officinalis) is a perennial herb native to the Mediterranean, known for its soft, gray-green leaves and earthy flavor, used in both culinary and medicinal practices. Revered since ancient times for its healing properties, it grows in sunny climates and is often used for throat and memory issues.',
          'medicalUse': {
            'Sore Throat': 'Soothes throat',
            'Memory Loss': 'Improves memory'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Steep 1 teaspoon of dried leaves in 1 cup of hot water for 10 minutes, strain, and gargle warm to soothe a sore throat, or drink 1 cup daily to enhance memory. Use fresh leaves for stronger effects.',
        },
        'St. John’s Wort': {
          'image': '../assets/images/st_johns_wort.jpg',
          'plantInfo':
              'St. John’s Wort (Hypericum perforatum) is a flowering herb native to Europe, known for its bright yellow flowers and use in treating depression since ancient Greece. Growing in temperate regions, it’s often found in meadows and is a popular herbal remedy, though it can interact with medications.',
          'medicalUse': {
            'Depression': 'Lifts mood',
            'Nerve Pain': 'Relieves pain'
          },
          'partsUsed': 'Flowers and Leaves',
          'howToUse':
              'Steep 1-2 teaspoons of dried flowers and leaves in 1 cup of hot water for 10 minutes, strain, and drink 1-2 times daily to lift mood or ease nerve pain. Consult a doctor due to potential drug interactions.',
        },
        'Thyme': {
          'image': '../assets/images/thyme.jpg',
          'plantInfo':
              'Thyme (Thymus vulgaris) is a small, aromatic herb native to the Mediterranean, used since ancient times for its antiseptic properties, including by the Egyptians for embalming. With its tiny leaves and woody stems, it thrives in sunny, dry climates and is a common remedy for coughs and infections.',
          'medicalUse': {
            'Cough': 'Soothes throat',
            'Infections': 'Fights bacteria'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Boil 1 tablespoon of fresh (or 1 teaspoon dried) leaves in 2 cups of water for 10 minutes, strain, and drink 1 cup 2-3 times daily to soothe coughs. For infections, use as a steam inhalation by inhaling the vapors.',
        },
        'Valerian': {
          'image': '../assets/images/valerian.jpg',
          'plantInfo':
              'Valerian (Valeriana officinalis) is a perennial herb native to Europe and Asia, known for its pink or white flowers and pungent roots, used since ancient Greece and Rome as a sedative. Growing in damp, temperate areas, it’s a popular natural remedy for insomnia and anxiety.',
          'medicalUse': {
            'Insomnia': 'Promotes sleep',
            'Anxiety': 'Calms nerves'
          },
          'partsUsed': 'Roots',
          'howToUse':
              'Boil 1 teaspoon of dried root in 2 cups of water for 15 minutes, strain, and drink 1 cup 30-60 minutes before bed to promote sleep or calm anxiety. Avoid combining with sedatives without medical advice.',
        },
        'Bilberry': {
          'image': '../assets/images/bilberry.jpg',
          'plantInfo':
              'Bilberry (Vaccinium myrtillus) is a small shrub native to Northern Europe, producing dark blue berries similar to blueberries, used since the Middle Ages for their vision-enhancing properties. Rich in antioxidants, it grows in acidic, mountainous soils and is often used for eye and digestive health.',
          'medicalUse': {
            'Eye Strain': 'Improves vision',
            'Diarrhea': 'Reduces symptoms'
          },
          'partsUsed': 'Berries',
          'howToUse':
              'Eat 1/2 cup of fresh berries daily to improve vision or reduce diarrhea. Alternatively, simmer 1 tablespoon of dried berries in 2 cups of water for 10 minutes, strain, and drink 1 cup twice daily.',
        },
        'Borage': {
          'image': '../assets/images/borage.jpg',
          'plantInfo':
              'Borage (Borago officinalis), also known as starflower, is an annual herb native to the Mediterranean region. It is known for its beautiful blue star-shaped flowers and is often used in salads for its cucumber-like taste. The leaves and flowers contain compounds that have anti-inflammatory properties and are used to soothe skin irritations and reduce inflammation.',
          'medicalUse': {
            'Skin Irritations': 'Soothes skin',
            'Inflammation': 'Reduces swelling'
          },
          'partsUsed': 'Leaves and Flowers',
          'howToUse':
              'Crush 5-7 fresh leaves and flowers, apply as a poultice to irritated skin for 20-30 minutes to soothe irritation. For inflammation, steep 1 tablespoon of dried flowers in 1 cup of hot water for 10 minutes, strain, and drink twice daily.',
        },
        'Comfrey': {
          'image': '../assets/images/comfrey.jpg',
          'plantInfo':
              'Comfrey (Symphytum officinale) is a perennial herb native to Europe, known for its large, hairy leaves and clusters of purple, pink, or white flowers. It has been traditionally used for its wound-healing properties due to the presence of allantoin, a compound that promotes cell growth and healing.',
          'medicalUse': {
            'Wounds': 'Promotes healing',
            'Bruises': 'Reduces discoloration'
          },
          'partsUsed': 'Leaves and Roots',
          'howToUse':
              'Crush 5-10 fresh leaves into a paste, apply to wounds or bruises, and cover with a bandage for 30 minutes to promote healing or reduce bruising. Alternatively, boil 1 teaspoon of dried root in water for a compress, applying it warm to the area.',
        },
        'Elderflower': {
          'image': '../assets/images/elderflower.jpg',
          'plantInfo':
              'Elderflower (Sambucus nigra) is a deciduous shrub native to Europe and North America, known for its clusters of creamy-white flowers that have a delicate, sweet scent. The flowers are often used in herbal teas and cordials, and they have anti-inflammatory and antiseptic properties that help alleviate cold and flu symptoms.',
          'medicalUse': {
            'Colds': 'Reduces symptoms',
            'Flu': 'Alleviates discomfort'
          },
          'partsUsed': 'Flowers',
          'howToUse':
              'Steep 1-2 teaspoons of dried flowers in 1 cup of hot water for 10 minutes, strain, and drink 2-3 times daily to reduce cold or flu symptoms. Alternatively, make a cordial by simmering flowers with sugar and water, diluting to taste.',
        },
        'Feverfew': {
          'image': '../assets/images/feverfew.jpg',
          'plantInfo':
              'Feverfew (Tanacetum parthenium) is a perennial herb native to the Balkans and is known for its daisy-like flowers and citrus-scented leaves. It has been traditionally used to treat fevers, headaches, and arthritis due to its anti-inflammatory properties.',
          'medicalUse': {
            'Headaches': 'Reduces pain',
            'Arthritis': 'Alleviates inflammation'
          },
          'partsUsed': 'Leaves and Flowers',
          'howToUse':
              'Steep 1 teaspoon of dried leaves and flowers in 1 cup of hot water for 10 minutes, strain, and drink 1-2 times daily to reduce headaches or arthritis pain. Alternatively, chew 2-3 fresh leaves daily (note: may cause mouth irritation).',
        },
        'Ginkgo': {
          'image': '../assets/images/ginkgo.jpg',
          'plantInfo':
              'Ginkgo (Ginkgo biloba) is a deciduous tree native to China, known for its distinctive fan-shaped leaves and its use in traditional Chinese medicine. The leaves contain compounds that improve blood circulation and have antioxidant properties, which help enhance cognitive function and memory.',
          'medicalUse': {
            'Memory Enhancement': 'Improves cognitive function',
            'Circulation': 'Enhances blood flow'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Steep 1 teaspoon of dried leaves in 1 cup of hot water for 10-15 minutes, strain, and drink 1-2 times daily to enhance memory or improve circulation. Consult a doctor for long-term use or supplements.',
        },
        'Goldenseal': {
          'image': '../assets/images/goldenseal.jpg',
          'plantInfo':
              'Goldenseal (Hydrastis canadensis) is a perennial herb native to North America, known for its bright yellow roots and anti-inflammatory properties. It has been traditionally used to treat digestive issues, respiratory infections, and skin conditions due to its high content of berberine, an alkaloid with antimicrobial properties.',
          'medicalUse': {
            'Digestive Issues': 'Soothes stomach',
            'Respiratory Infections': 'Fights bacteria'
          },
          'partsUsed': 'Roots',
          'howToUse':
              'Boil 1/2 teaspoon of dried root powder in 2 cups of water for 10 minutes, strain, and drink 1 cup twice daily to soothe digestive issues or fight respiratory infections. Use sparingly and consult a doctor.',
        },
        'Hops': {
          'image': '../assets/images/hops.jpg',
          'plantInfo':
              'Hops (Humulus lupulus) is a perennial climbing vine native to Europe, known for its use in beer brewing and its sedative properties. The female flowers, known as strobiles, contain compounds that have a calming effect and are used to treat insomnia and anxiety.',
          'medicalUse': {
            'Insomnia': 'Promotes sleep',
            'Anxiety': 'Calms nerves'
          },
          'partsUsed': 'Flowers',
          'howToUse':
              'Steep 1-2 teaspoons of dried hops flowers in 1 cup of hot water for 10 minutes, strain, and drink 30 minutes before bed to promote sleep or calm anxiety. Alternatively, stuff dried flowers into a pillow for aromatherapy.',
        },
        'Horsetail': {
          'image': '../assets/images/horsetail.jpg',
          'plantInfo':
              'Horsetail (Equisetum arvense) is a perennial herb native to Europe and North America, known for its distinctive, segmented hollow stems that resemble a horse’s tail. It has diuretic and astringent properties and is used to treat urinary tract infections and improve bone health due to its high silica content.',
          'medicalUse': {
            'Urinary Tract Infections': 'Reduces symptoms',
            'Bone Health': 'Strengthens bones'
          },
          'partsUsed': 'Stems',
          'howToUse':
              'Boil 1-2 teaspoons of dried stems in 2 cups of water for 15 minutes, strain, and drink 1 cup twice daily to reduce UTI symptoms or support bone health. Use for short periods and consult a doctor.',
        },
        'Lemon Verbena': {
          'image': '../assets/images/lemon_verbena.jpg',
          'plantInfo':
              'Lemon Verbena (Aloysia citrodora) is a deciduous shrub native to South America, known for its strong lemon scent and used in herbal teas and culinary dishes. The leaves contain essential oils that have a calming effect and are used to alleviate stress and improve digestion.',
          'medicalUse': {
            'Stress': 'Calms nerves',
            'Digestive Issues': 'Aids digestion'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Steep 5-7 fresh leaves (or 1 teaspoon dried) in 1 cup of hot water for 10 minutes, strain, and drink 1-2 times daily to calm stress or aid digestion. Add to desserts for flavor and benefits.',
        },
        'Marjoram': {
          'image': '../assets/images/marjoram.jpg',
          'plantInfo':
              'Marjoram (Origanum majorana) is a perennial herb native to the Mediterranean, known for its sweet, piney, and citrus flavor. It is used in cooking and has medicinal properties that help alleviate digestive issues, headaches, and respiratory problems.',
          'medicalUse': {
            'Digestive Issues': 'Eases discomfort',
            'Headaches': 'Relieves pain'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Steep 1 teaspoon of dried leaves in 1 cup of hot water for 10 minutes, strain, and drink after meals to ease digestion or relieve headaches. Alternatively, inhale steam from a hot infusion for respiratory relief.',
        },
        'Meadowsweet': {
          'image': '../assets/images/meadowsweet.jpg',
          'plantInfo':
              'Meadowsweet (Filipendula ulmaria) is a perennial herb native to Europe, known for its creamy-white flowers and sweet, almond-like scent. It contains salicylates, which have pain-relieving and anti-inflammatory properties, and is used to treat headaches, joint pain, and digestive issues.',
          'medicalUse': {
            'Headaches': 'Reduces pain',
            'Joint Pain': 'Alleviates discomfort'
          },
          'partsUsed': 'Flowers and Leaves',
          'howToUse':
              'Steep 1-2 teaspoons of dried flowers and leaves in 1 cup of hot water for 10-15 minutes, strain, and drink 1-2 times daily to reduce headaches or joint pain. Avoid if allergic to aspirin.',
        },
        'Nettle': {
          'image': '../assets/images/nettle.jpg',
          'plantInfo':
              'Nettle (Urtica dioica) is a perennial herb native to Europe, known for its stinging hairs and its use as a nutritious food source. It is rich in vitamins and minerals and has anti-inflammatory properties that help alleviate allergies, arthritis, and skin conditions.',
          'medicalUse': {
            'Allergies': 'Reduces symptoms',
            'Arthritis': 'Alleviates inflammation'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Boil 1 handful of fresh (or 1 tablespoon dried) leaves in 2 cups of water for 10 minutes, strain, and drink 1 cup twice daily to reduce allergy symptoms or arthritis inflammation. Wear gloves when handling fresh nettles.',
        },
        'Red Clover': {
          'image': '../assets/images/red_clover.jpg',
          'plantInfo':
              'Red Clover (Trifolium pratense) is a perennial herb native to Europe and Asia, known for its pink or red flowers. It contains isoflavones, which have estrogen-like effects and are used to alleviate menopausal symptoms, improve skin health, and support respiratory function.',
          'medicalUse': {
            'Menopausal Symptoms': 'Alleviates discomfort',
            'Skin Health': 'Improves complexion'
          },
          'partsUsed': 'Flowers',
          'howToUse':
              'Steep 1-2 teaspoons of dried flowers in 1 cup of hot water for 10-15 minutes, strain, and drink 1-2 times daily to ease menopausal symptoms. For skin, use cooled tea as a face wash or compress.',
        },
        'Skullcap': {
          'image': '../assets/images/skullcap.jpg',
          'plantInfo':
              'Skullcap (Scutellaria lateriflora) is a perennial herb native to North America, known for its small, blue or purple flowers that resemble a helmet or cap. It has sedative properties and is used to treat anxiety, insomnia, and nervous tension.',
          'medicalUse': {
            'Anxiety': 'Calms nerves',
            'Insomnia': 'Promotes sleep'
          },
          'partsUsed': 'Leaves',
          'howToUse':
              'Steep 1 teaspoon of dried leaves in 1 cup of hot water for 10 minutes, strain, and drink 1-2 times daily to calm anxiety or 30 minutes before bed for sleep. Avoid overuse without medical advice.',
        },
        'Wild Yam': {
          'image': '../assets/images/wild_yam.jpg',
          'plantInfo':
              'Wild Yam (Dioscorea villosa) is a perennial vine native to North America, known for its twining stems and heart-shaped leaves. The root contains diosgenin, a compound used in the synthesis of steroid hormones, and is used to alleviate menopausal symptoms and support digestive health.',
          'medicalUse': {
            'Menopausal Symptoms': 'Alleviates discomfort',
            'Digestive Health': 'Supports gut function'
          },
          'partsUsed': 'Roots',
          'howToUse':
              'Boil 1 teaspoon of dried root in 2 cups of water for 15 minutes, strain, and drink 1 cup twice daily to ease menopausal symptoms or support digestion. Consult a doctor for prolonged use.',
        },
        'Witch Hazel': {
          'image': '../assets/images/witch_hazel.jpg',
          'plantInfo':
              'Witch Hazel (Hamamelis virginiana) is a deciduous shrub native to North America, known for its astringent properties. The leaves, bark, and twigs contain tannins that help reduce inflammation and are used to treat skin conditions, hemorrhoids, and varicose veins.',
          'medicalUse': {
            'Skin Conditions': 'Reduces inflammation',
            'Hemorrhoids': 'Alleviates discomfort'
          },
          'partsUsed': 'Leaves, Bark, and Twigs',
          'howToUse':
              'Boil 1 tablespoon of dried leaves or bark in 2 cups of water for 15 minutes, strain, cool, and apply with a cotton pad to skin or hemorrhoids 2-3 times daily to reduce inflammation or discomfort.',
        },
        'Yarrow': {
          'image': '../assets/images/yarrow.jpg',
          'plantInfo':
              'Yarrow (Achillea millefolium) is a perennial herb native to Europe, known for its feathery leaves and clusters of small, white or pink flowers. It has astringent and anti-inflammatory properties and is used to treat wounds, stop bleeding, and alleviate cold and flu symptoms.',
          'medicalUse': {
            'Wounds': 'Promotes healing',
            'Colds and Flu': 'Alleviates symptoms'
          },
          'partsUsed': 'Leaves and Flowers',
          'howToUse':
              'Crush 5-7 fresh leaves and flowers, apply to minor wounds to stop bleeding and promote healing, covering with a bandage for 20 minutes. For colds, steep 1 teaspoon of dried flowers in hot water for 10 minutes, strain, and drink twice daily.',
        },
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
            onChanged: (value) =>
                setState(() => searchQuery = value.toLowerCase()),
            decoration: InputDecoration(
              hintText: 'Search plants...',
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: plantsBox.listenable(),
            builder: (context, Box box, _) {
              final filteredPlants = box.keys
                  .where((key) =>
                      key.toString().toLowerCase().contains(searchQuery))
                  .toList()
                ..sort();

              if (filteredPlants.isEmpty) {
                return Center(child: Text('No plants found.'));
              }

              Map<String, List<String>> groupedPlants = {};
              for (var plant in filteredPlants) {
                String initial = plant[0].toUpperCase();
                if (!groupedPlants.containsKey(initial)) {
                  groupedPlants[initial] = [];
                }
                groupedPlants[initial]!.add(plant);
              }

              return ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: groupedPlants.keys.length,
                itemBuilder: (context, index) {
                  String initial = groupedPlants.keys.elementAt(index);
                  List<String> plants = groupedPlants[initial]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          initial,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      ...plants.map((plantName) {
                        final plantData = box.get(plantName) as Map;
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
                                      return Icon(Icons.image_not_supported,
                                          size: 50);
                                    },
                                  )
                                : Icon(Icons.image_not_supported, size: 50),
                            title: Text(plantName),
                            subtitle: Text('Click to view details'),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.bookmark,
                                color: bookmarksBox.containsKey(plantName)
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (bookmarksBox.containsKey(plantName)) {
                                    bookmarksBox.delete(plantName);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            '$plantName removed from bookmarks'),
                                        duration: Duration(milliseconds: 330),
                                      ),
                                    );
                                  } else {
                                    bookmarksBox.put(plantName, plantData);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            '$plantName added to bookmarks'),
                                        duration: Duration(milliseconds: 330),
                                      ),
                                    );
                                  }
                                });
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
}
