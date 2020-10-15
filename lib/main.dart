import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:age_guesser/services/storage.dart';
import 'package:age_guesser/view_model/history_list_view_model.dart';
import 'package:age_guesser/view/screens/history.dart';
import 'package:age_guesser/view/screens/home.dart';
import 'package:age_guesser/view/screens/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSharedPrefs();
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
  int _currentIndex = 0;
  PageController _pageController;
  String appTitle;
  int counter = 0;

  _MyHomePageState(this.appTitle);

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
    bool firstLaunch = getBoolSettings('first_launch');
    if (firstLaunch == null) {
      firstLaunch = true;
    }
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

  // Change the current tab to the selected one
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 200), curve: Curves.easeOut);
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

  void _refreshHistoryListView() {
    Provider.of<HistoryListViewModel>(context, listen: false).refresh();
  }

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
