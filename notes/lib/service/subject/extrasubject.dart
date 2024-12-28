// import 'package:arabic_font/arabic_font.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:notes/provider/pro.dart';
// import 'package:notes/view/svu.dart';
// import 'package:provider/provider.dart';
// import 'package:pull_down_button/pull_down_button.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

// class extraSubject extends StatefulWidget {
//   const extraSubject({super.key});

//   @override
//   State<extraSubject> createState() => _extraSubjectState();
// }

// class _extraSubjectState extends State<extraSubject> {
//   double max = 73;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: context.read<Pro>().mood == true
//             ? const Color.fromARGB(255, 6, 6, 6)
//             : const Color.fromARGB(255, 212, 194, 225),
//         appBar: AppBar(
//           backgroundColor: context.read<Pro>().mood == true
//               ? const Color.fromARGB(255, 27, 27, 27)
//               : Color.fromARGB(255, 53, 53, 53),
//           leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: context.read<Pro>().mood == true
//                     ? const Color.fromARGB(255, 255, 255, 255)
//                     : Color.fromARGB(255, 255, 255, 255),
//               ),
//               onPressed: () {
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (context) => SVU()),
//                     (route) => true);
//               }),
//           title: Align(
//             alignment: Alignment.centerRight,
//             child: Text(
//               "اضافات جامعية",
//               style: ArabicTextStyle(
//                 arabicFont: ArabicFont.avenirArabic,
//                 color: context.read<Pro>().mood == true
//                     ? const Color.fromARGB(255, 228, 231, 228)
//                     : Color(0xFFF9F7C9),

//                 // تحديد اللون الأبيض للنص
//               ),
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.80,
//                 child: Column(
//                   children: [
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       margin: EdgeInsets.only(
//                         top: 15,
//                         left: 20,
//                       ),
//                       child: Text(
//                         "Hi, Mohamad!",
//                         style: ArabicTextStyle(
//                             color: Colors.white,
//                             fontSize: 32,
//                             arabicFont: ArabicFont.avenirArabic),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(left: 16),
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
//                         style: ArabicTextStyle(
//                             color: Color.fromARGB(130, 255, 255, 255),
//                             fontSize: 18,
//                             arabicFont: ArabicFont.avenirArabic),
//                       ),
//                     ),
//                     averageContainer(),
//                     operationSchool(),
//                   ],
//                 ),
//               ),
//               //exam degree
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget averageContainer() {
//     return Container(
//       padding: EdgeInsets.all(8),
//       margin: EdgeInsets.only(
//         top: 12,
//       ),
//       width: MediaQuery.of(context).size.width * 0.97,
//       height: MediaQuery.of(context).size.height * 0.20,
//       decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 41, 39, 41),
//           borderRadius: BorderRadius.circular(22)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                 margin: EdgeInsets.only(left: 12),
//                 child: Text(
//                   "F24 : الفصل ",
//                   style: mystyle(22),
//                 ),
//               ),
//               Text(
//                 "Avg : 2.5 ",
//                 style: mystyle(15),
//               ),
//               Text(
//                 "ITE-SVU",
//                 style: mystyle(15),
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               Container(
//                   width: 200,
//                   height: 140,
//                   decoration: BoxDecoration(
//                       // color: const Color.fromARGB(255, 0, 0, 0),
//                       borderRadius: BorderRadius.circular(22)),
//                   padding: EdgeInsets.all(10),
//                   child: SfRadialGauge(
//                     // backgroundColor: const Color.fromARGB(255, 0, 0, 0),
//                     animationDuration: BorderSide.strokeAlignCenter,
//                     axes: <RadialAxis>[
//                       RadialAxis(
//                         showLabels: false,
//                         showTicks: false,
//                         minimum: 0,
//                         maximum: 100,
//                         interval: 10,
//                         ranges: <GaugeRange>[
//                           GaugeRange(
//                             startValue: 0,
//                             endValue: max,
//                             color: max <= 40 ? Colors.red : Colors.green,
//                           ),
//                         ],
//                         pointers: [
//                           NeedlePointer(
//                             value: max,
//                             enableAnimation: true,
//                             animationDuration: 1500,
//                             animationType: AnimationType.ease,
//                           )
//                         ],
//                         annotations: <GaugeAnnotation>[
//                           GaugeAnnotation(
//                               widget: Text(
//                             "%${max}",
//                             style: mystyle(20),
//                           ))
//                         ],
//                       )
//                     ],
//                   ))
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget operationSchool() {
//     return Container(
//         margin: EdgeInsets.only(top: 12, bottom: 8),
//         height: MediaQuery.of(context).size.height * 0.44,
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 operation(const Color.fromARGB(255, 37, 37, 37), "الوظائف",
//                     Icons.book),
//                 InkWell(
//                   onTap: () {
//                     Navigator.pushNamed(context, "calc");
//                   },
//                   child: operation(const Color.fromARGB(255, 37, 37, 37),
//                       "حساب العلامة ", Icons.calculate),
//                 )
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 operation(const Color.fromARGB(255, 37, 37, 37), "النتائج",
//                     Icons.add_chart_sharp),
//                 operation(const Color.fromARGB(255, 37, 37, 37), "الحضور",
//                     Icons.connect_without_contact_sharp)
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 operation(const Color.fromARGB(255, 37, 37, 37), "الفصول",
//                     Icons.view_timeline),
//                 operation(const Color.fromARGB(255, 37, 37, 37),
//                     "المعدلات الفصلية", Icons.account_tree)
//               ],
//             ),
//           ],
//         ));
//   }

//   Widget operation(Color color, String text, IconData icony) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.45,
//       margin: EdgeInsets.all(7),
//       height: 95,
//       decoration:
//           BoxDecoration(color: color, borderRadius: BorderRadius.circular(18)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   text,
//                   textDirection: TextDirection.ltr,
//                   style: mystyle(15),
//                 ),
//               )
//             ],
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icony,
//                 color: Colors.white,
//                 size: 32,
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   ArabicTextStyle mystyle(double size) {
//     return ArabicTextStyle(
//         arabicFont: ArabicFont.avenirArabic,
//         color: Colors.white,
//         fontSize: size);
//   }
// }
