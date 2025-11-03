# tradingsolutions
# Trading Solutions - Flutter Developer Task

A new Flutter project.
> A feature-rich trading application prototype built with Flutter. This project was developed as a technical assessment for a Flutter Developer role, showcasing skills in complex UI/UX, animations, custom widget development, and state management.

## Getting Started
## 📸 Screenshots & Demos

This project is a starting point for a Flutter application.
A quick demonstration of the app's core functionality, including the animated top-sheet, stock details view, and interactive charts.

A few resources to get you started if this is your first Flutter project:
*(Here you would embed a GIF or video of the app in action)*

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
`!App Demo GIF`

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# tradingsolutions
| Home Screen | Stock Details | Interactive Chart |
| :---: | :---: | :---: |
| `!Home Screen` | `!Stock Details` | `!Chart Screen` |


## ✨ Features

This application simulates a real-world trading platform with a focus on a clean, responsive, and intuitive user experience.

### Core UI & Navigation
-   **Animated Splash Screen**: An engaging entry point with a subtle scaling logo animation.
-   **Dashboard (Home Screen)**:
    -   **Market Overview AppBar**: A custom `AppBar` displaying scrollable real-time market indices (e.g., NIFTY 50, NIFTY BANK).
    -   **Animated Top Sheet**: A slide-down panel providing a quick overview of market trends and funds. It blurs the background content when active for better focus.
    -   **Bottom Navigation**: Intuitive `BottomNavigationBar` for easy access to Watchlist, Orders, Portfolio, Bids, and Profile.
-   **Search & Discovery**:
    -   A dedicated search screen with a focused text field for finding stocks.
    -   A `CustomTabbedView` to filter search results by categories like Stocks, IPOs, Mutual Funds, etc.

### Stock & Trading Features
-   **Draggable Stock Details Sheet**: An interactive and scrollable bottom sheet (`DraggableScrollableSheet`) that provides comprehensive information about a selected stock. It can be expanded from a partial view to a full-screen view.
-   **Interactive Trading Charts**: A full-fledged chart screen built with `syncfusion_flutter_charts` supporting:
    -   Multiple chart types (Line, Candlestick, Area).
    -   Various time frames (1D, 1W, 1M, etc.).
    -   Technical indicators like EMA, SMA, and Bollinger Bands.
    -   Zooming, panning, and trackball for detailed analysis.
-   **Order Placement**:
    -   Dedicated screens for placing BUY and SELL orders.
    -   **Swipe-to-Confirm Button**: A custom, gesture-based confirmation widget to prevent accidental orders.

### Custom Widgets & Components
The project is built with a strong emphasis on creating reusable and modular widgets.
-   `MarketAppBar`: A custom app bar implementation.
-   `CustomTabbedView`: A stateful widget for creating horizontally scrollable tabs with an animated indicator.
-   `SwipeToConfirmButton`: A self-contained, animated swipe button for critical actions.
-   `StockDetailsSheet`: A complex, reusable bottom sheet that aggregates multiple data points and actions for a stock.
-   Various custom cards for displaying data consistently: `CompanyCard`, `InvestmentCard`, `HoldingCard`, `OrderItemCard`.

## 🛠️ Tech Stack & Architecture

-   **Framework**: Flutter
-   **Language**: Dart
-   **State Management**: `StatefulWidget` with `setState()`. Chosen for its simplicity and suitability for a focused technical assessment. The architecture is designed to be scalable for more advanced state management solutions like BLoC or Riverpod.
-   **Key Packages**:
    -   `syncfusion_flutter_charts`: For powerful and interactive financial charts.
-   **Architecture**:
    -   **Widget-based Composition**: The UI is broken down into small, single-responsibility widgets, promoting reusability and maintainability.
    -   **Separation of Concerns**: The project is structured by features (`screens`) and shared components (`widgets`), making the codebase easy to navigate.
    -   **Data-Driven UI**: Widgets are designed to be driven by the data passed to them, making them predictable and easy to test.

## 🚀 Getting Started

To run this project locally, follow these steps:

1.  **Prerequisites**:
    -   Ensure you have the Flutter SDK installed.
    -   An IDE like VS Code or Android Studio with the Flutter plugin.

2.  **Clone the repository**:
    ```sh
    git clone https://github.com/your-username/tradingsolutions.git
    cd tradingsolutions
    ```

3.  **Install dependencies**:
    ```sh
    flutter pub get
    ```

4.  **Run the app**:
    ```sh
    flutter run
    ```

## 💡 Potential Future Improvements

-   **Integrate a State Management Solution**: Refactor to use a more robust state management library like `flutter_bloc` or `riverpod` to handle complex app state and data flow.
-   **API Integration**: Replace mock data with live data from a financial market API.
-   **Add User Authentication**: Implement a login/signup flow.
-   **Unit & Widget Testing**: Write tests to ensure the reliability and correctness of business logic and UI components.
-   **Theming**: Implement a robust theming system with support for both light and dark modes.
