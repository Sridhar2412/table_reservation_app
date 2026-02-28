# QuickSeat - Table Reservation System

QuickSeat is a modern, premium Table Reservation System demo application built with Flutter. It follows Clean Architecture principles and utilizes a robust tech stack for performance and scalability.

## 🚀 Features

- **Intuitive Booking**: Quick and easy reservation process with real-time availability checking.
- **Reservation Management**: 
  - Dynamic reservation cards with status-based coloring (Confirmed, Waitlist, Cancelled).
  - Modern action menus for quick editing or cancellation.
  - Interactive "Special Requests" section for personalized guest service.
- **Admin Dashboard**: Real-time analytics showing total reservations, guest counts, and table occupancy with interactive bar charts.
- **Cloud Integration**: Powered by Firebase Auth for secure login and Cloud Firestore for persistent data storage.

## 🛠️ Tech Stack

- **Core**: [Flutter](https://flutter.dev/) & [Dart](https://dart.dev/)
- **Architecture**: Clean Architecture (Data, Domain, Presentation layers)
- **State Management**: [Riverpod](https://riverpod.dev/) (with `riverpod_generator`)
- **Data Layer**: 
  - [Cloud Firestore](https://firebase.google.com/docs/firestore) for the database
  - [Freezed](https://pub.dev/packages/freezed) for immutable data models
  - [Json Serializable](https://pub.dev/packages/json_serializable) for seamless JSON mapping
- **Routing**: [AutoRoute](https://pub.dev/packages/auto_route) for type-safe navigation
- **Charts**: [Syncfusion Flutter Charts](https://pub.dev/packages/syncfusion_flutter_charts)

## 📦 Project Structure

```text
lib/
├── core/               # Shared logic, theme, router, and providers
├── features/
│   ├── auth/           # Authentication logic and login screens
│   ├── dashboard/      # Admin dashboard and analytics
│   └── reservation/    # Core booking and management feature
│       ├── data/       # Repository implementations and Firestore integration
│       ├── domain/     # Business entities and repository interfaces
│       └── presentation/ # UI screens, widgets, and state providers
└── main.dart           # App entry point
```

## 🏁 How to Run the App

1. **Prerequisites**: Ensure you have Flutter and Firebase CLI installed.
2. **Clone the Project**:
   ```bash
   git clone https://github.com/Sridhar2412/table_reservation_app.git
   cd table_reservation_app
   ```
3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run Code Generation**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
5. **Run the App**:
   ```bash
   flutter run
   ```

## 🎨 Modern UI Refinements

The app features a premium design system with:
- **Status-Aware UI**: Icons and accents throughout the app dynamically update to reflect the reservation status.
- **Mobile-Responsive Forms**: Vertically optimized layouts for input fields ensure a smooth booking experience on all devices.
- **Clean Action Menus**: Professional, text-based popup menus replace cluttered icon buttons for a cleaner aesthetic.

---
Enjoy managing your restaurant with **QuickSeat**!
