import 'package:flutter/material.dart';
import 'package:Star_Points/receiver.dart';
import 'package:telephony/telephony.dart';
import 'package:Star_Points/radeem.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final HomePage homePage = HomePage(key: PageStorageKey('HomePage'));
  final Radeem radeemPage = Radeem(key: PageStorageKey('RadeemPage'));

  late final List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [homePage, radeemPage];
  }

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String messageBody = "";
  bool isRedeemEnabled = false;
  double radeemableBalance = 0.0;
  double totalBalance = 0.0;

  @override
  bool get wantKeepAlive => true;
  void initState() {
    super.initState();
    // Set isRedeemEnabled to false initially
    setState(() {
      isRedeemEnabled = false;
      messageBody = "Check Your Balance";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Star Points Radeem'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue,
                    width: 4.0,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    sendSms();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: const CircleBorder(),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: const Text(
                      'check',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$messageBody',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      messageBody != "Check Your Balance"
                          ? '${radeemableBalance}'
                          : "",
                      style: TextStyle(
                          fontSize: 20,
                          color: isRedeemEnabled
                              ? Color.fromARGB(255, 142, 211, 144)
                              : Colors.red),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Balance ',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      messageBody != "Check Your Balance"
                          ? '${totalBalance}'
                          : "",
                      style: TextStyle(
                          fontSize: 20,
                          color: isRedeemEnabled
                              ? Color.fromARGB(255, 142, 211, 144)
                              : Colors.red),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(200, 80),
                ),
                onPressed: isRedeemEnabled
                    ? () async {
                        // Navigate to the redeem screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Radeem()),
                        );
                      }
                    : null,
                child: const Text('Redeem'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendSms() async {
    const address = '141';
    const message = 'Star Points';

    try {
      const platform = MethodChannel('send_sms');
      await platform.invokeMethod('send', <String, dynamic>{
        'address': address,
        'message': message,
      });
      debugPrint('SMS sent successfully!');
    } on PlatformException catch (e) {
      debugPrint('Error sending SMS: $e');
    }
    
    String newMessageBody = await getSmsMessageBody();
    // String newMessageBody = "Your STAR POINTS balance is 11.01";
    RegExp regExp = new RegExp(r'Your STAR POINTS balance is (\d+\.\d{2})');
    Match? match = regExp.firstMatch(newMessageBody);
    double Total = (match != null ? double.parse(match.group(1) ?? "0") : 0);
    double balance = Total - 100.00;

    setState(() {
      totalBalance = Total;
      balance = balance <= 0.0 ? 0.0 : balance;
      radeemableBalance = double.parse(balance.toStringAsFixed(2));
      isRedeemEnabled = (radeemableBalance > 0.0);
      print(isRedeemEnabled);
      messageBody = "Radeemable Balance ";
    });
  }
}
