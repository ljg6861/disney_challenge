import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConflictBottomSheet extends StatefulWidget{
  const ConflictBottomSheet({super.key});

  @override
  State<ConflictBottomSheet> createState() => _ConflictBottomSheetState();
}

class _ConflictBottomSheetState extends State<ConflictBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff00233c),
      padding: EdgeInsets.only(
          left: 16,
          bottom: MediaQuery.of(context).padding.bottom,
          right: 16),
      height: 92 + MediaQuery.of(context).padding.bottom,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reservation Needed',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900),
                ),
                Flexible(
                    child: Text(
                      'Select at least one Guest that has a reservation to continue.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    )),
              ],
            ),
          ),
          Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Color(0xff00233c),
              ),
            ),
          )
        ],
      ),
    );
  }
}