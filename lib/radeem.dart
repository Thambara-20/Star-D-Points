import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class Radeem extends StatefulWidget {
  const Radeem({Key? key}) : super(key: key);

  @override
  _RadeemState createState() => _RadeemState();
}

class _RadeemState extends State<Radeem> {
  int _radeemAmount = 0;
  TextEditingController amountController = TextEditingController();
  TextEditingController donateController = TextEditingController();
  final Telephony telephony = Telephony.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redeem'),
      ),
      body: Container(
        color: Color.fromARGB(255, 0, 0, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Radeem',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 200,
                      child: TextField(
                        controller: amountController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(
                                    255, 6, 155, 209)), // Change the color here
                          ),
                          labelText: 'Amount',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 0, 213, 255)),
                        ),
                        style:
                            const TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 251, 255)),
                      )),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await radeem();
                      // Redeem the amount
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(90, 90)),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                    child: const Text('Redeem' , style: TextStyle(fontSize: 14 , color: Color.fromARGB(255, 0, 0, 0))),
                  ),
                ],
              ),
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
              ElevatedButton(
                onPressed: () async {
                  // Donate the amount
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size(300, 90)),
                  backgroundColor:
                      MaterialStateProperty.all(Color.fromARGB(255, 255, 0, 0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Donate little hearts',
                        style: TextStyle(fontSize: 20 , color: Color.fromARGB(255, 0, 0, 0))),
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.favorite,
                      color: Color.fromARGB(255, 184, 3, 3),
                      size: 30,
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(0, -5)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> radeem() async {
    var amount = amountController.text;
    print(amount);

    try {
      telephony.sendSms(to: '141', message: 'Star Pay $_radeemAmount');
      // ignore: empty_catches
    } catch (e) {
      print("Error radeem: $e");
    }
  }
}
