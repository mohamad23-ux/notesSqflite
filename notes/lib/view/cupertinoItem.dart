// import 'package:arabic_font/arabic_font.dart';
// import 'package:flutter/material.dart';

// class Cupertinoitem extends StatefulWidget {
//   final String title;
//   final Icon icon;

//   Cupertinoitem({required this.title,});

//   @override
//   _Cupertinoitem createState() => _Cupertinoitem();
// }

// class _Cupertinoitem extends State<Cupertinoitem> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           isClicked = !isClicked;
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.only(left: 3, right: 3),
//         height: 30,
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: isClicked
//               ? const Color.fromARGB(255, 0, 201, 67)
//               : const Color.fromARGB(255, 107, 107, 107),
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Center(
//           child: Text(
//             widget.title,
//             style: ArabicTextStyle(
//               color: const Color.fromARGB(255, 255, 255, 255),
//               arabicFont: ArabicFont.changa,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
