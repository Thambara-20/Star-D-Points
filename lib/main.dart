import 'package:Star_Points/Donate.dart';
import 'package:Star_Points/Home.dart';
import 'package:flutter/material.dart';
import 'package:Star_Points/receiver.dart';
import 'package:telephony/telephony.dart';
import 'package:Star_Points/radeem.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
     ChangeNotifierProvider(
      create: (context) => BalanceProvider(), // Provide the BalanceProvider
      child: const MyApp(),
    ),);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  double radeemableBalance = 0.0;

 
  

  final HomePage homePage = HomePage(key: PageStorageKey('HomePage'));
  final Radeem radeemPage = Radeem(key: PageStorageKey('RadeemPage'));
  final DonatePage donatePage = DonatePage(key: PageStorageKey('DonatePage'));

  late final List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [homePage, radeemPage, donatePage];
    
  }

  @override
  Widget build(BuildContext context) {
    final balanceProvider = Provider.of<BalanceProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _children,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: 'Redeem',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Donate',
            ),
          ],
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          selectedItemColor: Color.fromARGB(255, 0, 188, 251),
          unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}

class BalanceProvider with ChangeNotifier {
  double radeemableBalance = 0.0;

  void updateBalance(double newBalance) {
    radeemableBalance = newBalance;
    notifyListeners(); // Notify listeners that the balance has changed.
  }
}