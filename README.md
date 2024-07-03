# Weather App

A mobile application developed using Flutter to display weather data fetched from the OpenWeather API.

## Features

- Display current weather conditions for a selected location
- Show weather forecast for the next few days
- Update weather information based on user's location
- Support for multiple cities
- User-friendly interface

## Installation

1. **Clone the repository:**
    ```sh
    git clone https://github.com/ManojKumar-GS/weather_app.git
    cd weather_app
    ```

2. **Install dependencies:**
    ```sh
    flutter pub get
    ```

3. **Set up the OpenWeather API key:**
    - Sign up on [OpenWeather](https://openweathermap.org/) and get your API key.
    - Create a file named `.env` in the root directory of the project.
    - Add your API key to the `.env` file:
      ```env
      API_KEY=your_openweather_api_key
      ```

4. **Run the application:**
    ```sh
    flutter run
    ```

## Usage

1. **Select a city:** Use the search functionality to find and select a city.
2. **View weather details:** The app will display the current weather and forecast for the selected city.
3. **Update location:** The app can update weather information based on the user's current location.

## Dependencies

- [dio](https://pub.dev/packages/dio): For making HTTP requests to the OpenWeather API
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv): For loading environment variables from a `.env` file
- [geolocator](https://pub.dev/packages/geolocator): For accessing the user's location

## API Reference

This application uses the [OpenWeather API](https://openweathermap.org/api) to fetch weather data.

### Endpoints

- **Current Weather Data:** `https://api.openweathermap.org/data/2.5/weather`
- **5 Day / 3 Hour Forecast:** `https://api.openweathermap.org/data/2.5/forecast`

### Request Example

To get current weather data for a city:
```sh
GET https://api.openweathermap.org/data/2.5/weather?q=London&appid=your_openweather_api_key
