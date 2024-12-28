import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/main.dart';
import 'package:notes/provider/pro.dart';
import 'package:notes/service/notes/editnotes.dart';
import 'package:notes/view/gym.dart';
import 'package:notes/view/specialRoute.dart';
import 'package:notes/view/svu.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../service/sqdlb.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  sqlDb sqldb = sqlDb();
  bool isLoading = false;

  List notes = [];
  List titles = [];

  Future readData() async {
    List<Map> response = await sqldb.readData("SELECT * FROM 'notes' ");
    notes.addAll(response);
    context.read<Pro>().notesForSearch.addAll(response);
    if (this.mounted) {
      setState(() {
        print("omg:${notes}");
      });
    }
  }

  @override
  void initState() {
    readData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isClicked = false;
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.read<Pro>().mood == true
            ? const Color.fromARGB(255, 41, 39, 41)
            : const Color.fromARGB(255, 212, 194, 225),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(12),
          child: FloatingActionButton(
            elevation: 15,
            heroTag: 'uniqueTag',
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.pushNamed(context, "addnotes");
            },
            child: Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xFF8956F2)),
              child: const Icon(
                Icons.add,
                weight: 20,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            backgroundColor: const Color(0xFF8956F1),
          ),
        ),
        body: isLoading == true
            ? const Center(
                child: Text(
                  "LOADing....",
                  style: TextStyle(fontSize: 200),
                ),
              )
            : Container(
                child: Column(
                  children: [
                    Container(
                      // margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [myBar()],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12, right: 3, top: 8),
                      height: 38,
                      width: MediaQuery.of(context).size.width,
                      // color: const Color.fromARGB(255, 100, 99, 99),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: false,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isClicked = !isClicked;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 3, right: 1),
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                color: isClicked
                                    ? const Color.fromARGB(255, 14, 58, 252)
                                    : const Color(0xFF241B35),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  "All (${notes.length})",
                                  style: ArabicTextStyle(
                                    color: isClicked == true
                                        ? Color.fromARGB(255, 1, 66, 14)
                                        : Colors.white,
                                    arabicFont: ArabicFont.changa,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 6, right: 3),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => SVU()),
                                );
                              },
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 30, right: 30),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 117, 56, 238),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    "الجامعة",
                                    style: ArabicTextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      arabicFont: ArabicFont.changa,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Gym()),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 3, right: 3),
                              height: 40,
                              width: 100,
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 10, right: 30),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 117, 56, 238),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  "الجيم",
                                  style: ArabicTextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    arabicFont: ArabicFont.changa,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      // height: 1000,
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.70,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: MasonryGridView.builder(
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                shrinkWrap: true,
                                itemCount: notes.length,
                                itemBuilder: (context, i) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => editNotes(
                                            kind: notes[i]['kind'],
                                            note: notes[i]['note'],
                                            title: notes[i]['title'],
                                            id: notes[i]['id'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        color: i % 2 == 0
                                            ? const Color.fromARGB(
                                                255, 100, 29, 241)
                                            : i % 3 == 0
                                                ? const Color.fromARGB(
                                                    255, 154, 68, 204)
                                                : i % 4 == 0 || i % 9 == 0
                                                    ? const Color.fromARGB(
                                                        255, 50, 49, 52)
                                                    : i % 5 == 0
                                                        ? const Color.fromARGB(
                                                            245, 149, 35, 94)
                                                        : i % 8 == 0
                                                            ? const Color
                                                                .fromARGB(
                                                                255, 66, 66, 66)
                                                            : const Color
                                                                .fromARGB(255,
                                                                240, 75, 158),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      margin: const EdgeInsets.all(3),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              PopupMenuButton<String>(
                                                iconColor:
                                                    i % 2 == 0 || i % 5 == 0
                                                        ? Colors.white
                                                        : const Color.fromARGB(
                                                            255, 255, 255, 255),
                                                onSelected: (value) async {
                                                  if (value == 'delete') {
                                                    int response =
                                                        await sqldb.DeleteData(
                                                            "DELETE FROM notes WHERE id = ${notes[i]["id"]}");
                                                    if (response > 0) {
                                                      notes.removeWhere(
                                                          (element) =>
                                                              element['id'] ==
                                                              notes[i]['id']);
                                                      setState(() {});
                                                    }
                                                  } else if (value ==
                                                      'update') {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            editNotes(
                                                          kind: notes[i]
                                                              ['kind'],
                                                          note: notes[i]
                                                              ['note'],
                                                          title: notes[i]
                                                              ['title'],
                                                          id: notes[i]['id'],
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
                                              SizedBox(
                                                height: 30,
                                                child: Align(
                                                  child: (notes[i]['title'])
                                                              .length <=
                                                          9
                                                      ? SizedBox(
                                                          height: 50,
                                                          child: Text(
                                                            "${notes[i]['title']}",
                                                            maxLines: 1,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            style:
                                                                ArabicTextStyle(
                                                                    arabicFont:
                                                                        ArabicFont
                                                                            .avenirArabic,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        21,
                                                                    color: i % 2 ==
                                                                                0 ||
                                                                            i % 5 ==
                                                                                0
                                                                        ? Colors
                                                                            .white
                                                                        : i % 3 ==
                                                                                0
                                                                            ? const Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                255,
                                                                                255)
                                                                            : const Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                255,
                                                                                255)),
                                                          ),
                                                        )
                                                      : SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: SizedBox(
                                                            width: 100,
                                                            height: 30,
                                                            child: Text(
                                                                "${notes[i]['title']}",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                textDirection:
                                                                    TextDirection
                                                                        .rtl,
                                                                style: ArabicTextStyle(
                                                                    arabicFont: ArabicFont.avenirArabic,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 18,
                                                                    overflow: TextOverflow.clip,
                                                                    color: i % 2 == 0
                                                                        ? Colors.white
                                                                        : i % 3 == 0
                                                                            ? Colors.white
                                                                            : Colors.white)),
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Container(child: Text("----------")),
                                          SizedBox(
                                            child: Text(
                                              "${notes[i]['note']}",
                                              maxLines: 10,
                                              textDirection: TextDirection.rtl,
                                              style: ArabicTextStyle(
                                                  arabicFont:
                                                      ArabicFont.avenirArabic,
                                                  fontSize: 15,
                                                  color:
                                                      i % 2 == 0 || i % 5 == 0
                                                          ? Colors.white
                                                          : i % 3 == 0
                                                              ? Colors.white
                                                              : Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget myBar() {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.17,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 61, 61, 61),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        width: MediaQuery.of(context).size.width * 0.99,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Icon(
                Icons.sticky_note_2_sharp,
                size: 40,
                color: Colors.white,
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 22, bottom: 6, left: 1),
                  child: DateTime.now().hour >= 4 && DateTime.now().hour < 11
                      ? Text(
                          "أصبحنا وأصبح الملك لله ",
                          textDirection: TextDirection.rtl,
                          style: ArabicTextStyle(
                              arabicFont: ArabicFont.arefRuqaa,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 30),
                        )
                      : DateTime.now().hour >= 11 && DateTime.now().hour < 19
                          ? Text(
                              "أمسينا وأمسى الملك لله , استغفر الله  ",
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.arefRuqaa,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20),
                            )
                          : Text(
                              "اللهم نسألك خير هذه الليلة ",
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.arefRuqaa,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 29),
                            ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 84, 0, 251),
                      borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.only(bottom: 2, top: 2),
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                    style: ArabicTextStyle(
                      fontSize: 20,
                      arabicFont: ArabicFont.amiri,
                      color: const Color.fromARGB(255, 254, 254, 255),
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
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in matchQuery) {
      matchQuery.add(fruit);
    }
    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (contetx, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List matchQuery = context.read<Pro>().notesForSearch;
    List tempList = List.from(matchQuery);
    for (var fruit in tempList) {
      matchQuery.add(fruit);
    }
    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (contetx, index) {
          var result = matchQuery[index]['title'];
          return ListTile(
            title: Text(
              '${result}',
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.avenirArabic, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
