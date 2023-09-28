import 'package:Star_Points/services.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import 'package:ussd_advanced/ussd_advanced.dart';
import 'package:ussd_service/ussd_service.dart';

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

  void initState() {
    super.initState();
    _requestUSSDPermission(); // Request USSD permission when the app starts
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redeem'),
        backgroundColor: Color.fromARGB(255, 0, 73, 182),
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
                      fixedSize: MaterialStateProperty.all(const Size(100, 70)),
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
  
  Future<void> _requestUSSDPermission() async {
   
    final status = await Permission.phone.request();
    if (status.isGranted) {
      print('permission granted');
    } else {
      print('permission denied');
      // Permission denied, handle this case (e.g., show a message to the user)
    }
  }


}
