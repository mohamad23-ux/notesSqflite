import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/provider/caloriesProvider.dart';
import 'package:notes/provider/pro.dart';
import 'package:notes/view/gym.dart';
import 'package:provider/provider.dart';

class caloriesCalc extends StatefulWidget {
  const caloriesCalc({super.key});

  @override
  State<caloriesCalc> createState() => _caloriesCalcState();
}

class _caloriesCalcState extends State<caloriesCalc> {
  String? selectGender = "ذكر";
  String? selectWeight = "30";
  String? selectTall = "160";
  double? selectAge = 20;
  String? changeColor = "ذكر";
  int? fullCalories;
  double count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.read<Pro>().mood == true
            ? const Color.fromARGB(255, 23, 23, 23)
            : const Color.fromARGB(255, 212, 194, 225),
        appBar: AppBar(
          backgroundColor: context.read<Pro>().mood == true
              ? const Color.fromARGB(255, 27, 27, 27)
              : Color.fromARGB(255, 53, 53, 53),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: context.read<Pro>().mood == true
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Gym()),
                    (route) => true);
              }),
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "كم سعرة تحتاج اليوم؟",
              style: ArabicTextStyle(
                arabicFont: ArabicFont.avenirArabic,
                color: context.read<Pro>().mood == true
                    ? const Color.fromARGB(255, 228, 231, 228)
                    : Color(0xFFF9F7C9),

                // تحديد اللون الأبيض للنص
              ),
            ),
          ),
        ),
        body: Container(
            child: Column(children: [
          Container(
            margin: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 26),
                        child: Row(
                          children: [
                            Icon(
                              Icons.man_outlined,
                              size: changeColor == "ذكر" ? 40 : 22,
                              color: changeColor == "ذكر"
                                  ? Color.fromARGB(255, 26, 73, 243)
                                  : Colors.white,
                            ),
                            Icon(
                              Icons.woman,
                              size: changeColor == "انثى" ? 40 : 22,
                              color: changeColor == "انثى"
                                  ? Color.fromARGB(255, 26, 73, 243)
                                  : Colors.white,
                            ),
                          ],
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: const Color(0xFF020102),
                          menuWidth: double.infinity,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 74, 3, 216)),
                          value: selectGender,
                          items: context
                              .read<Caloriesprovider>()
                              .gender
                              .map((gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Center(
                                      child: Center(
                                    child: Text(
                                      "${gender}   ",
                                      style: ArabicTextStyle(
                                        arabicFont: ArabicFont.avenirArabic,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ))))
                              .toList(),
                          onChanged: (item) => setState(() {
                            changeColor = item;
                            selectGender = item.toString();

                            // groups.text = item!;
                          }),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.20,
                      ),
                      Text(
                        "اختر جنسك",
                        style: ArabicTextStyle(
                          arabicFont: ArabicFont.avenirArabic,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: const Color(0xFF020102),
                          menuWidth: double.infinity,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 74, 3, 216)),
                          value: selectWeight,
                          items: context
                              .read<Caloriesprovider>()
                              .weights
                              .map((weight) => DropdownMenuItem(
                                  value: weight,
                                  child: Center(
                                      child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "KG  ",
                                          style: ArabicTextStyle(
                                            arabicFont: ArabicFont.avenirArabic,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "${weight}   ",
                                          style: ArabicTextStyle(
                                            arabicFont: ArabicFont.avenirArabic,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))))
                              .toList(),
                          onChanged: (item) => setState(() {
                            selectWeight = item!;

                            // groups.text = item!;
                          }),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.20,
                      ),
                      Text(
                        "اختر وزنك",
                        style: ArabicTextStyle(
                          arabicFont: ArabicFont.avenirArabic,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: const Color(0xFF020102),
                          menuWidth: double.infinity,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 74, 3, 216)),
                          value: selectTall,
                          items: context
                              .read<Caloriesprovider>()
                              .tall
                              .map((group) => DropdownMenuItem(
                                  value: group,
                                  child: Center(
                                      child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "CM ",
                                          style: ArabicTextStyle(
                                            arabicFont: ArabicFont.avenirArabic,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "${group}   ",
                                          style: ArabicTextStyle(
                                            arabicFont: ArabicFont.avenirArabic,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))))
                              .toList(),
                          onChanged: (item) => setState(() {
                            selectTall = item!;

                            // groups.text = item!;
                          }),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.20,
                      ),
                      const Text(
                        "اختر طولك",
                        style: ArabicTextStyle(
                          arabicFont: ArabicFont.avenirArabic,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton<double>(
                          dropdownColor: const Color(0xFF020102),
                          menuWidth: double.infinity,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 74, 3, 216)),
                          value: selectAge,
                          items: context
                              .read<Caloriesprovider>()
                              .age
                              .map((group) => DropdownMenuItem(
                                  value: group,
                                  child: Center(
                                      child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${group.toStringAsFixed(0)}   ",
                                          style: ArabicTextStyle(
                                            arabicFont: ArabicFont.avenirArabic,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))))
                              .toList(),
                          onChanged: (item) => setState(() {
                            selectAge = item!;

                            // groups.text = item!;
                          }),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.20,
                      ),
                      const Text(
                        "اختر عمرك",
                        style: ArabicTextStyle(
                          arabicFont: ArabicFont.avenirArabic,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  if (selectAge == null ||
                      selectGender == null ||
                      selectTall == null ||
                      selectWeight == null) {
                    count = 88.362 + (13.397 * 0) + (4.799 * 0) * (5.677 * 0);
                  } else {
                    count = 88.362 +
                        (13.397 * double.parse(selectWeight!)) +
                        (4.799 * double.parse(selectTall!)) -
                        (5.677 * selectAge!);
                  }
                });
              },
              color: const Color.fromARGB(255, 22, 71, 248),
              child: Text(
                "احسب الأن ",
                style: ArabicTextStyle(
                  arabicFont: ArabicFont.avenirArabic,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Center(
            child: Text(
              "السعرات التي تحتاجها ",
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.avenirArabic,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 4, right: 4, left: 4),
              height: MediaQuery.of(context).size.height * 0.22,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.keyboard_double_arrow_down,
                        color: const Color.fromARGB(255, 54, 244, 76),
                        size: 40,
                      ),
                      caloriesDetails(
                          "لتخفيف الوزن ",
                          count - 500 < 0
                              ? "${0}"
                              : "${(count - 500).toStringAsFixed(0)}"),
                    ],
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.straighten_rounded,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        size: 40,
                      ),
                      caloriesDetails(
                          "لوزن ثابت ", "${count.toStringAsFixed(0)}"),
                    ],
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.keyboard_double_arrow_up_outlined,
                        color: Colors.red,
                        size: 40,
                      ),
                      caloriesDetails(
                          "لزيادة الوزن ",
                          count + 500 < 0
                              ? "${0}"
                              : count == 0
                                  ? "0"
                                  : "${(count + 500).toStringAsFixed(0)}"),
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  )
                ],
              ),
            ),
          )
        ])));
  }

  Widget caloriesDetails(String text, String count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${text}",
          textAlign: TextAlign.center,
          style: ArabicTextStyle(
              arabicFont: ArabicFont.avenirArabic,
              fontSize: 20,
              color: Colors.white),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          "${count}",
          style: ArabicTextStyle(
              arabicFont: ArabicFont.avenirArabic,
              fontSize: 30,
              color: Colors.white),
        ),
      ],
    );
  }
}
