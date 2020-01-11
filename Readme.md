# Meteo

## How to use

Open xcodeproj project, choose French or English language. Run project.

## Localizable

The project is localizable in english and french languages.

## Architecture

To build the application, I chose to use MVVM architecture with additional patterns.

  - Coordinator: To manage navigation between views
  - Robot: To reuse functions for UI Tests

## Dark Mode

Application managed Dark Mode for iOS13+. It uses SF Symbols icons available since iOS13.

## UI Tests

UI Tests was added to test navigation and check loading resources. The tests presents not covered all views but give a good start.

## Tests

Application not integrated tests but the code was written to be easily testable. We can test service that fetch weather items and view models.

## Universal

Application works in iPhone and iPad. Compatible iOS10+.

## Cache

Application use cache to store data fetch from server et reuse after relaunching application. For test, it will just check if we have an item with a date equal to today. If yes, it will returns cache.
This is not the best way to cache data from server but for convenience and goal of the exercise, I prefer to use Preferences.
