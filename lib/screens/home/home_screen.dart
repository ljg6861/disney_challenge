import 'dart:math';

import 'package:disney_challenge/screens/select_guests/models/guest.dart';
import 'package:disney_challenge/screens/select_guests/select_guests_screen.dart';
import 'package:disney_challenge/widgets/layout/disney_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DisneyAppBar(
        title: 'Lucas Golden',
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  List<Guest> guests = [];
                  for (int i = 0; i < 10; i++) {
                    guests
                        .add(Guest(name: '${i.toString()} ${i.toString()}', hasReservation: Random().nextInt(2) == 1));
                  }
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => SelectGuestsScreen(guests: guests)));
                },
                child: const Text('Short List')),
            ElevatedButton(onPressed: () {
              List<Guest> guests = [];
              for (int i = 0; i < 50; i++) {
                guests
                    .add(Guest(name: '${i.toString()} ${i.toString()}', hasReservation: Random().nextInt(2) == 1));
              }
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SelectGuestsScreen(guests: guests)));
            }, child: const Text('Long List')),
          ],
        ),
      ),
    );
  }
}
