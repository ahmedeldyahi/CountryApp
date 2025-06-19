## 🚀 Implementation Overview

This app displays detailed information about countries using clean architecture principles, SwiftUI, and modern Apple frameworks like SwiftData and Combine.

---

### 🧱 Architecture

The project is structured according to **Clean Architecture**, with clear separation between:

| Layer            | Responsibility                                                                 |
|------------------|----------------------------------------------------------------------------------|
| **Presentation** | SwiftUI Views + ViewModels using `@Published` for state management              |
| **Domain**       | Business logic encapsulated in use cases like `LoadInitialCountriesUseCase`     |
| **Data**         | Service contracts and cache implementations using SwiftData                     |
| **Core**         | Shared utilities like `NetworkManager`, `ErrorManager`, and API contracts       |

---

### 📦 Features

- 🌐 **Country Search**: Search countries by name with real-time results using the [restcountries.com](https://restcountries.com/) API.
- 🌍 **Current Location Detection**: On first load, fetches the country based on user’s geolocation or falls back to a default.
- 💾 **Offline Caching**: Persist selected countries using SwiftData; restores the last state on app restart.
- 📌 **Detail View**: Shows currency, population, area, timezone, and region with a map and toast overlay.
- 🧪 **Unit Tested**: Key layers are fully unit tested including ViewModels, UseCases, and Services.

---

### 🧪 Tested Components

| Component                   | Tests Included                                    |
|----------------------------|---------------------------------------------------|
| `MainViewModel`            | Add, remove, and initial loading logic            |
| `CountrySearchViewModel`   | Search success and empty input                    |
| `CountryDetailViewModel`   | Detail formatting and structure                   |
| `LoadInitialCountriesUseCase` | Cache, location, fallback logic               |
| `LocationManager`          | Permission handling and geocoding                 |

---

### 🗂 File Structure Overview
