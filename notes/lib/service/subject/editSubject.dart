import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:notes/view/HomePage.dart';
import 'package:notes/service/sqdlb.dart';
import 'package:notes/view/svu.dart';
import 'package:provider/provider.dart';
import '../../provider/pro.dart';
import '../sqdlb.dart';

class editSubject extends StatefulWidget {
  final title;
  final day;
  final time;
  final id;

  const editSubject({super.key, this.title, this.day, this.time, this.id});

  @override
  State<editSubject> createState() => _editSubject();
}

class _editSubject extends State<editSubject> {
  sqlDb sqldb = sqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController myday = TextEditingController();
  TextEditingController mysubject = TextEditingController();
  TextEditingController mytime = TextEditingController();

  TimeOfDay _timeofDay = TimeOfDay(minute: 30, hour: 8);

  @override
  void initState() {
    mysubject.text = widget.title;
    myday.text = widget.day;
    mytime.text = widget.time;
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
                  MaterialPageRoute(builder: (context) => SVU()),
                  (route) => true);
            }),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "تعديل المادة",
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
                      maxLength: 20,
                      maxLines: 2,
                      style: ArabicTextStyle(
                        color: context.read<Pro>().mood == true
                            ? const Color.fromARGB(255, 248, 255, 219)
                            : Color.fromARGB(255, 13, 13, 13),

                        arabicFont: ArabicFont.avenirArabic,
                        // تحديد اللون الأبيض للنص
                      ),
                      controller: mysubject,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "اسم المادة",
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
                                  color: const Color.fromARGB(255, 255, 0, 0),
                                ),
                                value: context
                                        .read<Pro>()
                                        .days
                                        .contains(myday.text)
                                    ? myday.text
                                    : "السبت", // تحقق من التوافق
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
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (item) => setState(() {
                                  selectedDay = item;
                                  myday.text = item!;
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
                      Container(
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 72, 72, 72),
                        ),
                        child: IconButton(
                            onPressed: _showTimePicker,
                            color: const Color.fromARGB(255, 100, 29, 241),
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            )),
                      ),
                      Text(
                        _timeOfDay.format(context).toString(),
                        style: ArabicTextStyle(
                          arabicFont: ArabicFont.avenirArabic,
                          color: context.read<Pro>().mood == true
                              ? const Color.fromARGB(255, 212, 194, 225)
                              : const Color(0xFF020102),
                          // تحديد اللون الأبيض للنص
                        ),
                      ),
                      Text(
                        ": موعد المحاضرة",
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
                      color: const Color.fromARGB(255, 72, 72, 72),
                      onPressed: () async {
                        if (formstate.currentState!.validate()) {
                          // All fields are valid
                          try {
                            int response = await sqldb.insertData('''
                    UPDATE  subjects SET 
                               day =  "${myday.text}"  , 
                            subject = "${mysubject.text}" , 
                               time = "${mytime.text}"  
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
                                MaterialPageRoute(builder: (context) => SVU()),
                                (route) => false,
                              );
                            }
                          } catch (e) {
                            print("Error: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('حدث خطأ أثناء تعديل المادة')),
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

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: _timeOfDay,
      helpText: "اختر ساعة المحاضرة",
    ).then((value) {
      if (value != null) {
        setState(() {
          _timeOfDay = value!;

          // تحويل الوقت إلى سلسلة نصية بصيغة مناسبة.
          mytime.text = _timeOfDay.format(context);
        });
      }
    });
  }
}
// if (value != null) {
//         setState(() {
//           _timeOfDay = value;

//           // تحويل الوقت إلى سلسلة نصية بصيغة مناسبة.
//           mytime?.text = _timeOfDay.format(context);
//         });
//       }