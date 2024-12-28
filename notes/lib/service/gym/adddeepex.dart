import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/provider/pro.dart';
import 'package:notes/service/sqdlb.dart';
import 'package:notes/view/details.dart';
import 'package:provider/provider.dart';

class Adddeepex extends StatefulWidget {
  final id;
  final muscleName;
  final day;
  const Adddeepex({super.key, this.id, this.muscleName, this.day});

  @override
  State<Adddeepex> createState() => _AdddeepexState();
}

class _AdddeepexState extends State<Adddeepex> {
  sqlDb sqldb = sqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController groups = TextEditingController();
  TextEditingController max = TextEditingController();

  String? group = "1";
  String? maxWeight = "20";
  List myGymThings = [];

  Future readGym() async {
    List<Map> response = await sqldb.readSub("SELECT * FROM 'myExercise' ");
    myGymThings.addAll(response);

    if (this.mounted) {
      setState(() {
        print("omg:${myGymThings}");
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
                  MaterialPageRoute(
                      builder: (context) => Details(
                            id: widget.id,
                            name: widget.muscleName,
                            day: widget.day,
                          )),
                  (route) => true);
            }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.self_improvement_outlined,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "تمرين فرعي جديد",
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
        height: MediaQuery.of(context).size.height * 0.75,
        child: SingleChildScrollView(
            child: Form(
                key: formstate,
                child: Column(
                  children: [
                    gymButton("اسم التمرين", 22),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: TextFormField(
                        controller: name,
                        textDirection: TextDirection.rtl,
                        style: ArabicTextStyle(
                            color: Colors.white,
                            arabicFont: ArabicFont.avenirArabic),
                        decoration: InputDecoration(),
                      ),
                    ),
                    gymButton("كم مجموعة", 22),
                    Container(
                        color: const Color.fromARGB(255, 28, 27, 27),
                        margin: EdgeInsets.all(12),
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: const Color(0xFF020102),
                                menuWidth: double.infinity,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 255, 0, 0)),
                                value: group,
                                items: context
                                    .read<Pro>()
                                    .groups
                                    .map((group) => DropdownMenuItem(
                                        value: group,
                                        child: Center(
                                            child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "مجموعات:  ",
                                                style: ArabicTextStyle(
                                                  arabicFont:
                                                      ArabicFont.avenirArabic,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "${group}   ",
                                                style: ArabicTextStyle(
                                                  arabicFont:
                                                      ArabicFont.avenirArabic,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))))
                                    .toList(),
                                onChanged: (item) => setState(() {
                                  group = item;

                                  groups.text = item!;
                                }),
                              ),
                            ))),
                    gymButton("أعلى وزن", 22),
                    Container(
                        color: const Color.fromARGB(255, 28, 27, 27),
                        margin: EdgeInsets.all(12),
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: const Color(0xFF020102),
                                menuWidth: double.infinity,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 255, 0, 0)),
                                value: context
                                        .read<Pro>()
                                        .maxthings
                                        .contains(max.text)
                                    ? max.text
                                    : "15",
                                items: context
                                    .read<Pro>()
                                    .maxthings
                                    .map((maxy) => DropdownMenuItem(
                                        value: maxy,
                                        child: Center(
                                          child: Text(
                                            "${maxy}     KG",
                                            style: ArabicTextStyle(
                                              arabicFont:
                                                  ArabicFont.avenirArabic,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (item) => setState(() {
                                  maxWeight = item;

                                  max.text = item!;
                                }),
                              ),
                            ))),
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
                              // تأكد من تضمين exercise_id المناسب في الإدخال
                              int response = await sqldb.insertData('''
            INSERT INTO exDetails (exercise_id, name, groupe, weight) 
            VALUES ('${widget.id}', '${name.text}', '${groups.text}', '${max.text}')
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
                                  MaterialPageRoute(
                                    builder: (context) => Details(
                                      id: widget.id,
                                      name: widget.muscleName,
                                      day: widget.day,
                                    ),
                                  ),
                                  (route) => true,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('فشل في إضافة التمرين')),
                                );
                              }
                            } catch (e) {
                              print("Error: $e");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'حدث خطأ أثناء إضافة التمرين: $e')),
                              );
                            }
                          } else {
                            // رسالة التحقق ستظهر هنا ولن يتم الانتقال للصفحة الأخرى
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 120),
                                content: Text('يرجى ملء جميع الحقول المطلوبة'),
                              ),
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
                ))),
      ),
    );
  }

  Widget gymButton(String text, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.40,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(top: 12),
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
        ),
      ],
    );
  }
}
