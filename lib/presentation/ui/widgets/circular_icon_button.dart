import 'package:flutter/material.dart';
class CircularIconButton extends StatefulWidget {
  const CircularIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  State<CircularIconButton> createState() => _CircularIconButtonState();
}

class _CircularIconButtonState extends State<CircularIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onTap();
        setState(() {

        });
      },
      borderRadius: BorderRadius.circular(30),

      child: CircleAvatar(
        radius: 14,
        backgroundColor: Colors.grey.shade200,
        child:  Icon(
          widget.icon,
          size: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}