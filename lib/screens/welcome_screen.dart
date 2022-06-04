import 'package:flutter/material.dart';
import 'package:live_chat/screens/registeration_screen.dart';
import 'package:live_chat/widgets/my_button.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  child: Image.asset(
                    'images/chat_icon.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                const Text(
                  'Live Chat',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            MyButton(
              name: 'Login',
              color: Colors.yellow[900],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              name: 'Sign Up',
              color: Colors.blue,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ReqisterationScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
