import 'package:flutter/material.dart';

class Radeem extends StatefulWidget {
  const Radeem({Key? key}) : super(key: key);

  @override
  _RadeemState createState() => _RadeemState();
}

class _RadeemState extends State<Radeem> {
  int _radeemAmount = 0;

  void _incrementRadeemAmount() {
    setState(() {
      _radeemAmount++;
    });
  }

  void _decrementRadeemAmount() {
    setState(() {
      if (_radeemAmount > 0) {
        _radeemAmount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redeem'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Radeem Amount:',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _decrementRadeemAmount,
                ),
                Text(
                  '$_radeemAmount',
                  style: const TextStyle(fontSize: 24),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _incrementRadeemAmount,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Redeem the amount
                final message = 'You have successfully redeemed $_radeemAmount coins';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Redeem'),
            ),
          ],
        ),
      ),
    );
  }
}
