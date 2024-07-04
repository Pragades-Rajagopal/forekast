import 'package:flutter/material.dart';

const bottomNavBar = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.wb_sunny_outlined),
    activeIcon: Icon(Icons.sunny_snowing),
    label: 'current forecast',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.favorite_outline_outlined),
    activeIcon: Icon(Icons.favorite),
    label: 'favorites',
  ),
];
