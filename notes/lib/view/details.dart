import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/provider/pro.dart';
import 'package:notes/service/gym/editdetails.dart';
import 'package:notes/service/sqdlb.dart';
import 'package:notes/service/gym/adddeepex.dart';
import 'package:notes/view/gym.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Details extends StatefulWidget {
  final id;
  final name;
  final day;

  const Details({super.key, this.id, this.name, this.day});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  sqlDb sqldb = sqlDb();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController name = TextEditingController();
  TextEditingController groups = TextEditingController();
  TextEditingController max = TextEditingController();
  String? group = "3";
  String? maxWieght = "20";

  String? popularName;
  String? dayName;

  List myGymThings = [];

  Future readGym() async {
    List<Map> response = await sqldb.readSub('''
SELECT   exDetails.name,
            exDetails.id,
          exDetails.groupe,
          exDetails.weight
FROM exDetails
JOIN myExercise ON exDetails.exercise_id = myExercise.id
WHERE myExercise.name = '${widget.name}' AND myExercise.day = '${widget.day}';
''');
    myGymThings.addAll(response);

    if (this.mounted) {
      setState(() {
        print("omg:${myGymThings}");
      });
    }
  }

  @override
  void initState() {
    setState(() {});
    popularName = widget.name;
    dayName = widget.day;
    readGym();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.read<Pro>().mood == true
            ? const Color.fromARGB(255, 23, 23, 23)
            : const Color.fromARGB(255, 212, 194, 225),
        body: SingleChildScrollView(
          child: Column(
            children: [
              myBar(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(12),
                      child: Text(
                        "${popularName}",
                        style: ArabicTextStyle(
                          fontSize: 30,
                          arabicFont: ArabicFont.avenirArabic,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () async {
                              var result = await sqldb.readData('''
    SELECT id FROM myExercise WHERE name = '${popularName}' AND day = '${dayName}';
  ''');
                              if (result.isNotEmpty) {
                                int exerciseId = result[0]
                                    ['id']; // حدد exercise_id من النتيجة

                                // الخطوة الثانية: استخدم exercise_id في تعليمة DELETE على جدول exDetails
                                int response = await sqldb.DeleteSub('''
      DELETE FROM exDetails WHERE exercise_id = $exerciseId;
    ''');

                                // تأكد من استجابة الحذف
                                if (response > 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'تم حذف جميع البيانات بنجاح!')),
                                  );
                                  setState(() {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Details(
                                                  name: widget.name,
                                                  day: widget.day,
                                                )),
                                        (route) => true);
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'لم يتم العثور على أي بيانات لحذفها.')),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'لم يتم العثور على التمرين المطلوب.')),
                                );
                              }
                              //  ; صحيح
                            },
                            child: gymButton("حذف كل التمارين", 17.5)),
                        InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Adddeepex(
                                  id: widget.id,
                                  muscleName: widget.name,
                                  day: widget.day,
                                );
                              }));
                            },
                            child: gymButton("اضافة تمرين جديد", 17.5)),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 12, right: 12),
                      width: screenSize.width > 480
                          ? MediaQuery.of(context).size.width * 0.36
                          : MediaQuery.of(context).size.width * 0.80,
                      height: MediaQuery.of(context).size.height * 0.62,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 72, 72, 72),
                          borderRadius: BorderRadius.circular(22)),
                      child: GridView.builder(
                        itemCount: myGymThings.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: screenSize.width > 480 ? 3 : 2,
                        ),
                        itemBuilder: (context, index) {
                          if (index >= 0 && index < myGymThings.length) {
                            var item = myGymThings[index];
                            print(myGymThings[index]);
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Editdetails(
                                              id: myGymThings[index]['id'],
                                              exName: myGymThings[index]
                                                  ['name'],
                                              exGroupe: myGymThings[index]
                                                  ['groupe'],
                                              maxWieght: myGymThings[index]
                                                  ['wieght'],
                                            )));
                              },
                              onDoubleTap: () async {
                                // الخطوة الثانية: استخدم exercise_id في تعليمة DELETE على جدول exDetails
                                int response = await sqldb.DeleteSub('''
      DELETE FROM exDetails WHERE id = ${item['id']};
    ''');
                                setState(() {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Details(
                                                id: widget.id,
                                                name: widget.name,
                                                day: widget.day,
                                              )),
                                      (route) => true);
                                });

                                // تأكد من استجابة الحذف
                                if (response > 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'تم حذف جميع البيانات بنجاح!')),
                                  );
                                  setState(() {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Details(
                                                  name: widget.name,
                                                  day: widget.day,
                                                )),
                                        (route) => true);
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'لم يتم العثور على أي بيانات لحذفها.')),
                                  );
                                }
                              },
                              child: myContainer(
                                  "${myGymThings[index]['name']}",
                                  myGymThings[index]['weight'].toString(),
                                  myGymThings[index]['groupe'].toString()),
                            );
                          } else {
                            return myContainer("Sorry error", "404", "error");
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget myBar() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(22),
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
                            MaterialPageRoute(builder: (context) => Gym()),
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
                    "${dayName}",
                    textAlign: TextAlign.end,
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
  //this is gymButton

  Widget gymButton(String text, double size) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width > 480
          ? MediaQuery.of(context).size.width * 0.17
          : MediaQuery.of(context).size.width * 0.40,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 56, 56, 56),
          borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(top: 12, left: 6, right: 6),
      child: Center(
        child: Text(
          "${text}",
          style: ArabicTextStyle(
            fontSize: size,
            arabicFont: ArabicFont.avenirArabic,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget myContainer(String ex, String count, String lastweight) {
    return Container(
        margin: EdgeInsets.only(left: 8, right: 1, top: 12),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 14, 14, 15)),
        child: Column(
          children: [
            Flexible(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    ex,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    style: const ArabicTextStyle(
                        arabicFont: ArabicFont.avenirArabic,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Text(
                      lastweight,
                      style: const ArabicTextStyle(
                          arabicFont: ArabicFont.avenirArabic,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Text(
                      "المجموعات",
                      style: const ArabicTextStyle(
                          arabicFont: ArabicFont.avenirArabic,
                          color: Colors.white,
                          fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 12, left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 12),
                      child: Text(
                        "${count} KG",
                        style: const ArabicTextStyle(
                            arabicFont: ArabicFont.avenirArabic,
                            color: Colors.white,
                            fontSize: 17),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 12),
                      child: Text(
                        ":اخر وزن  ",
                        style: const ArabicTextStyle(
                            arabicFont: ArabicFont.avenirArabic,
                            color: Colors.white,
                            fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
