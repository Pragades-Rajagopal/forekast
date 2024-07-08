import 'package:flutter/material.dart';

Widget currentWeather(
  Image icon,
  String temp,
  String location,
  String description,
  String country,
  BuildContext context,
) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 160,
            height: 160,
            child: icon,
          ),
        ),
        const SizedBox(
          height: 2.0,
        ),
        Text(
          temp,
          style: TextStyle(
            fontSize: 48.0,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          width: 340,
          child: Text(
            "$location, $country",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    ),
  );
}
