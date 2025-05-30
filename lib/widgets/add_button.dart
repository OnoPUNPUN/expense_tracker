import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final function;

  const AddButton({super.key, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Center(
        child: Column(
          children: [
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1d1b20),
              ),
              child: Center(
                child: Text(
                  '+',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
