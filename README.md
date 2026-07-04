# ⭐️ MoodJournal


A digital diary, mood tracker, and mental health companion designed to help you align your mind, record your stories, and understand your emotional trends.


**MoodJournal** is a beautifully designed, immersive journaling app. By tracking daily ratings and stories, the app utilizes positive psychology and Cognitive Behavioral Therapy (CBT) principles to foster patient, peaceful thinking and boost emotional well-being.


---


## 🎨 Premium Visual Theme & Mood Aesthetics


MoodJournal offers a state-of-the-art interactive mood-capturing experience inspired by modern minimalist design principles:

* **Vibrant Mood Palettes:** Beautiful color gradients and curated high-contrast hues that translate intangible feelings into tangible visual colors.
* **Calm & Peaceful Typography:** Hand-picked typography that creates a peaceful digital sanctuary, allowing you to reflect and write without distractions.
* **Micro-Animations:** Gentle tactile vibrations and fluid transitions when selecting moods or flipping calendar months.


---


## ✨ Key Features & User Guide


### 📝 Immersive Diary & Rich Journaling

* **Story Logging:** Write about your day, record highlights, and express thoughts in a beautifully minimalist rich-text diary editor.
* **Mood Aura Hues:** Assign beautiful colors representing your daily aura (e.g., vibrant green for peaceful/happy, golden yellow for thoughtful, soft red for energetic).
* **🔍 How to Access & Use:**
  1. On the main home screen, tap the central **New Entry** button.
  2. Select your dominant mood by sliding/tapping on the beautifully colored mood spheres (ranging from very sad to extremely happy).
  3. Enter a short, descriptive title for your day.
  4. Write your thoughts, experiences, and highlights in the immersive story text area.
  5. Tap **Save Entry** to securely persist your story in local database storage.


### 📅 Color-Coded Mood Aura Boards

* **Visual Aura Calendars:** Your monthly calendar renders as a stunning, color-coded grid representing your general spirits over time.
* **Interactive Reflection:** Tap on past calendar days to immediately reload and read your historical journaling entries.
* **🔍 How to Access & Use:**
  1. Open the **Calendar** tab from the main navigation interface.
  2. Browse through the monthly grids. Each completed day is color-coded with the mood hue you selected for that day, creating an emotional heat map.
  3. Tap on any colored day in the calendar to bring up a floating drawer detailing your journal entry and dominant feelings for that date.


### 📊 Premium Interactive Mood Analytics Dashboard

* **Custom Vector Charting:** Renders native, high-fidelity vector curves and charts depicting mood trends directly on-device.
* **Dominant Emotional States:** Analytics automatically aggregate and identify your dominant mood, average emotional score, and journaling frequency over weekly, monthly, and yearly horizons.
* **🔍 How to Access & Use:**
  1. Tap on the **Analytics** icon in the navigation panel.
  2. Switch between **Weekly** and **Monthly** filters at the top of the dashboard to view trends over different horizons.
  3. Observe the **Dominant Mood Card** summarizing your most frequent feelings.
  4. Analyze the **Mood Trend Graph** to see how your mood score shifts day-by-day. Use this data to identify patterns or triggers.


---


## 🏗️ Clean Architecture Overview


The mood analytics dashboard and charting engine are written cleanly under `lib/features/mood_analytics/`, separating business workflows from the views:

```
lib/features/mood_analytics/
├── domain/
│   ├── models/           # Immutable MoodRecord and AnalyticsData structures
│   └── repositories/     # Interface repository contracts defining local query aggregates
├── data/
│   ├── datasources/      # Isar database local query pipelines and statistics generators
│   └── repositories/     # Decoupled repository implementations bridging queries and models
└── presentation/
    ├── controllers/      # BLoC state provider emitting analytics states
    ├── pages/            # Beautiful analytical dashboard view
    └── widgets/          # Custom-painted vector charts and mood telemetry cards
```


---


## 🛠️ Developer Setup & Guidelines


### Requirements
* **Flutter SDK:** `>= 3.10.1`
* **Dart SDK:** `>= 3.0.0`


### Setup Configuration

Generate your local production settings by creating `.env.prod.json` in the root:
```json
{
  "flavor": "prod",
  "apiKey": "YOUR_FIREBASE_API_KEY",
  "appIdAndroid": "YOUR_ANDROID_APP_ID",
  "appIdIos": "YOUR_IOS_APP_ID",
  "messagingSenderId": "YOUR_MESSAGING_SENDER_ID",
  "projectId": "YOUR_PROJECT_ID",
  "storageBucket": "YOUR_STORAGE_BUCKET",
  "iosBundleId": "YOUR_IOS_BUNDLE_ID"
}
```


### Step-by-Step Installation

1. Navigate to the project directory:
   ```bash
   cd MoodJournal
   ```

2. Retrieve dependencies:
   ```bash
   flutter pub get
   ```

3. Build code generators (e.g., Isar and JSON schemas):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Run code analysis:
   ```bash
   flutter analyze
   ```

5. Compile production release:
   ```bash
   flutter build apk --release --dart-define-from-file=.env.prod.json
   ```


---


## 🙏 Acknowledgements & Attribution


We would like to express our sincere gratitude to the original creators and maintainers of the original [hashirshoaeb/star_book](https://github.com/hashirshoaeb/star_book) repository, which served as the foundation of this work.


> [!NOTE]
> This repository represents an **extensive, premium upgrade** from the original codebase. It introduces a modernized mood analytics and CBT diagnostic suite, custom-painted vector mood trend dashboards following Clean Architecture principles, streamlined local state storage using Isar DB, and full package/dependency compatibility updates for the latest Flutter and Dart SDK frameworks.


---


## 📄 License & Open-Source


**MoodJournal** is open-source software licensed under the **MIT License**. Refer to the [LICENSE](LICENSE) file for more information. Contributions and Pull Requests are welcome!
