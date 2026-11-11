# Netflix Clone

A Netflix-inspired iOS app built with **SwiftUI**.

## Requirements

- Xcode 15+
- iOS 17+
- Swift 5.9+

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/sembunly/netflix_mobile.git 
   ```
2. Open `netflix.xcodeproj` in Xcode.
3. Select a simulator or device and hit **Run** (⌘R).

## Movie catalog API

The home screen loads popular, top rated, now playing, and upcoming titles from [TMDB](https://www.themoviedb.org/). Movie trailers play in the detail screen using YouTube's embedded player.

To configure TMDB without committing your key, create `Secrets.xcconfig` beside `Config.xcconfig` in the project root and add:

```xcconfig
TMDB_API_KEY = your_tmdb_v3_api_key
```

`Secrets.xcconfig` is ignored by Git. The key is inserted into the app's Info.plist at build time, so a client app's key can still be extracted from its binary; use a server proxy for keys that must remain confidential. Without a configured key, the app shows a setup message.

## Project structure

```text
netflix/
├── App/                 # App entry screen and navigation
├── Core/                # Network/configuration and existing onboarding components
├── Models/              # Movie and trailer response models
├── Services/            # TMDB movie and trailer services
├── Features/
│   ├── Home/            # Movie catalog and view model
│   └── MovieDetail/     # Movie details and trailer link
└── Components/          # Reusable movie card
```
