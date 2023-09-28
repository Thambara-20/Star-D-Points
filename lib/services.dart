import 'package:flutter/material.dart';
import 'package:ussd_service/ussd_service.dart';

class Donate extends StatelessWidget {
  final donateController;
  final number;
  final title;
  final icon;
  final color;

  const Donate(
      {super.key,
      required this.donateController,
      required this.title,
      required this.icon,
      required this.number,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () async {
          print(donateController.text);
          await DonateService(number: number, donateController: donateController);
          // Donate the amount
        },
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(300, 90)),
          backgroundColor:
              MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 0, 0, 0))),
            SizedBox(width: 20),
            icon,
          ],
        ),
      ),
    );
  }

  DonateService({required number, required donateController}) async {
    String amount = donateController.text;
    if (amount == "") {
      return;
    }
    donateController.clear();
    int subscriptionId = 1; // sim card subscription ID
    String code = "#141*6*4*1*${amount}#";

    try {
      String ussdResponseMessage = await UssdService.makeRequest(
        subscriptionId,
        code,
        Duration(seconds: 10), // timeout (optional) - default is 10 seconds
      );
      print("succes! message: $ussdResponseMessage");
    } catch (e) {
      debugPrint("error! code: ${e}");
    }
  }
}
