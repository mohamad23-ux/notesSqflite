import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/provider/pro.dart';
import 'package:notes/service/subject/extrasubject.dart';
import 'package:provider/provider.dart';

class calc extends StatefulWidget {
  const calc({super.key});

  @override
  State<calc> createState() => _calcState();
}

class _calcState extends State<calc> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController homeWorkDegree = TextEditingController();
  TextEditingController finalDegree = TextEditingController();
  bool? ok;
  double? subjectDegree = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.read<Pro>().mood == true
          ? const Color.fromARGB(255, 12, 12, 12)
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
              Navigator.pop(context);
            }),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "حساب العلامة النهائية",
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
          child: Column(
        children: [
          Container(
              child: Form(
                  key: formstate,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: TextFormField(
                                keyboardType: TextInputType.numberWithOptions(),
                                maxLength: 5,
                                controller: homeWorkDegree,
                                textDirection: TextDirection.rtl,
                                style: mystyle(22),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                }),
                          ),
                          Text(
                            "علامة الوظيفة",
                            style: mystyle(22),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 33,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: TextFormField(
                                keyboardType: TextInputType.numberWithOptions(),
                                maxLength: 5,
                                controller: finalDegree,
                                textDirection: TextDirection.rtl,
                                style: mystyle(22),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  }

                                  return null;
                                }),
                          ),
                          Text(
                            "علامة الامتحان",
                            style: mystyle(22),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              if (homeWorkDegree.text != null ||
                                  finalDegree.text != null) {
                                subjectDegree =
                                    double.tryParse(homeWorkDegree.text)! *
                                            0.3 +
                                        double.tryParse(finalDegree.text)! *
                                            0.7;
                                ok = true;
                              } else {
                                if (homeWorkDegree.text == null ||
                                    finalDegree.text == null) {
                                  subjectDegree = 0;
                                  ok = false;
                                  return;
                                }
                              }
                            });
                          },
                          color: const Color.fromARGB(255, 72, 72, 72),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "حساب العلامة النهائية",
                              style: mystyle(22),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: ok == false
                            ? Text(
                                "يرجى تعبئة كل الحقول",
                                style: mystyle(25),
                              )
                            : Text(
                                "${subjectDegree}",
                                style: mystyle(25),
                              ),
                      )
                    ],
                  ))),
        ],
      )),
    );
  }

  ArabicTextStyle mystyle(double size) {
    return ArabicTextStyle(
        arabicFont: ArabicFont.avenirArabic,
        color: Colors.white,
        fontSize: size);
  }
}
