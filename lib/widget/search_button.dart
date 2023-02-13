import 'package:flutter/material.dart';


class SearchButton extends StatelessWidget {
  const SearchButton({
  required this.icon,
  required this.onTap,
  });

final IconData icon;
final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
         borderRadius: BorderRadius.circular(6),
         splashColor: Colors.orange,
         onTap: onTap,
         child: Padding(
           padding: const EdgeInsets.all(6.0),
           child: Icon(
            icon,
            size: 18,
            color: Colors.black,

           ),
         ),

      )
    );
  }
}