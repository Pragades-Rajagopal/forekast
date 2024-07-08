import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:forekast_app/data/local_storage/data.dart';
import 'package:forekast_app/screens/favorites.dart';
import 'package:forekast_app/screens/forecast.dart';
import 'package:forekast_app/screens/settings.dart';
import 'package:forekast_app/services/cities_api.dart';
import 'package:forekast_app/utils/themes.dart';
import 'package:forekast_app/utils/tools.dart';
import 'package:get/get.dart';

BorderRadius searchBarRadius = BorderRadius.circular(30.0);

class AppBasePage extends StatefulWidget {
  final int index;
  const AppBasePage({super.key, required this.index});

  @override
  State<AppBasePage> createState() => _AppBasePageState();
}

class _AppBasePageState extends State<AppBasePage> {
  late PageController _pageController = PageController();
  final textController = TextEditingController();
  var _currentIndex = 0;
  CitiesApi cities = CitiesApi();
  List<String> citiesData = [];

  // Titles
  static final List<String> _titles = [
    'forekast',
    'favorites',
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex = widget.index;
      _pageController = PageController(initialPage: _currentIndex);
    });
    initStateMethods();
  }

  void initStateMethods() async {
    await getCitiesFunc();
  }

  Future<void> getCitiesFunc() async {
    citiesData = await cities.getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: _titles[_currentIndex], index: _currentIndex),
      // extendBodyBehindAppBar: true,
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        allowImplicitScrolling: true,
        children: const [
          ForecastPage(),
          FavoritesPage(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          textTheme: textTheme,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.tertiary,
          iconSize: 32.0,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          items: bottomNavBar,
        ),
      ),
    );
  }

  AppBar appBar({title = 'forekast', index = -1}) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0.0,
      forceMaterialTransparency: false,
      title: Text(title),
      centerTitle: true,
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      leading: index != 2
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
              child: IconButton(
                tooltip: 'Settings',
                onPressed: () {
                  Get.to(() => const SettingsPage());
                },
                icon: const Icon(
                  Icons.settings,
                  // size: 20,
                ),
                alignment: Alignment.center,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            )
          : null,
      actions: [
        if (index != 2) ...{
          IconButton(
            tooltip: 'search',
            onPressed: () {
              _showBottomSheet(context);
            },
            icon: const Icon(
              Icons.search,
              // size: 20,
            ),
            alignment: Alignment.center,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        }
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0.0,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  weatherAppSearch(),
                  const SizedBox(height: 14.0),
                  // searchResultView(citiesData),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget weatherAppSearch() {
    GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
    return SizedBox(
      height: 48,
      width: 360,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: SimpleAutoCompleteTextField(
                key: key,
                controller: textController,
                suggestions: citiesData,
                suggestionsAmount: 6,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  hintText: 'search city',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: searchBarRadius,
                    borderSide: const BorderSide(
                      width: 0.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: searchBarRadius,
                    borderSide: const BorderSide(
                      color: Colors.white10,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white12,
                  prefixIcon: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      textController.text = '';
                    },
                  ),
                  suffixIcon: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                      if (textController.text != '') {
                        await SearchCity.storeSearchCity(textController.text);
                        Get.offAllNamed('/forecast');
                        textController.text = '';
                      }
                    },
                  ),
                ),
                cursorColor: Colors.white,
                style: const TextStyle(
                  color: Colors.white,
                ),
                textSubmitted: (data) async {
                  if (textController.text != '') {
                    await SearchCity.storeSearchCity(textController.text);
                    Get.offAllNamed('/forecast');
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
