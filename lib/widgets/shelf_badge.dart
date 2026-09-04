import 'package:flutter/material.dart';
import '../models/book_models.dart';

class ShelfBadge extends StatelessWidget {
  final ShelfType shelfType;

  const ShelfBadge({
    super.key,
    required this.shelfType,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (shelfType) {
      case ShelfType.currentlyReading:
        bg = Colors.blue.shade100;
        fg = Colors.blue.shade900;
        break;
      case ShelfType.read:
        bg = Colors.green.shade100;
        fg = Colors.green.shade900;
        break;
      case ShelfType.wantToRead:
        bg = Colors.orange.shade100;
        fg = Colors.orange.shade900;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        shelfType.label,
        style: TextStyle(
          color: fg,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
