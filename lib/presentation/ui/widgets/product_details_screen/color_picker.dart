import 'package:e_commerce/data/utility/color_extension.dart';
import 'package:flutter/material.dart';
class ColorPicker extends StatefulWidget {
  ColorPicker({super.key, required this.colors, required this.selectedColorIndex});
  final List<String>colors;
  late int selectedColorIndex;
  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.colors.length,
      itemBuilder: (context, index) {
        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            widget.selectedColorIndex = index;
            if (mounted) {
              setState(() {});
            }
          },
          child: CircleAvatar(
            radius: 18,
            backgroundColor: HexColor.fromHex(widget.colors[index]),
            child: widget.selectedColorIndex == index
                ? const Icon(
              Icons.done,
              color: Colors.white,
            )
                : null,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 8,
        );
      },
    );
  }
}