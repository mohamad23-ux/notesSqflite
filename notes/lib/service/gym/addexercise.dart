import 'dart:ffi';

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/provider/pro.dart';
import 'package:notes/service/sqdlb.dart';
import 'package:notes/view/details.dart';
import 'package:notes/view/gym.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class addExercise extends StatefulWidget {
  const addExercise({super.key});

  @override
  State<addExercise> createState() => _addExerciseState();
}

class _addExerciseState extends State<addExercise> {
  sqlDb sqldb = sqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController day = TextEditingController();
  TextEditingController name = TextEditingController();

  TimeOfDay _timeofDay = TimeOfDay(hour: 8, minute: 30);
  String? selectedDay = "الأحد";
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.sports_gymnastics_outlined,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "تمرين جديد",
                style: ArabicTextStyle(
                  arabicFont: ArabicFont.avenirArabic,
                  color: context.read<Pro>().mood == true
                      ? const Color.fromARGB(255, 228, 231, 228)
                      : Color(0xFFF9F7C9),

                  // تحديد اللون الأبيض للنص
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50, right: 12),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                      maxLength: 25,
                      maxLines: 2,
                      style: ArabicTextStyle(
                        color: context.read<Pro>().mood == true
                            ? const Color.fromARGB(255, 248, 255, 219)
                            : Color.fromARGB(255, 13, 13, 13),

                        arabicFont: ArabicFont.avenirArabic,
                        // تحديد اللون الأبيض للنص
                      ),
                      controller: name,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "عضلات اليوم ",
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: ArabicTextStyle(
                          color: context.read<Pro>().mood == true
                              ? const Color.fromARGB(136, 246, 248, 244)
                              : Color.fromARGB(162, 45, 45, 45),
                          arabicFont: ArabicFont.avenirArabic,

                          // تحديد اللون الأبيض للنص
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      }),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Divider(
                      color: const Color.fromARGB(54, 0, 150, 135),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          color: const Color.fromARGB(255, 37, 37, 37),
                          margin: EdgeInsets.all(12),
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: DropdownButton<String>(
                                dropdownColor: const Color(0xFF020102),
                                menuWidth: double.infinity,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 255, 0, 0)),
                                value: selectedDay,
                                items: context
                                    .read<Pro>()
                                    .days
                                    .map((day) => DropdownMenuItem(
                                        value: day,
                                        child: Center(
                                          child: Text(
                                            day,
                                            style: ArabicTextStyle(
                                              arabicFont:
                                                  ArabicFont.avenirArabic,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (item) => setState(() {
                                  selectedDay = item;

                                  day.text = item!;
                                }),
                              ))),
                      Container(
                        child: Text(
                          ":اختر يوم ",
                          style: ArabicTextStyle(
                              arabicFont: ArabicFont.avenirArabic,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Divider(
                      color: const Color.fromARGB(54, 0, 150, 135),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(
                                        name: name.text,
                                        day: day.text,
                                      )));
                        },
                        child: Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromARGB(255, 100, 29, 241),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      MaterialPageRoute(
                                          builder: (context) => Details(
                                                name: name.text,
                                                day: day.text,
                                              ));
                                    },
                                    color:
                                        const Color.fromARGB(255, 100, 29, 241),
                                    icon: Icon(
                                      Icons.fitness_center,
                                      color: const Color.fromARGB(
                                          251, 255, 254, 254),
                                      size: 20,
                                    )),
                                Text(
                                  "التفاصيل",
                                  style: ArabicTextStyle(
                                      arabicFont: ArabicFont.avenirArabic,
                                      color: Colors.white),
                                )
                              ],
                            )),
                      ),
                      Text(
                        "(اختياري): اضف التفاصيل الى تمرينك",
                        style: ArabicTextStyle(
                          arabicFont: ArabicFont.avenirArabic,
                          color: context.read<Pro>().mood == true
                              ? const Color.fromARGB(255, 212, 194, 225)
                              : const Color(0xFF020102),
                          // تحديد اللون الأبيض للنص
                        ),
                      ),
                    ],
                  )),
                  Container(
                    margin: EdgeInsets.only(
                        left: 110, right: 110, bottom: 20, top: 20),
                    child: MaterialButton(
                      textColor: Colors.white,
                      color: const Color.fromARGB(255, 100, 29, 241),
                      onPressed: () async {
                        if (formstate.currentState!.validate()) {
                          // All fields are valid
                          try {
                            int response = await sqldb.insertData('''
        INSERT INTO myExercise (day, name) VALUES  ('${day.text}', '${name.text}')
      ''');
                            print("${response}");

                            if (response > 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('تمت إضافة التمرين بنجاح')),
                              );
                              // الانتقال فقط بعد النجاح في الإدخال
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => Gym()),
                                (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('فشل في إضافة المادة')),
                              );
                            }
                          } catch (e) {
                            print("Error: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('+${e}حدث خطأ أثناء إضافة المادة')),
                            );
                          }
                        } else {
                          // رسالة التحقق ستظهر هنا ولن يتم الانتقال للصفحة الأخرى
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                duration: Duration(seconds: 120),
                                content: Text('يرجى ملء جميع الحقول المطلوبة')),
                          );
                        }
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "اضافة تمرين",
                          style: ArabicTextStyle(
                            arabicFont: ArabicFont.avenirArabic,
                            color: Colors.white,

                            // تحديد اللون الأبيض للنص
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
