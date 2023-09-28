import 'package:Star_Points/services.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({Key? key}) : super(key: key);

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final Telephony telephony = Telephony.instance;
  TextEditingController donateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Donate'),
        backgroundColor: Color.fromARGB(255, 0, 73, 182),
      ),
      body: Container(
          color: Color.fromARGB(255, 0, 0, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text('Donations',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      child: TextField(
                          controller: donateController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 20, 161, 254)), // Change the color here
                            ),
                            labelText: 'Amount',
                            labelStyle: TextStyle(color: Color.fromARGB(255, 0, 188, 251))
                          ),
                          style: const TextStyle(fontSize: 20 , color: Color.fromARGB(255, 0, 251, 255))),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Donate(
                  number: '4',
                  donateController: donateController,
                  title: 'Donate little hearts',
                  icon: Icon(Icons.favorite), // Wrap the icon with an Icon widget
                  color: Color.fromARGB(255, 255, 0, 0),
                ),
                const SizedBox(height: 20),
                Donate(
                  number: '3',
                  donateController: donateController,
                  title:  'Manudam Mehewara',
                  icon: Icon(Icons.handshake), // Wrap the icon with an Icon widget
                  color: Color.fromARGB(255, 108, 46, 255),
                ),
                const SizedBox(height: 20),
                Donate(
                  number: '5',
                  donateController: donateController,
                  title: 'Unicef SL',
                  icon: Icon(Icons.money), // Wrap the icon with an Icon widget
                  color: Color.fromARGB(255, 0, 165, 0),
                ),
              ],
            ),
          ),
        ),
    );
  }
}