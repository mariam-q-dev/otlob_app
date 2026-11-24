import 'package:flutter/material.dart';

class AddressSelector extends StatelessWidget {
  const AddressSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.location_on, color: Colors.deepOrange, size: 18),
        SizedBox(width: 4),
        Text(
          "14 Tahrir Square, Cairo",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
        ),
        Icon(Icons.keyboard_arrow_down, color: Colors.deepOrange, size: 18),
      ],
    );
  }
}