import 'package:flutter/material.dart';

class VehicleCard extends StatelessWidget {
  final String type;
  final String fare;
  final IconData icon;

  const VehicleCard({
    super.key,
    required this.type,
    required this.fare,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF1E3A8A);
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: primary),
          const SizedBox(height: 4),
          Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('₹$fare', style: const TextStyle(color: Color(0xFF64748B))),
        ],
      ),
    );
  }
}
