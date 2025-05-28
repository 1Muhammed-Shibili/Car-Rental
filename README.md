# 🚗 Car Rental

A Flutter-based vehicle booking application that allows users to select a vehicle model, view details, choose a date range, and make a booking. It uses local SQLite storage to persist booking data and integrates with an external API for vehicle information.

---


https://github.com/user-attachments/assets/f715d043-d681-4419-b715-e794051dab98



## 📁 Project Structure
```yaml
lib/
├── config/ # App-wide configuration (themes, constants, etc.)
├── features/
│ └── booking/
│ ├── controllers/ # Riverpod controllers and logic
│ ├── screens/ # UI screens
│ └── widgets/ # Reusable booking widgets
├── model/ # Data models (VehicleModel, LocalBookingModel, etc.)
├── service/ # API services
├── sqlte/ # SQLite helpers and database models
└── main.dart # App entry point

```
---

## 🧰 Dependencies

Below are the main packages used in this project:


cupertino_icons: ^1.0.8
flutter_launcher_icons: ^0.14.3

# State management 
flutter_riverpod: ^2.6.1

# API requests
http: ^1.4.0

# Date formatting
intl: ^0.20.2

# Local Database
sqflite: ^2.4.2
path_provider: ^2.1.5
path: ^1.9.1


🚀 Getting Started
Follow these steps to set up and run the project locally:

1. 🔧 Install Flutter
Ensure you have Flutter installed. If not, follow the Flutter installation guide.

2. 📥 Clone the Repository
git clone <your-repo-url>
cd <your-project-folder>

3. 📦 Install Dependencies
flutter pub get

4. ▶️ Run the App
flutter run


💡 Features
Add user name inputs

View available vehicle types and models

Fetch detailed vehicle info including images from API

Select booking date range

Store booking locally in SQLite

State management using Riverpod


🛠️ Development Notes
The project uses StateNotifier from Riverpod to manage and update booking state.

The booking data is stored in local SQLite using sqflite.

Network calls are handled using the http package.

All screens are modularized and grouped under features/booking/.



📬 Feedback & Contributions
Pull requests and issue reports are welcome! Let us know how we can improve the app or contribute with new features.
