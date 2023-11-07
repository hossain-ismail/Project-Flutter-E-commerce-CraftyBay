import 'package:flutter/material.dart';
import '../../utility/app_colors.dart';
class PickColorAndSize extends StatefulWidget {
  final List<String> sizes;
  late  int selectedIndex;
  final Function(int) onSizeSelected;

  PickColorAndSize({super.key, required this.sizes,  required this.selectedIndex, required this.onSizeSelected});

  @override
  State<PickColorAndSize> createState() => _PickColorAndSizeState();
}

class _PickColorAndSizeState extends State<PickColorAndSize> {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.sizes.length,
        itemBuilder: (context, index) {
          return InkWell(
              borderRadius: BorderRadius.circular(4),

              onTap: () {
                widget.selectedIndex = index;
               widget.onSizeSelected(index);
                if (mounted) {
                  setState(() {});
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8),
                decoration: BoxDecoration(
                  border:
                  Border.all(color: Colors.grey),
                  borderRadius:
                  BorderRadius.circular(4),
                  color: widget.selectedIndex == index
                      ? AppColors.primaryColor
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.sizes[index],
                  style: TextStyle(
                    color: widget.selectedIndex == index
                        ? Colors.white
                        : null,
                  ),
                ),
              ));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 8,
          );
        });
  }
}