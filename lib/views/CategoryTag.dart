import 'package:flutter/material.dart';

class CategoryTag extends StatelessWidget {
  final String title; 
   final VoidCallback onTap;
  final bool isSelected;

  const CategoryTag({super.key, required this.title, required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}