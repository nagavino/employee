// role_bottom_sheet.dart
import 'package:flutter/material.dart';

class RoleBottomSheet extends StatelessWidget {
  const RoleBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final roles = [
      'Product Designer',
      'Flutter Developer',
      'QA Tester',
      'Product Owner',
    ];

    return Container(
      padding: const EdgeInsets.only(
        top: 0,
      ),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25), topLeft: Radius.circular(25)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: roles.map((role) {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context)
                        .dividerColor, // Adjust the color as needed
                    width: 1.0,
                  ),
                ),
              ),
              child: ListTile(
                title: Center(
                    child: Text(
                  role,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.merge(const TextStyle(fontWeight: FontWeight.w400)),
                )),
                onTap: () => Navigator.pop(context, role),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
