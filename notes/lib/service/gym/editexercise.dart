import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:notes/view/HomePage.dart';
import 'package:notes/service/sqdlb.dart';
import 'package:notes/view/gym.dart';
import 'package:notes/view/svu.dart';
import 'package:provider/provider.dart';
import '../../provider/pro.dart';
import '../sqdlb.dart';

class Editexercise extends StatefulWidget {
  final name;
  final day;

  final id;

  const Editexercise({super.key, this.name, this.day, this.id});

  @override
  State<Editexercise> createState() => _Editexercise();
}

class _Editexercise extends State<Editexercise> {
  sqlDb sqldb = sqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController myday = TextEditingController();
  TextEditingController myname = TextEditingController();

  @override
  void initState() {
    myday.text = widget.day;
    myname.text = widget.name;

    super.initState();
  }

  String? selectedDay = "الأحد";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.read<Pro>().mood == true
          ? const Color(0xFF020102)
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
            "تعديل التمرين",
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
                      controller: myname,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "التمرين",
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: ArabicTextStyle(
                          color: context.read<Pro>().mood == true
                              ? const Color.fromARGB(135, 255, 255, 255)
                              : Color.fromARGB(162, 45, 45, 45),
                          arabicFont: ArabicFont.avenirArabic,

                          // تحديد اللون الأبيض للنص
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'هذا الحقل مطلوب ';
                        }
                        return null;
                      }),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Divider(
                      color: const Color.fromARGB(54, 0, 150, 135),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          color: const Color.fromARGB(255, 28, 27, 27),
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
                                value: context.read<Pro>().days[0],
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

                                  myday.text = item!;
                                }),
                              ))),
                      Container(
                        child: Text(
                          ":تعديل يوم ",
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
                      Container(
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 100, 29, 241),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
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
                      Text(
                        "تعديل تفاصيل التمرين",
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
                            int response = await sqldb.updateData('''
                    UPDATE  myExercise SET 
                               day =  "${myday.text}"  , 
                           name = "${myname.text}" 
                              
                               WHERE id = ${widget.id} 
                      ''');

                            if (response > 0) {
                              // الانتقال فقط بعد النجاح في الإدخال

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text('تمت تعديل المادة بنجاح')),
                              );
                              // الانتقال فقط بعد النجاح في الإدخال
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => Gym()),
                                (route) => false,
                              );
                            }
                          } catch (e) {
                            print("Error: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      ' + ${e}حدث خطأ أثناء تعديل المادة')),
                            );
                          }
                        } else {
                          // رسالة التحقق ستظهر هنا ولن يتم الانتقال للصفحة الأخرى
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('يرجى ملء جميع الحقول المطلوبة')),
                          );
                        }
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "تعديل مادة",
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

  TimeOfDay _timeOfDay = TimeOfDay.now();
}
// if (value != null) {
//         setState(() {
//           _timeOfDay = value;

//           // تحويل الوقت إلى سلسلة نصية بصيغة مناسبة.
//           mytime?.text = _timeOfDay.format(context);
//         });
//       }