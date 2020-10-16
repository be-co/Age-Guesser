import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:age_guesser/services/storage.dart';
import 'package:age_guesser/view_model/history_list.dart';
import 'package:age_guesser/view/screens/history.dart';
import 'package:age_guesser/view/screens/home.dart';
import 'package:age_guesser/view/screens/settings.dart';

void main() async {
  /// We need to wait for a binding to be established
  /// otherwise the following statement (initializeSharedPrefs()) will produce an error
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSharedPrefs();

  /// Initialize history list provider and start app
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => HistoryListViewModel(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Guesser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      /// Dark mode theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),
      themeMode: ThemeMode.light,
      home: MyHomePage(title: 'Age Guesser'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(title);
}

class _MyHomePageState extends State<MyHomePage> {
  /// Variables required for switching between tabs
  int _currentIndex = 0;

  /// The page controller is necessary to show an animation when switchting between tabs
  PageController _pageController;

  /// The title in the app bar will be changed depending on the currently selected tab
  String appTitle;

  _MyHomePageState(this.appTitle);

  /// The list of our three main screens
  final List<Widget> _tabs = [
    Home(),
    History(),
    Settings(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    //initializeDateFormatting('de');
    /// When the app is launched for the first time we want to show a small popup
    bool firstLaunch = getBoolSettings('first_launch');

    /// TODO share prefs should ideally be initialized once when the app is first stared
    /// To prevent an error when receiving a null value from shared prefs
    if (firstLaunch == null) {
      firstLaunch = true;
    }

    /// Show popup when it's the first launch of the app
    if (firstLaunch) {
      Future.delayed(Duration.zero, () {
        _showFirstLaunchDialog(context);
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: _tabs,
        ),
      ),

      /// Only show the floating action button on the history tab
      /// Allows to refresh the list of made guesses
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
              onPressed: _refreshHistoryListView,
              tooltip: 'Refresh',
              child: Icon(Icons.refresh),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Guess'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.history),
              title: new Text('History'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              title: new Text('Settings'),
            ),
          ]),
    );
  }

  /// Change the current tab to the one selected by the user
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;

      /// Show animation when changing between tabs
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 200), curve: Curves.easeOut);

      /// Change app bar title depending on which tab is currently selected
      switch (index) {
        case 0:
          appTitle = "Home";
          break;
        case 1:
          appTitle = "History";
          break;
        case 2:
          appTitle = "Settings";
          break;
        default:
          appTitle = "Age Guess";
      }
    });
  }

  /// Function that is called by the floating action button
  void _refreshHistoryListView() {
    /// Call the refresh function of our history list provider
    Provider.of<HistoryListViewModel>(context, listen: false).refresh();
  }

  /// Create the popup that is shown to users on their first app launch
  void _showFirstLaunchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Welcome to Age Guesser'),
          content: Text(
              'This is a simple app developed with Flutter. Simply enter your name in the text field and press the submit button to get an age guess.\n\nHave fun!'),
          actions: [
            FlatButton(
                onPressed: () {
                  saveBoolSettings('first_launch', false);
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text('Dismiss'))
          ],
        );
      },
    );
  }
}
