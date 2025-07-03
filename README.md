# plata

native_geofence를 이용해 목적지에 다다르면 알람, ToDo 알림 등 기능을 수행하는 어플리케이션입니다.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# Overview

**Taskmaster-AI** is a cross-platform, location-based alarm clock application that empowers users to automate context-aware tasks based on their physical location. The primary problem it solves is the rigid nature of time-based alarms that lack spatial awareness. This app is ideal for users with daily routines tied to places (e.g., arriving at work, leaving a campus, passing by a grocery store), enabling them to receive timely alerts, reminders, or actions when they physically enter or exit specific areas.

This is particularly valuable for:

* Commuters needing reminders upon arriving at certain locations
* Students or professionals with routine location-based tasks
* Productivity-focused users seeking a lightweight IFTTT-style location automation

# Core Features

### Geofence-Based System Alarm Trigger

* **What it does:** Triggers a system-level alarm when the user enters a defined geographical area.
* **Why it's important:** Replaces rigid time-based alarms with context-sensitive alerts.
* **How it works:** Uses the device's location services to monitor user position and checks entry/exit against a list of geofences.

### Draggable Map Marker for Geofence Selection

* **What it does:** Allows users to visually define a geofence on a map by dragging a marker.
* **Why it's important:** Simplifies geofence creation without needing raw coordinate input.
* **How it works:** Integrates `flutter_map` to set latitude, longitude, and radius via touch input.

### Persistent Storage of Geofence Zones

* **What it does:** Saves geofence configurations across sessions.
* **Why it's important:** Users can define alarms once and reuse them.
* **How it works:** Uses `sqflite` for structured geofence records and `shared_preferences` for boot-time state restoration.

### Modular Alarm Action Engine

* **What it does:** Provides an abstraction layer for triggering different actions (e.g., alarm, email, notification).
* **Why it's important:** Ensures future extensibility without reworking core logic.
* **How it works:** Implements a strategy pattern where actions can be dynamically selected and executed.

### Natural Language Address Input (Planned)

* **What it does:** Allows users to define a location using natural language instead of coordinates.
* **Why it's important:** Improves usability and accessibility.
* **How it works:** Integrates Google Maps API for geocoding and place search.

### Internationalization

* **What it does:** Supports multiple languages and timezones.
* **Why it's important:** Ensures usability for global users.
* **How it works:** Utilizes Flutter's built-in i18n tools and localized strings.

# User Experience

### User Personas

* **Commuter Carl:** Needs reminders to check in at work and to pick up items when near a store.
* **Student Sophie:** Wants to be reminded to submit assignments when arriving at school.
* **Nomadic Nate:** Digital nomad who needs reminders when arriving at different co-working spaces.

### Key User Flows

1. **Create Alarm**

   * User selects location via draggable marker or natural language input.
   * Sets radius and label for geofence.
   * Chooses action (alarm, email, etc.).
2. **Trigger Event**

   * App monitors user location.
   * When user enters/exits geofence, associated action is executed.
3. **Manage Alarms**

   * Users can view, edit, or delete geofence alarms.

### UI/UX Considerations

* Geofence creation should be intuitive with visual feedback.
* Alarm actions must provide confirmation to the user.
* Accessibility features like voice-over, high-contrast modes, and internationalization are planned.

# Technical Architecture

### System Components

* **Flutter Frontend:** UI and geofence interaction
* **Location Service Layer:** Handles background location tracking
* **Geofence Monitor:** Evaluates entry/exit status and triggers actions
* **Action Dispatcher:** Routes the correct action type
* **Persistence Layer:** Manages alarm state across sessions (sqflite, shared_preferences)
* **Natural Language Location Engine (planned):** Google Maps Geocoding + Places API

### Data Models

* `GeofenceZone`: { id, label, lat, lng, radius, actionType }
* `UserPreferences`: { locale, timezone, notificationSettings }

### APIs and Integrations

* `native_geofence` / `geofencing` plugins
* `google_maps_flutter` / `flutter_map`
* Google Places API & Geocoding (planned)

### Infrastructure Requirements

* Minimal backend needed initially (local-only)
* Future: optional serverless function for outbound emails or multi-device sync

# Development Roadmap

### Phase 1: MVP

* Set geofence via draggable map
* Trigger system alarm on entry
* Store alarms locally
* Basic list/edit/delete UI

### Phase 2: Usability Enhancements

* Add natural language location search
* UX polish (custom icons, animation, confirm dialogs)
* Support for silent mode or vibration alerts

### Phase 3: Modular Action Engine

* Add email action using `mailer`
* Push notification option
* Rule-based conditions (e.g., time + location)

### Phase 4: Platform Readiness

* iOS privacy compliance (location usage strings, permission prompts)
* Battery and thermal optimization
* Language support and timezone detection

# Logical Dependency Chain

1. **Foundational Core**

   * Location permissions & background tracking
   * Geofence event detection engine
   * Alarm triggering mechanism

2. **Basic Usable UI**

   * Map UI for creating alarms
   * Local storage layer (sqflite/shared\_prefs)
   * System alarm hook-up

3. **Extensible Action Layer**

   * Abstract action dispatcher
   * Plug-in system for future actions

4. **Experience & Input Layer**

   * Address search & autocomplete
   * i18n integration
   * Cross-platform polishing (Android/iOS parity)

# Risks and Mitigations

### Technical Challenges

* **Battery Drain:** Use native platform geofence APIs, optimize polling frequency
* **Background Execution on iOS:** Comply with Apple's background mode policies and power-saving restrictions
* **Location Permission Denials:** Provide clear rationale prompts, offer fallback behaviors

### MVP Definition

* Ensure MVP is tightly scoped to location entry → alarm trigger
* Defer email, notification, rule logic until Phase 3

### Resource Constraints

* Design architecture for solo/small team development
* Ensure all components are independently testable and modular

# Appendix

### Research Findings

* Apple's app review strongly discourages background location use unless strictly necessary. Privacy explanation must be clear.
* Google’s geofencing APIs are more tolerant and robust but may not be available on all Chinese OEMs.
* `flutter_map` is more customizable than Google Maps widget and can be used offline.

### Technical Specs

* Alarm system: Uses `flutter_local_notifications`
* Persistent storage: `sqflite` with fallback to `shared_preferences`
* Recommended plugin for background tasks: `flutter_background_geolocation` (paid) or `background_fetch`
* Geofence radius limitation (iOS): ~100 meters minimum for accuracy