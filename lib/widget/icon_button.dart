import 'package:flutter/material.dart';

enum Category {
  card(Icons.card_membership_outlined),
  test(Icons.check_box_outlined),
  edit(Icons.edit_outlined),
  delete(Icons.delete_outline_outlined),
  restart(Icons.restart_alt_outlined),
  end(Icons.stop_circle_outlined),
  ;

  final IconData icon;

  const Category(this.icon);
}

class Iconbutton extends StatelessWidget {
  const Iconbutton({
    super.key,
    required this.iconButtonName,
    required this.category,
    required this.onTap,
    this.color = Colors.white,
    this.textColor = Colors.black,
  });

  final String iconButtonName;
  final Category category;
  final void Function() onTap;
  final Color color;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category.icon,
                color: textColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                iconButtonName,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
