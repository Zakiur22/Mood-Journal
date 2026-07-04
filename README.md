# ⭐️ MoodJournal

A digital diary, mood tracker, and mental health companion designed to help you align your mind, record your stories, and understand your emotional trends.

<p align="center">
  <b>MoodJournal</b> is a beautifully designed, immersive journaling app. By tracking daily ratings and stories, the app utilizes positive psychology and Cognitive Behavioral Therapy (CBT) principles to foster patient, peaceful thinking and boost emotional well-being.
</p>

---

## ✨ Features at a Glance

### 📝 Immersive Diary & Journaling
* **Story Logging:** Write about your day, record highlights, and express thoughts in a beautifully minimalist rich-text diary editor.
* **Mood Hues:** Assign colors representing your daily aura (e.g., vibrant green for peaceful/happy, golden yellow for thoughtful, soft red for energetic).

### 📅 Color-Coded Mood Boards
* **Visual Aura Calendars:** Your monthly calendar renders as a stunning, color-coded grid representing your general spirits over time.
* **Streak Tracking:** Keep the positive momentum going with streak tracking and milestones.

### 📊 Premium Feature: Interactive Mood Analytics Dashboard [Phase 4 Update]
MoodJournal features an advanced mood analytics engine to visualize your long-term mental wellness metrics over monthly and weekly horizons:

> [!TIP]
> **Data Insights:** Track your dominant emotional states, average mood ratings, and entries distributions using custom high-fidelity vector charts painted natively in Flutter.

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

## 🎨 Theme & Personalization
* **AMOLED Dark Mode:** Beautiful high-contrast themes optimized for nighttime journaling.
* **Custom Mood Mapping:** Tailor mood descriptions, colors, and notes to fit your exact mental vocabulary.

---

## 🛠️ Installation & Run Instructions

### 1. Requirements
* **Flutter SDK:** `>= 3.10.1`

### 2. Setup Configuration
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

### 3. Run Commands
1. Retrieve dependencies:
   ```bash
   flutter pub get
   ```
2. Build code generators (if required):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
3. Run code analysis:
   ```bash
   flutter analyze
   ```
4. Compile production release:
   ```bash
   flutter build apk --release --dart-define-from-file=.env.prod.json
   ```

---

## 📄 License & Contributing
Distributed under the **MIT License**. Refer to the [LICENSE](LICENSE) file for more information.
We welcome community pull requests and issue submissions!
