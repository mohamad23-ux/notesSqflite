import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:notes/provider/pro.dart';
import 'package:notes/view/HomePage.dart';
import 'package:notes/service/sqdlb.dart';
import 'package:provider/provider.dart';

class editNotes extends StatefulWidget {
  final note;
  final title;
  final id;
  final kind;
  const editNotes({super.key, this.note, this.title, this.id, this.kind});

  @override
  State<editNotes> createState() => _editnotes();
}

class _editnotes extends State<editNotes> {
  sqlDb sqldb = sqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController kind = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    kind.text = widget.kind;
    super.initState();
  }

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
                  ? const Color.fromARGB(255, 247, 247, 244)
                  : Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "تعديل الملاحظة",
            style: ArabicTextStyle(
              arabicFont: ArabicFont.avenirArabic,
              color: context.read<Pro>().mood == true
                  ? const Color.fromARGB(255, 178, 179, 178)
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
                    cursorColor: Colors.white,
                    maxLength: 22,
                    maxLines: 2,
                    style: ArabicTextStyle(
                      color: context.read<Pro>().mood == true
                          ? const Color.fromARGB(255, 195, 195, 195)
                          : Color.fromARGB(255, 53, 53, 53),
                      fontSize: 53,
                      arabicFont: ArabicFont.avenirArabic,
                      // تحديد اللون الأبيض للنص
                    ),
                    controller: title,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "العنوان",
                      hintStyle: ArabicTextStyle(
                        color: context.read<Pro>().mood == true
                            ? const Color.fromARGB(157, 195, 195, 195)
                            : Color.fromARGB(188, 53, 53, 53),
                        arabicFont: ArabicFont.avenirArabic,

                        // تحديد اللون الأبيض للنص
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.50,
                    margin: EdgeInsets.only(
                        left: 12, right: 12, top: 7, bottom: 12),
                    child: TextFormField(
                        cursorColor: Colors.white,
                        style: ArabicTextStyle(
                          arabicFont: ArabicFont.avenirArabic,
                          color: context.read<Pro>().mood == true
                              ? const Color.fromARGB(255, 195, 195, 195)
                              : Color.fromARGB(
                                  211, 77, 76, 76), // تحديد اللون الأبيض للنص
                        ),
                        controller: note,
                        maxLines: 30,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          hintText: "note",
                          hintStyle: ArabicTextStyle(
                            color: const Color.fromARGB(187, 37, 37, 37),
                            arabicFont: ArabicFont.avenirArabic,
                          ),
                        )),
                  ),
                  Container(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 110, right: 110, bottom: 12),
                    child: MaterialButton(
                      textColor: Colors.white,
                      color: const Color.fromARGB(255, 63, 22, 144),
                      onPressed: () async {
                        int response = await sqldb.updateData('''
                          UPDATE notes SET 
                          note =  "${note.text}"  , 
                            title = "${title.text}" , 
                            kind = "${kind.text}" 
                            WHERE id = ${widget.id}  
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
                          "تعديل الملاحظة ",
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
