// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Test", style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          TextButton(onPressed: null, child: Text("Home", style: Theme.of(context).textTheme.titleMedium)),
          TextButton(onPressed: null, child: Text("About", style: Theme.of(context).textTheme.titleMedium)),
          TextButton(onPressed: null, child: Text("Contacts", style: Theme.of(context).textTheme.titleMedium)),
          TextButton(onPressed: null, child: Text("Clinics", style: Theme.of(context).textTheme.titleMedium)),
          SizedBox(width: 16),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "SmartTest is a revolutionary app designed to empower individuals and couples to take control of their HIV status. With a user-friendly interface, SmartTest makes HIV testing accessible, confidential, and seamless, allowing users to test from the comfort of their home. Unique features include easy self-testing with step-by-step instructions, couple testing for shared understanding and support, and secure data encryption to ensure privacy. In case of positive results, SmartTest provides resources, information, and a care facility locator to guide you to the next steps. Stay informed with regular updates on HIV prevention and receive timely notifications for testing reminders and health news.",
                        ),
                      ),

                      SizedBox(
                        height: 500,
                        width: 300,
                        child: Image.asset("testkit.jpg"),
                      ),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
