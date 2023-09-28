import 'dart:math';

import 'package:Star_Points/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ussd_service/ussd_service.dart';

class Donate extends StatelessWidget {
  final donateController;
  final number;
  final title;
  final icon;
  final color;
  final enabled;

  const Donate(
      {super.key,
      required this.donateController,
      required this.title,
      required this.icon,
      required this.number,
      required this.color,
      required this.enabled});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled
          ? () async {
              await DonateService(
                  number: number, donateController: donateController);

              // Donate the amount
            }
          : () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors
                        .transparent, // Set the background color to transparent
                    contentPadding: EdgeInsets.zero, // Remove default padding
                    content: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                Color.fromARGB(255, 109, 0, 0)), // Set border color and width
                        borderRadius:
                            BorderRadius.circular(10.0), // Set border radius
                        color:
                            const Color.fromARGB(255, 0, 0, 0), // Set the content background color
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // Content of the AlertDialog
                            Text(
                              'You do not have enough balance',
                              style: TextStyle(
                                color: Color.fromARGB(255, 202, 0, 0), // Set text color
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 186, 254), // Set button text color
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(const Size(300, 90)),
        backgroundColor: MaterialStateProperty.all(color),
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
