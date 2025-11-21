# Weather Dashboard 224169D

A complete Flutter weather application that fetches real-time weather data from the Open-Meteo API based on student index coordinates.

## Features

✅ **Dynamic Coordinate Calculation** - Automatically computes latitude and longitude from student index (224169D)
✅ **Real-time Weather Data** - Fetches current weather including temperature, wind speed, and weather code
✅ **Online/Offline Mode Indicator** - Real-time network status display in app bar (ONLINE/OFFLINE badge)
✅ **Offline Mode with Caching** - Uses SharedPreferences to cache weather data for offline access
✅ **Automatic Connectivity Detection** - Monitors network changes and updates status automatically
✅ **Error Handling** - Comprehensive error handling for network issues and invalid inputs
✅ **Clean Material UI** - Modern, polished interface with weather icons and cards
✅ **Loading States** - Visual feedback during API calls

## Student Index

**224169D**

### Coordinate Calculation Formula

```dart
firstTwo = int(index.substring(0, 2))  // 22
nextTwo  = int(index.substring(2, 4))  // 41

lat = 5 + (firstTwo / 10.0)   // 5 + 2.2 = 7.2
lon = 79 + (nextTwo / 10.0)   // 79 + 4.1 = 83.1
```

**Result:**
- Latitude: 7.20
- Longitude: 83.10

## API Endpoint

```
https://api.open-meteo.com/v1/forecast?latitude=7.20&longitude=83.10&current_weather=true
```

## Project Structure

```
lib/
├── main.dart                      # App entry point
├── models/
│   └── weather_model.dart        # Weather data model with JSON parsing
├── screens/
│   └── home_screen.dart          # Main UI screen
├── services/
│   └── weather_service.dart      # API calls, caching, coordinate computation
└── widgets/
    └── weather_card.dart         # Weather display card widget
```

## Dependencies

- `http: ^1.1.0` - HTTP requests to Open-Meteo API
- `shared_preferences: ^2.2.2` - Local caching for offline mode
- `connectivity_plus: ^6.0.5` - Network connectivity monitoring

## How It Works

1. **Index Input**: Enter student index (pre-filled with 224169D)
2. **Coordinate Computation**: App automatically calculates lat/lon from index
3. **API URL Display**: Shows the exact API URL being called
4. **Fetch Weather**: Button triggers API call with loading spinner
5. **Display Results**: Weather data shown in polished card with icons
6. **Offline Mode**: If network fails, app shows cached data with "(cached)" badge
7. **Error Handling**: User-friendly messages for all error scenarios

## Running the App

### Prerequisites
- Flutter SDK installed
- Android emulator or physical device connected

### Steps

1. Navigate to project directory:
```bash
cd weatherapp
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Features Demonstrated

### ✅ Input Validation
- Validates index format
- Accepts letters at end (224169D)
- Shows error for invalid formats

### ✅ Computed Data Display
- Student index
- Latitude (2 decimal places)
- Longitude (2 decimal places)
- Complete API URL in small grey text

### ✅ Weather Fetching
- Loading spinner during fetch
- Parses `current_weather` from API response:
  - temperature
  - windspeed
  - weathercode
- Displays timestamp from device clock

### ✅ Offline Mode
- Saves weather data to SharedPreferences on successful fetch
- Automatically loads cached data when network fails
- Shows "(cached)" badge on card
- Friendly error message if no cache exists

### ✅ Error Handling
- Network errors
- Invalid index format
- Missing API fields
- JSON parsing errors
- Offline scenarios

## UI Elements

- **AppBar**: 
  - "Weather Dashboard" title with blue theme
  - **ONLINE/OFFLINE badge** with WiFi icon (green for online, red for offline)
  - Real-time connectivity status updates
- **Input Card**: Student index TextField with validation
- **Coordinates Card**: Shows computed lat/lon and API URL
- **Fetch Button**: Blue elevated button with loading state
- **Weather Card**: 
  - Temperature with thermometer icon
  - Wind speed with air icon
  - Weather code with cloud icon
  - Last updated timestamp
  - Cached badge when showing offline data

## Testing Offline Mode

### Method 1: Using Airplane Mode
1. Run app and fetch weather data (ensures cache is saved)
2. **Observe the ONLINE badge in the app bar** (green with WiFi icon)
3. Enable airplane mode on device
4. **Watch the badge automatically change to OFFLINE** (red with WiFi-off icon)
5. Press "Fetch Weather" button again
6. App displays cached data with "(cached)" badge
7. Snackbar shows "Showing cached data (offline mode)"

### Method 2: Disconnect WiFi/Mobile Data
1. Run the app while connected to internet
2. **See ONLINE badge in green** at the top right
3. Disconnect WiFi or mobile data
4. **Badge automatically updates to OFFLINE in red**
5. Try fetching weather - app will show cached data
6. Reconnect internet - **Badge turns back to ONLINE in green**

## Code Quality

- ✅ No placeholder comments
- ✅ No TODO items
- ✅ Complete implementations
- ✅ Proper error handling
- ✅ Clean architecture with separation of concerns
- ✅ Fully runnable and production-ready

## Author

Student Index: 224169D

## License

This project is created for educational purposes.
