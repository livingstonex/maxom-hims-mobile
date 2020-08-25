import 'dart:ui';

Color hex(String hexColor) {
          final hexCode = hexColor.replaceAll('#', '');
          return Color(int.parse('FF$hexCode', radix: 16));
        }