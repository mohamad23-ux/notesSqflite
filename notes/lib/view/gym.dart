import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/provider/pro.dart';
import 'package:notes/service/gym/editexercise.dart';
import 'package:notes/service/sqdlb.dart';
import 'package:notes/view/caloriesCalc.dart';
import 'package:notes/view/details.dart';
import 'package:notes/view/homePage.dart';
import 'package:provider/provider.dart';

class Gym extends StatefulWidget {
  const Gym({super.key});

  @override
  State<Gym> createState() => _GymState();
}

class _GymState extends State<Gym> {
  sqlDb sqldb = sqlDb();
  bool isLoading = false;

  List generalEx = [];
  List days = [];

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController day = TextEditingController();
  TextEditingController name = TextEditingController();

  Future readGym() async {
    List<Map> response = await sqldb.readSub("SELECT * FROM 'myExercise' ");
    generalEx.addAll(response);

    if (this.mounted) {
      setState(() {
        print("omg:${generalEx}");
      });
    }
  }

  @override
  void initState() {
    readGym();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: context.read<Pro>().mood == true
          ? const Color.fromARGB(255, 12, 12, 12)
          : const Color.fromARGB(255, 212, 194, 225),
      body: SingleChildScrollView(
        child: Column(
          children: [
            myBar(),
            Column(
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => caloriesCalc()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(22),
                    height: MediaQuery.of(context).size.height * 0.18,
                    margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 37, 37, 37),
                        borderRadius: BorderRadius.circular(20)),
                    width: MediaQuery.of(context).size.width * 0.99,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 12),
                              child: Icon(
                                Icons.local_fire_department_rounded,
                                color: Colors.orange,
                                size: 70,
                              ),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => caloriesCalc()));
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    myText(
                                        "السعرات",
                                        33,
                                        const Color.fromARGB(
                                            255, 255, 255, 255)),
                                    myText(
                                        "حاسبة ",
                                        33,
                                        const Color.fromARGB(
                                            255, 252, 252, 252)),
                                  ],
                                ),
                                myText("الحرارية", 25,
                                    const Color.fromARGB(255, 255, 255, 255)),
                                myText(" كم سعرة حرارية تحتاج في يومك؟ ", 15,
                                    const Color.fromARGB(255, 255, 255, 255)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
                              Navigator.pushNamed(context, "addexercise");
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 7, right: 7),
                              padding: EdgeInsets.all(10),
                              width: 45,
                              decoration: BoxDecoration(
                                  color: context.read<Pro>().mood == true
                                      ? const Color.fromARGB(200, 76, 76, 77)
                                      : Color.fromARGB(255, 255, 254, 219),
                                  borderRadius: BorderRadius.circular(18)),
                              child: Icon(
                                Icons.add,
                                weight: 100,
                                color: context.read<Pro>().mood == true
                                    ? Color.fromARGB(255, 245, 244, 207)
                                    : const Color.fromARGB(255, 37, 37, 37),
                              ),
                            ),
                          ),

                          //this button to :
                          //1-Calc Your Degree
                          //2-Whats about your HomeWork

                          InkWell(
                            onTap: () async {
                              int response = await sqlDb()
                                  .deleteAllData(); // استدعاء الدالة بشكل صحيح
                              if (response > 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('تم حذف جميع المهمات بنجاح!')),
                                );
                                setState(() {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Gym()),
                                      (route) => true);
                                });
                                readGym();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('فشل في حذف المهمات.')),
                                );
                                readGym();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              width: 85,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: context.read<Pro>().mood == true
                                      ? const Color.fromARGB(195, 200, 19, 19)
                                      : Color.fromARGB(255, 255, 254, 219),
                                  borderRadius: BorderRadius.circular(18)),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.playlist_remove_rounded,
                                    weight: 100,
                                    color: context.read<Pro>().mood == true
                                        ? Color.fromARGB(255, 245, 244, 207)
                                        : const Color.fromARGB(
                                            255, 246, 24, 24),
                                  ),
                                  Text(
                                    "حذف الكل",
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.avenirArabic,
                                        color: Colors.white,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ),
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
                MySchedule()
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget MySchedule() {
    DateTime now = DateTime.now();
    String dayName = DateFormat('EEEE', 'ar').format(now);
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 20, 19, 20),
          borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.50,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 0.10,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 72, 72, 72),
                      borderRadius: BorderRadius.circular(15)),
                  height: 50,
                  margin: EdgeInsets.all(4),
                  child: Center(
                    child: Text(
                      "التمرين",
                      style: ArabicTextStyle(
                          arabicFont: ArabicFont.avenirArabic,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.23,
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
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width * 0.90,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: generalEx.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    // subjectRow(generalEx[i]['day'],generalEx[i]['subject'],"generalEx[i]['time']"),

                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Details(
                                          name: generalEx[i]['name'],
                                          day: generalEx[i]['day'],
                                          id: generalEx[i]['id'],
                                        )));
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width * 0.50,
                            decoration: BoxDecoration(
                                color: generalEx[i]['day'] == dayName
                                    ? const Color.fromARGB(255, 169, 47, 2)
                                    : Color.fromARGB(199, 254, 254, 255),
                                borderRadius: BorderRadius.circular(15)),
                            height: 50,
                            margin: EdgeInsets.only(
                                left: 2, right: 5, top: 5, bottom: 12),
                            child: Center(
                              child: Text(
                                "${name.text = generalEx[i]['name']}",
                                style: ArabicTextStyle(
                                    arabicFont: ArabicFont.avenirArabic,
                                    color: generalEx[i]['day'] == dayName
                                        ? const Color.fromARGB(
                                            255, 251, 251, 251)
                                        : const Color.fromARGB(255, 37, 37, 37),
                                    fontSize: generalEx[i]['name'].length > 20
                                        ? 15
                                        : 20),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 2, right: 2, top: 5, bottom: 12),
                          width: MediaQuery.of(context).size.width * 0.23,
                          decoration: BoxDecoration(
                              color: generalEx[i]['day'] == dayName
                                  ? const Color.fromARGB(255, 169, 47, 2)
                                  : const Color.fromARGB(207, 255, 255, 255),
                              borderRadius: BorderRadius.circular(15)),
                          height: 50,
                          child: Center(
                            child: Text(
                              "${day.text = generalEx[i]['day']}",
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.avenirArabic,
                                  color: generalEx[i]['day'] == dayName
                                      ? const Color.fromARGB(195, 251, 251, 251)
                                      : const Color.fromARGB(255, 37, 37, 37),
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          iconColor: Colors.white,
                          onSelected: (value) async {
                            if (value == 'delete') {
                              int response = await sqldb.DeleteData(
                                  "DELETE FROM myExercise WHERE id = ${generalEx[i]["id"]}");
                              if (response > 0) {
                                generalEx.removeWhere((element) =>
                                    element['id'] == generalEx[i]['id']);
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Gym()),
                                  );
                                });
                                readGym();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('تم حذف العنصر'),
                                    action: SnackBarAction(
                                      label: 'تراجع',
                                      onPressed: () async {
                                        // عملية التراجع عن الحذف

                                        int response =
                                            await sqldb.insertData('''
                                                   INSERT INTO myExercise (day, name) VALUES  ('${day.text}', '${name.text}')
                                                 ''');
                                        readGym();
                                      },
                                    ),
                                    duration: Duration(
                                        seconds: 5), // مدة ظهور السناك بار
                                  ),
                                );
                                readGym();
                              }
                            } else if (value == 'update') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Editexercise(
                                    name: generalEx[i]['name'],
                                    day: generalEx[i]['day'],
                                    id: generalEx[i]['id'],
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

  Widget myBar() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(22),
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 37, 37, 37),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        width: MediaQuery.of(context).size.width * 0.99,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage()),
                            (route) => true);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment,
              children: [
                Container(
                  child: Text(
                    "الرياضة",
                    style: ArabicTextStyle(
                      fontSize: 30,
                      arabicFont: ArabicFont.avenirArabic,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget myText(String text, double size, Color color) {
    return Text(
      text,
      style: ArabicTextStyle(
        fontSize: size,
        arabicFont: ArabicFont.avenirArabic,
        color: color,
      ),
    );
  }
}
