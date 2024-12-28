import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:notes/view/HomePage.dart';
import 'package:notes/service/sqdlb.dart';
import 'package:provider/provider.dart';
import '../../provider/pro.dart';
import '../sqdlb.dart';

class addNotes extends StatefulWidget {
  const addNotes({super.key});

  @override
  State<addNotes> createState() => _addNotesState();
}

class _addNotesState extends State<addNotes> {
  sqlDb sqldb = sqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController kind = TextEditingController();
  TextEditingController note = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 98, 46, 204),
      appBar: AppBar(
        backgroundColor: const Color(0xFF020102),
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
            "اضافة ملاحظة جديدة",
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
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 22,
                    maxLines: 2,
                    style: ArabicTextStyle(
                      color: context.read<Pro>().mood == true
                          ? const Color.fromARGB(255, 248, 255, 219)
                          : Color.fromARGB(255, 13, 13, 13),
                      fontSize: 53,
                      arabicFont: ArabicFont.avenirArabic,
                      // تحديد اللون الأبيض للنص
                    ),
                    controller: title,
                    textDirection: TextDirection.rtl,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      border: InputBorder.none,
                      hintText: "العنوان",
                      hintStyle: ArabicTextStyle(
                        color: context.read<Pro>().mood == true
                            ? const Color.fromARGB(111, 246, 248, 244)
                            : Color.fromARGB(162, 45, 45, 45),
                        arabicFont: ArabicFont.avenirArabic,

                        // تحديد اللون الأبيض للنص
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.50,
                      margin: EdgeInsets.all(12),
                      child: TextFormField(
                          style: ArabicTextStyle(
                            arabicFont: ArabicFont.avenirArabic,
                            color: context.read<Pro>().mood == true
                                ? const Color.fromARGB(255, 195, 195, 195)
                                : Color.fromARGB(
                                    255, 53, 53, 53), // تحديد اللون الأبيض للنص
                          ),
                          controller: note,
                          maxLines: 30,  cursorColor: Colors.white,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            hintText: "الملاحظات",
                            hintTextDirection: TextDirection.rtl,
                            border: InputBorder.none,
                            hintStyle: ArabicTextStyle(
                              color: context.read<Pro>().mood == true
                                  ? const Color.fromARGB(111, 246, 248, 244)
                                  : Color.fromARGB(100, 40, 40, 40),
                              arabicFont: ArabicFont.avenirArabic,
                            ),
                          ))),
                  Container(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 110, right: 110, bottom: 50),
                    child: MaterialButton(
                      textColor: Colors.white,
                      color: const Color.fromARGB(255, 80, 45, 151),
                      onPressed: () async {
                        int response = await sqldb.insertData('''
                    INSERT INTO notes (note, title, kind) VALUES ('${note.text}', '${title.text}', '${kind.text}')
                      ''');

                        print("response====================================");
                        print(response);
                        if (response > 0) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage()),
                              (route) => true);
                        }
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "اضافة ملاحظة جديدة",
                          style: ArabicTextStyle(
                            arabicFont: ArabicFont.avenirArabic,
                            color: context.read<Pro>().mood == true
                                ? const Color.fromARGB(255, 212, 194, 225)
                                : const Color(0xFF020102),

                            // تحديد اللون الأبيض للنص
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
