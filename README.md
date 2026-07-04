# ⭐️ MoodJournal


A digital diary, mood tracker, and mental health companion designed to help you align your mind, record your stories, and understand your emotional trends.


**MoodJournal** is a beautifully designed, immersive journaling app. By tracking daily ratings and stories, the app utilizes positive psychology and Cognitive Behavioral Therapy (CBT) principles to foster patient, peaceful thinking and boost emotional well-being.


<p align="center">
  <img src="https://images.unsplash.com/photo-1506784983877-45594efa4cbe?auto=format&fit=crop&w=1200&q=80" alt="MoodJournal Banner" width="100%" style="border-radius: 8px;" />
</p>


<p align="center">
  <img src="assets/images/intro_image.png" alt="MoodJournal Welcome Intro Screen" width="320" style="border-radius: 12px; box-shadow: 0 4px 16px rgba(0,0,0,0.15);" />
</p>


---


## 🚀 Technical Stack & Architecture


This project is built using professional, scalable, and robust development technologies.


### 🛠️ Core Technology Stack

* **Framework:** Flutter SDK (`>= 3.10.1`) & Dart (`>= 3.0.0`)
* **State Management:** BLoC / Cubit State Architecture (`flutter_bloc` package for stream-based transactional UI updates)
* **Local Persistence:** Isar DB (Modern, ultra-fast NoSQL database optimized for Flutter) and compiled Isar Schemas.
* **Environment Configurations:** Dynamic `.env.prod.json` parsing for custom product flavors and Firebase api credentials.
* **Vector Graphics:** Custom Paint API in Flutter for rendering mathematically-curved mood lines, grid backgrounds, and statistics overlays without external graphic assets.


### 🏗️ Architecture & Folder Structure

The application separates concerns cleanly. The premium Mood Analytics feature follows a strict **Clean Architecture** layering, allowing complete isolation of business rules from UI states:

```
lib/
├── features/
│   └── mood_analytics/           # Clean Architecture Mood Analytics Module
│       ├── domain/
│       │   ├── models/           # Pure, immutable MoodRecord and AnalyticsData structures
│       │   └── repositories/     # Interface repository contracts defining local query aggregates
│       ├── data/
│       │   ├── datasources/      # Isar database local query pipelines and statistics generators
│       │   └── repositories/     # Decoupled repository implementations bridging queries and models
│       └── presentation/
│           ├── controllers/      # BLoC state provider emitting analytics states
│           ├── pages/            # Beautiful analytical dashboard view
│           └── widgets/          # Custom-painted vector charts and mood telemetry cards
├── controllers/                  # Legacy State Controllers
├── models/                       # Core Diary and User entities
├── pages/                        # Legacy Journal Home and Write Entry screens
└── main.dart                     # Main entrypoint establishing environment flavors and Isar bindings
```


---


## 🛠️ Software Coding & Clean Code Principles


To ensure high quality, maintainability, and clean code standards, we applied rigorous software principles:

* **S.O.L.I.D. Architectural Guidelines:**
  * **Single Responsibility (SRP):** The Isar query builder is strictly limited to querying mood database statistics; it doesn't render layouts or hold state.
  * **Open/Closed (OCP):** New analytical charts (e.g., bar charts or scatter plots) can be added simply by subclassing our abstract CustomPainter canvas without modifying existing screens.
  * **Liskov Substitution (LSP):** Our abstract repository structure supports seamless swapping with Mock databases for pipeline tests.
  * **Interface Segregation (ISP):** Presentation models only interact with tailored analytics queries, avoiding generic, bloated interfaces.
  * **Dependency Inversion (DIP):** Presentation screens rely exclusively on abstract repository contracts, resolving implementations at startup.
* **DRY (Don't Repeat Yourself):** All custom sliders, calendar cell adapters, and colored buttons are modularized into shared components.
* **Separation of Concerns:** Business logic is isolated in Cubit state streams; widgets remain pure, reactive observers.
* **Deterministic Coding:** Strictly enforces immutable variables and explicit type definitions to prevent runtime null pointer exceptions.


---


## ✨ Extensive Features & Subfeatures Guide


### 📝 Immersive Diary & Rich Journaling

* **Story Logging:** 
  Write about your day, record highlights, and express thoughts in a beautifully minimalist rich-text diary editor.
* **Mood Aura Hues:** 
  Assign beautiful colors representing your daily aura (e.g., vibrant green for peaceful/happy, golden yellow for thoughtful, soft red for energetic).
* **🔍 How to Access & Use:**
  1. On the main home screen, tap the central **New Entry** button.
  2. Select your dominant mood by sliding/tapping on the beautifully colored mood spheres (ranging from very sad to extremely happy).
  3. Enter a short, descriptive title for your day.
  4. Write your thoughts, experiences, and highlights in the immersive story text area.
  5. Tap **Save Entry** to securely persist your story in local database storage.


### 📅 Color-Coded Mood Aura Boards

* **Visual Aura Calendars:** 
  Your monthly calendar renders as a stunning, color-coded grid representing your general spirits over time.
* **Interactive Reflection:** 
  Tap on past calendar days to immediately reload and read your historical journaling entries.
* **🔍 How to Access & Use:**
  1. Open the **Calendar** tab from the main navigation interface.
  2. Browse through the monthly grids. Each completed day is color-coded with the mood hue you selected for that day, creating an emotional heat map.
  3. Tap on any colored day in the calendar to bring up a floating drawer detailing your journal entry and dominant feelings for that date.


### 📊 Premium Interactive Mood Analytics Dashboard

* **Custom Vector Charting:** 
  Renders native, high-fidelity vector curves and charts depicting mood trends directly on-device.
* **Dominant Emotional States:** 
  Analytics automatically aggregate and identify your dominant mood, average emotional score, and journaling frequency over weekly, monthly, and yearly horizons.
* **🔍 How to Access & Use:**
  1. Tap on the **Analytics** icon in the navigation panel.
  2. Switch between **Weekly** and **Monthly** filters at the top of the dashboard to view trends over different horizons.
  3. Observe the **Dominant Mood Card** summarizing your most frequent feelings.
  4. Analyze the **Mood Trend Graph** to see how your mood score shifts day-by-day. Use this data to identify patterns or triggers.


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
> We have extensively worked on their original codebase, refactored the underlying logic, updated legacy dependencies, resolved complex build and runtime errors, and introduced many advanced modern enhancements. These upgrades include an interactive Mood Analytics and CBT Diagnostic Dashboard, custom-painted vector mood trend charting systems, streamlined local state storage using Isar DB, and extensive package compatibility upgrades for contemporary Flutter/Dart platforms to create a highly optimized, state-of-the-art, and production-ready portfolio application.


---


## 📄 License & Open-Source


**MoodJournal** is open-source software licensed under the **MIT License**. Refer to the [LICENSE](LICENSE) file for more information. Contributions and Pull Requests are welcome!
