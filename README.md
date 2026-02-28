# QuickSeat - Table Reservation System

QuickSeat is a real-world Table Reservation System demo application built with Flutter, adhering to Clean Architecture principles, Riverpod for state management, Freezed for immutable states, and Dio with Retrofit/OpenAPI mappings for network requests.

## Table of Contents
- [Features](#features)
- [Architecture](#architecture)
- [How to run the app](#how-to-run-the-app)
- [Key Features Logic](#key-features-logic)
- [Challenges & Workarounds](#challenges--workarounds)

## Features
- **Book a Table**: Select Date, Time, Party Size, and provide Customer Name & Phone number. Validates for past dates and overlapping tables.
- **Reservation Management**: View all confirmed reservations in a list, sorted chronologically. Cancel existing reservations seamlessly, freeing up availability instantly.
- **Manager Dashboard**: Displays key restaurant metrics (Total Reservations, Table Availability, Total Guests) alongside a bar chart illustrating reservations distributed across the current week.

## Architecture
The application strictly follows Clean Architecture divided into layers, connected through Riverpod.
1. `core/`: Constants, routers (`auto_route`), app theme, utils, and `dio_provider`.
2. `features/reservation/domain/`: Enterprise rules, abstract repository, `ReservationModel` (Freezed), and `UseCases` (Create, CheckAvailability, Cancel, Get).
3. `features/reservation/data/`: `ReservationRepositoryImpl` leveraging `dart-dio` API client. The `api` package is generated via `openapi-generator-cli` from a `swagger.yaml` schema that mimics a structural remote database API layout.
4. `features/reservation/presentation/`: Screens and Riverpod AsyncNotifiers bridging the UI and the domain layers.
5. `features/dashboard/`: Contains the analytical UI integrating `fl_chart`.

## How to run the app
1. Clone the repository and navigate to the project directory:
   ```bash
   cd table_reservation_app
   ```
2. Retrieve the required dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application on your desired simulator/device:
   ```bash
   flutter run
   ```

## Key Features Logic
- **State Management**: `Riverpod AsyncNotifier` is heavily utilized. Actions like fetching, creating, or canceling interact with our `getReservationsUseCaseProvider` and then `AsyncValue.guard()` catches errors seamlessly to update loading/error UI states appropriately.
- **Availability Logic**: Time slots are validated within a 2-hour window tolerance limit (`diff < 120` minutes) against any currently *confirmed* tables. Past dates are fundamentally rejected before attempting network interactions.
- **Routing**: Handled efficiently with `auto_route` to support deeply integrated native navigation handling and deep-linking capacities gracefully.

## Challenges & Workarounds
- **Riverpod and Retrofit Versioning Conflicts**: Combining powerful newest code-generators like `riverpod_generator` alongside `openapi-generator-cli` occasionally causes `dependency` constraint conflicts. *Workaround:* Configured `pubspec.yaml` with explicit dependency overrides and utilized older strict constraints until `openapi-generator-dart/dio` packages bump their versions natively.
- **Dependency Map Structure**: Replicating a REST framework using simulated endpoints without spinning up a live custom Express.js server required creativity. *Workaround:* Using `swagger.yaml` paired with openapi-generator created an abstract Dio layer inside `/api` mimicking a robust structured backend successfully!

Enjoy using QuickSeat!
