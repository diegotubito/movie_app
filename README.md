---

# MovieApp

## Overview

MovieApp is a SwiftUI-based application designed to display and cache movie information using a clean architecture approach. The app separates concerns by organizing the code into different layers including **ViewModels**, **Use Cases**, **Repositories**, and **Entities**. This modular structure enhances testability, scalability, and maintainability.

## Features

- **SwiftUI for UI Layer**: All views are built using SwiftUI and are backed by `ViewModels`.
- **Clean Architecture**: The app uses a clean architecture, with a separation of concerns between the UI, domain logic, and data handling.
- **Data Persistence**: Movie data is cached locally using Core Data for offline access.
- **Network Layer**: We fetch movie information from a third-party API and handle data caching to improve performance and offline experience.
- **Testing Support**: ViewModels are designed to be testable by injecting mock repositories in place of the real ones during unit tests.

## Architecture

1. **ViewModel**: The ViewModel layer handles UI logic and communicates with the use cases. Each view has its corresponding ViewModel, initialized with the required use case.
   
2. **Use Cases**: Encapsulates the business logic. Use cases are responsible for interacting with repositories to fetch data.
   
3. **Repositories**: Two repositories are implemented:
   - **Core Data Repository**: Handles caching and retrieval of data from local storage.
   - **API Repository**: Handles network requests and data fetching from the movie API.
   
4. **Entities**: Data models that represent the movie information fetched from the API or retrieved from the local storage.

## API Key
To interact with the API services, an API key is required. It is included in the code for this test project:
```
eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZmFhMjNmNDBhNzhjOTgzNTRiMTQ4NDEwNzgyOWFlMCIsIm5iZiI6MTcyNTQxNDg3MC43NDE5NDMsInN1YiI6IjY2ZDdiYzY1MzYwODBmNzk0ZDBlZDI5MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WBnYcLJUOlvi7CoqYhyItbtkBafgJkL2-wQ9rSYfHzc
```

## Requirements

- Xcode 12+
- Swift 5.3+
- iOS 14+

## Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/diegotubito/movieApp.git
   ```
2. Open the project in Xcode and build the app.
3. Ensure your API key is set in the network configuration.

## Future Work

- Add offline video downloading and playback support.
- Improve error handling and network connectivity management.

---
