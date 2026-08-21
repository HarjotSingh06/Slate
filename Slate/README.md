# Slate — White-Label E-Commerce iOS App

Slate is a modern, white-label e-commerce mobile application built with **SwiftUI** and **SwiftData**. Designed for multi-tenant deployment, the app features dynamic real-time client reskinning, reactive state management, and persistent local data storage.

---

## 🌟 Key Features

* **Dynamic White-Label Architecture:** Real-time client theme switcher powered by an `@EnvironmentObject` state manager (`ConfigManager`), allowing instant accent color and brand swaps across all screens without restarting the app.
* **Reactive Shopping Basket:** Automated basket item tracking with dynamic tab badge counts utilizing SwiftData `@Query` macros.
* **Persistent SwiftData Storage:** Smooth local database management for product selection, saved user profiles, and order history tracking.
* **Secure Data Purging:** Context-aware sign-out flow that completely clears local user state, basket items, and purchase records upon logout.

---

## 🛠 Tech Stack & Architecture

* **Framework:** SwiftUI
* **Database:** SwiftData
* **Reactive Framework:** Combine (`ObservableObject`, `@Published`)
* **Design Pattern:** MVVM-inspired white-label theme injection

---

## 🎥 Demo Highlights

1. **Shop & Basket:** Seamlessly browse products and add items with live-updating tab bar badge counters.
2. **Checkout & Persistence:** Complete purchases with persistent order generation saved directly to SwiftData.
3. **Live Theme Switching:** Open the **Profile** tab to toggle between *Slate (Pink)*, *Luxe Ocean (Blue)*, and *Emerald Supply (Green)* to view instant app-wide reskinning.

---

## 🔒 License & Access

*This repository is privately maintained for portfolio demonstration and technical showcase purposes.*
