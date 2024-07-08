import 'package:flutter/material.dart';
import 'package:forekast_app/data/local_storage/data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:forekast_app/models/weather_model.dart';
import 'package:forekast_app/services/cities_api.dart';
import 'package:forekast_app/services/weather_api.dart';
import 'package:forekast_app/screens/widgets/additional_info.dart';
import 'package:forekast_app/screens/widgets/current_weather.dart';
import 'package:forekast_app/screens/widgets/daily_forecast.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  final textController = TextEditingController();
  // setting default search city
  String searchCity = '';

  WeatherApi client = WeatherApi();
  Weather? data;
  DailyWeather? dailyData;
  CitiesApi cities = CitiesApi();
  List<String> citiesData = [];
  String? country;

  @override
  void initState() {
    super.initState();
    initStateMethods();
  }

  void initStateMethods() async {
    await getCitiesFunc();
    final city = await SearchCity.getSearchCity();
    setState(() {
      searchCity = city;
    });
    print(city);
    await getData(searchCity);
  }

  Future<void> getData(String city) async {
    data = await client.getCurrentWeather(city);
    print(data?.cityName);
    dailyData = await client.getDailyWeather(data?.lat, data?.lon);
    await countryName(data!.country);
  }

  Future<void> getCitiesFunc() async {
    citiesData = await cities.getCities();
  }

  Future<void> countryName(String? code) async {
    country = await cities.getCountryName(code!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          // weatherAppSearch(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  weatherFutureBuilder(searchCity),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<void> weatherFutureBuilder(String city) {
    return FutureBuilder(
      future: getData(city),
      builder: (context, snapshot) {
        try {
          if (snapshot.connectionState == ConnectionState.done) {
            if (data?.cityName == '') {
              print('inside if');
              return const Center(
                child: Text(
                  "Oops! \nWeather info not available.\nPlease search for another city.",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return weatherColumn(data);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }
          return const Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        } catch (e) {
          return const Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }

  SingleChildScrollView weatherColumn(data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          currentWeather(
            getIcon(data!.icon),
            "${data!.temp}°C",
            "${data!.cityName}",
            "${data!.description}",
            "$country!",
            context,
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            'additional information',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          additionalInformation(
            "${data!.wind}m/s ${data!.degree}",
            "${data!.humidity}%",
            "${data!.pressure}hPa",
            "${data!.feelsLike}°C",
            "${data!.degree}",
            context,
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'daily forecast',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          dailyForecast(dailyData!.model),
          const SizedBox(
            height: 10.0,
          ),
          const Center(
            child: SizedBox(
              width: 240,
              height: 50,
              child: Text(
                'Data provided by OpenWeather',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Image getIcon(String icon) {
    String url = "https://openweathermap.org/img/wn/$icon@4x.png";
    return Image.network(url);
  }

  AppBar weatherAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0.0,
      forceMaterialTransparency: false,
      title: const Text('forekast'),
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 24.0,
        color: const Color(0xFF2979FF),
      ),
    );
  }
}
