import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/main.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class Pro extends ChangeNotifier {
  bool _mood = true;
  bool get mood => _mood;

//الجامعة الافتراضية السورية
  String _schoolName = "الجامعة الافتراضية ";
  String get schoolName => _schoolName;

  TextEditingController _season = TextEditingController();
  TextEditingController get Season => _season;

  List<String> _days = [
    "السبت",
    "الأحد",
    "الاثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
  ];

  List<String> get days => _days;

  List<String> _maxthings = [
    "10",
    "15",
    "20",
    "25",
    "30",
    "35",
    "40",
    "45",
    "50",
    "55",
    "60",
    "65",
    "70",
    "75",
    "80",
    "85",
    "90",
    "95",
    "100",
    "105",
    "110",
    "115",
    "120",
    "125",
    "130",
    "135",
    "140",
    "145",
    "150",
    "155",
    "160",
    "165",
    "170",
    "175",
    "180",
    "185",
    "190",
    "195",
    "200",
    "210",
    "220",
    "230",
  ];
  List<String> get maxthings => _maxthings;
  String _SelectDay = "الأحد";
  String get SelectDay => _SelectDay;

  void changeMood() {
    _mood = !_mood;
    notifyListeners();
  }

  List _notesForSearch = [];
  List get notesForSearch => _notesForSearch;

  List<String> _groups = ["1", "2", "3", "4", "5", "6"];
  List<String> get groups => _groups;

  List<String> _subjectName = [];
  List<String> get subjectName => _subjectName;

  // DateTime _thisDay = DateTime.now();
  // DateTime get thisDay => _thisDay;

  Widget thisDay() {
    DateTime now = DateTime.now();
    String dayName = DateFormat('EEEE', 'ar').format(now);
    return Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 72, 72, 72),
            borderRadius: BorderRadius.circular(13)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 251, 251, 255),
                  borderRadius: BorderRadius.circular(60)),
              child: Text(
                "${DateTime.now().day}",
                style: ArabicTextStyle(
                  fontSize: 25,
                  arabicFont: ArabicFont.avenirArabic,
                  color: const Color.fromARGB(223, 22, 21, 36),
                ),
              ),
            ),
            Text(
              "${dayName}",
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.avenirArabic,
                  color: Colors.white,
                  fontSize: 20),
            )
          ],
        ));
  }

  Widget yesterday() {
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));

    // تنسيق التاريخ للحصول على اسم اليوم
    String dayName = DateFormat('EEEE', 'ar').format(yesterday);
    return Container(
        padding: EdgeInsets.all(7),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 72, 72, 72),
            borderRadius: BorderRadius.circular(13)),
        child: Column(
          children: [
            Text(
              "${DateTime.now().day - 1}",
              style: ArabicTextStyle(
                  fontSize: 25,
                  arabicFont: ArabicFont.avenirArabic,
                  color: Colors.white),
            ),
            Text(
              "${dayName}",
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.avenirArabic,
                  color: const Color.fromARGB(255, 211, 222, 219),
                  fontSize: 12),
            )
          ],
        ));
  }

  Widget beforeYesterday() {
    DateTime yesterday = DateTime.now().subtract(Duration(days: 2));
    DateTime now = DateTime.now();

    DateTime firstDayOfCurrentMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfLastMonth =
        firstDayOfCurrentMonth.subtract(Duration(days: 1));
    String lastdayName =
        DateFormat('EEEE', 'ar').format(firstDayOfCurrentMonth);
    String dayName = DateFormat('EEEE', 'ar').format(yesterday);
    return Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 72, 72, 72),
            borderRadius: BorderRadius.circular(13)),
        child: Column(
          children: [
            Text(
              DateTime.now().day - 2 < 1
                  ? "${lastDayOfLastMonth.day}"
                  : "${DateTime.now().day - 2}",
              style: ArabicTextStyle(
                  fontSize: 25,
                  arabicFont: ArabicFont.avenirArabic,
                  color: Colors.white),
            ),
            Text(
              "${dayName}",
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.avenirArabic,
                  color: const Color.fromARGB(255, 211, 222, 219),
                  fontSize: 12),
            )
          ],
        ));
  }

  Widget tomorrow() {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    String dayName = DateFormat('EEEE', 'ar').format(tomorrow);

    return Container(
        padding: EdgeInsets.all(7),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 72, 72, 72),
            borderRadius: BorderRadius.circular(13)),
        child: Column(
          children: [
            Text(
              "${DateTime.now().day + 1}",
              style: ArabicTextStyle(
                  fontSize: 25,
                  arabicFont: ArabicFont.avenirArabic,
                  color: Colors.white),
            ),
            Text(
              "${dayName}",
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.avenirArabic,
                  color: const Color.fromARGB(255, 194, 195, 195),
                  fontSize: 12),
            )
          ],
        ));
  }

  Widget afterTomorrow() {
    DateTime tomorrow = DateTime.now().add(Duration(days: 2));
    String dayName = DateFormat('EEEE', 'ar').format(tomorrow);

    return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 72, 72, 72),
            borderRadius: BorderRadius.circular(13)),
        child: Column(
          children: [
            Text(
              "${DateTime.now().day + 2}",
              style: ArabicTextStyle(
                  fontSize: 25,
                  arabicFont: ArabicFont.avenirArabic,
                  color: Colors.white),
            ),
            Text(
              "${dayName}",
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.avenirArabic,
                  color: const Color.fromARGB(255, 194, 195, 195),
                  fontSize: 12),
            )
          ],
        ));
  }

  Widget SearchBox() {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 72, 72, 72),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(
        bottom: 10,
        right: 10,
        left: 10,
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 12),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            "SEARCH...",
            style: ArabicTextStyle(
                arabicFont: ArabicFont.changa, color: Colors.white),
          )
        ],
      ),
    );
  }
}
