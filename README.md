# Task Management App 📋

A **Task Management App** built using **Flutter** and **Firebase**, following **Domain-Driven Design (DDD)** for better scalability and maintainability.

---

## 🚀 Features

- ✅ **Task Creation** – Add tasks with descriptions and timestamps.
- ✅ **Offline Support** – Stores tasks locally using **Hive**.
- ✅ **Firebase Sync** – Automatically syncs tasks to Firestore when online.
- ✅ **Duplicate Handling** – Prevents duplicate task entries.
- ✅ **Swipe Actions** – Swipe left to delete, swipe right to update.
- ✅ **Sync Indicator** – The sync button shakes when data needs to be updated.

---

## 🛠 Tech Stack

| Technology             | Purpose                              |
| ---------------------- | ------------------------------------ |
| **Flutter**            | Cross-platform UI development        |
| **Hive**               | Local storage for offline support    |
| **Firebase Firestore** | Cloud database for real-time syncing |
| **Firebase Core**      | Firebase initialization              |
| **Provider**           | State management                     |

---

## 📂 Folder Structure

This project follows **Domain-Driven Design (DDD)** to maintain **scalability** and **separation of concerns**.

```
lib/
│── configs/          # Configuration files
│── core/             # Core utilities, base classes
│── domain/           # Entities, models, and use cases
│── gen/              # Auto-generated files
│── infrastructure/   # Data sources, repositories, Firebase interactions
│── injection/        # Dependency injection setup
│── presentation/     # UI and widgets
│── providers/        # State management (Provider)
│── routing/          # App navigation and routing
│── utils/            # Utility functions and helpers
│── firebase_options.dart # Firebase setup
│── main.dart         # Main application entry point
```
