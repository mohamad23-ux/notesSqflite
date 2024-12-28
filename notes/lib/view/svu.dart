import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/provider/colors.dart';
import 'package:notes/provider/pro.dart';
import 'package:notes/service/subject/editSubject.dart';
import 'package:notes/service/sqdlb.dart';
import 'package:notes/view/HomePage.dart';
import 'package:provider/provider.dart';

class SVU extends StatefulWidget {
  const SVU({super.key});

  @override
  State<SVU> createState() => _SVUState();
}

class _SVUState extends State<SVU> {
  sqlDb sqldb = sqlDb();
  bool isLoading = false;

  List subjects = [];
  List days = [];
  GlobalKey<FormState> seasonKey = GlobalKey();
  TextEditingController seasonController = TextEditingController();
  String season = " ";

  Future readSub() async {
    List<Map> response = await sqldb.readSub("SELECT * FROM 'subjects' ");
    subjects.addAll(response);

    if (this.mounted) {
      setState(() {
        print("omg:${subjects}");
      });
    }
  }

  @override
  void initState() {
    readSub();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.read<Pro>().mood == true
            ? const Color.fromARGB(255, 41, 39, 41)
            : const Color.fromARGB(255, 212, 194, 225),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: myBar(),
              ),
              allSchedule(),
            ],
          ),
        ),
      ),
    );
  }
//BAR//////////////////////////////////////////////////////للاشف

//BAR
  Widget myBar() {
    return Container(
      padding: EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.99,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 72, 72, 72),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    season = seasonController.text;
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Homepage()),
                        (route) => true);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  )),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                child: Text("${context.read<Pro>().schoolName}",
                    textAlign: TextAlign.center,
                    style: ArabicTextStyle(
                        arabicFont: ArabicFont.avenirArabic,
                        color: context.read<Pro>().mood == true
                            ? Color(0xFFF9F7C9)
                            : const Color.fromARGB(255, 193, 169, 241),
                        fontSize: 20)),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget allSchedule() {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                context.read<Pro>().beforeYesterday(),
                context.read<Pro>().yesterday(),
                context.read<Pro>().thisDay(),
                context.read<Pro>().tomorrow(),
                context.read<Pro>().afterTomorrow(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "addSubject");
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 7, right: 7),
                        padding: EdgeInsets.all(10),
                        width: 45,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 72, 72, 72),
                            borderRadius: BorderRadius.circular(18)),
                        child: Icon(
                          Icons.add,
                          weight: 100,
                          color: context.read<Pro>().mood == true
                              ? Color.fromARGB(255, 245, 244, 207)
                              : const Color.fromARGB(255, 100, 29, 241),
                        ),
                      ),
                    ),

                    //this button to :
                    //1-Calc Your Degree
                    //2-Whats about your HomeWork

                    // InkWell(
                    //   onTap: () {
                    //     Navigator.pushNamed(context, "extraSubject");
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.all(10),
                    //     width: 45,
                    //     decoration: BoxDecoration(
                    //         color: const Color.fromARGB(255, 72, 72, 72),
                    //         borderRadius: BorderRadius.circular(18)),
                    //     child: Icon(
                    //       Icons.candlestick_chart_rounded,
                    //       weight: 100,
                    //       color: context.read<Pro>().mood == true
                    //           ? Color.fromARGB(255, 245, 244, 207)
                    //           : const Color.fromARGB(255, 100, 29, 241),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Text(
                  "برنامج الأسبوع",
                  style: ArabicTextStyle(
                      arabicFont: ArabicFont.avenirArabic,
                      color: context.read<Pro>().mood == true
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 46, 46, 47),
                      fontSize: 29),
                ),
              ],
            ),
          ),
          MySchedule(),
        ],
      ),
    );
  }

  Widget MySchedule() {
    DateTime now = DateTime.now();
    String dayName = DateFormat('EEEE', 'ar').format(now);
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 20, 19, 20),
          borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.60,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 0.13,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 72, 72, 72),
                      borderRadius: BorderRadius.circular(15)),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.21,
                  margin:
                      EdgeInsets.only(left: 13, right: 6, top: 6, bottom: 6),
                  child: Center(
                    child: Text(
                      "الوقت ",
                      style: ArabicTextStyle(
                          arabicFont: ArabicFont.avenirArabic,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.29,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 72, 72, 72),
                      borderRadius: BorderRadius.circular(15)),
                  height: 50,
                  margin: EdgeInsets.all(4),
                  child: Center(
                    child: Text(
                      "المادة ",
                      style: ArabicTextStyle(
                          arabicFont: ArabicFont.avenirArabic,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.18,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 72, 72, 72),
                      borderRadius: BorderRadius.circular(15)),
                  height: 50,
                  margin: EdgeInsets.all(4),
                  child: Center(
                    child: Text(
                      "اليوم ",
                      style: ArabicTextStyle(
                          arabicFont: ArabicFont.avenirArabic,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width * 0.90,
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    // subjectRow(subjects[i]['day'],subjects[i]['subject'],"subjects[i]['time']"),

                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: subjects[i]['day'] == dayName
                                  ? const Color.fromARGB(255, 169, 47, 2)
                                  : const Color.fromARGB(193, 255, 255, 255),
                              borderRadius: BorderRadius.circular(15)),
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.20,
                          margin: EdgeInsets.all(12),
                          child: Center(
                            child: Text(
                              "${subjects[i]['time']}",
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.avenirArabic,
                                  color: subjects[i]['day'] == dayName
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : const Color.fromARGB(207, 0, 0, 0),
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width * 0.30,
                          decoration: BoxDecoration(
                              color: subjects[i]['day'] == dayName
                                  ? const Color.fromARGB(255, 169, 47, 2)
                                  : Color.fromARGB(199, 254, 254, 255),
                              borderRadius: BorderRadius.circular(15)),
                          height: 50,
                          margin: EdgeInsets.all(4),
                          child: Center(
                            child: Text(
                              "${subjects[i]['subject']}",
                              style: ArabicTextStyle(
                                  color: subjects[i]['day'] == dayName
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : const Color.fromARGB(207, 0, 0, 0),
                                  arabicFont: ArabicFont.avenirArabic,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.18,
                          decoration: BoxDecoration(
                              color: subjects[i]['day'] == dayName
                                  ? const Color.fromARGB(255, 169, 47, 2)
                                  : const Color.fromARGB(207, 255, 255, 255),
                              borderRadius: BorderRadius.circular(15)),
                          height: 50,
                          margin: EdgeInsets.only(
                            left: 1,
                          ),
                          child: Center(
                            child: Text(
                              "${subjects[i]['day']}",
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.avenirArabic,
                                  color: subjects[i]['day'] == dayName
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : const Color.fromARGB(207, 0, 0, 0),
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          iconColor: Colors.white,
                          onSelected: (value) async {
                            if (value == 'delete') {
                              int response = await sqldb.DeleteData(
                                  "DELETE FROM subjects WHERE id = ${subjects[i]["id"]}");
                              if (response > 0) {
                                subjects.removeWhere((element) =>
                                    element['id'] == subjects[i]['id']);
                                setState(() {});
                              }
                            } else if (value == 'update') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => editSubject(
                                    title: subjects[i]['subject'],
                                    day: subjects[i]['day'],
                                    time: subjects[i]['time'],
                                    id: subjects[i]['id'],
                                  ),
                                ),
                              );
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  SizedBox(width: 8),
                                  Text('Delete'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'update',
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(width: 8),
                                  Text('Update'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget subjectRow(String day, String title, String time) {
  //   return ;
  // }
}
