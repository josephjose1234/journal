import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addJournal.dart';
import 'viewJournal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // SharedPreferences journal= await SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //converting the list of strings to a single string
    List<String> flattenedData = mjournal.expand((list) => list).toList();
    await prefs.setStringList('journalData', flattenedData);
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? flattenedData = prefs.getStringList('journalData');
    if (flattenedData != null) {
      List<List<String>> data = [];
      for (int i = 0; i < flattenedData.length; i += 3) {
        data.add(
            [flattenedData[i], flattenedData[i + 1], flattenedData[i + 2]]);
      }
      setState(() {
        mjournal = data;
      });
    }
  }

  void navFunction() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (Context) => AddJournal(),
      ),
    );
    setState(() {
      saveData();
    });
  }

  void navToView(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (Context) => ViewJournal(Ind: index)),
    );
    setState(() {
      saveData();
    });
  }

  Color lovee = Colors.blue;
  void changeColor() {
    if (lovee == Colors.blue) {
      setState(() {
        lovee = Colors.red;
      });
    } else {
      setState(() {
        lovee = Colors.blue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //themeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Set system overlay style based on the selected theme
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // statusBarBrightness:
        //     themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeProvider.isDarkMode
            ? Colors.black
            : Color.fromRGBO(242, 242, 246, 1),
        body: Stack(
          children: [
            Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Edit
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.all(20),
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                //Heading Journal
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    'Journal',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                // SEARCH
                Search(themeProvider: themeProvider),
                //TimeLine.Head
                Container(
                  margin: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Timeline',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                //Entries

                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    child: ListView.builder(
                      itemCount: mjournal.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: themeProvider.isDarkMode
                                ? const Color.fromRGBO(42, 42, 46, 1)
                                : const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  navToView(index);
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          mjournal[index][0],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: themeProvider.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          mjournal[index][1],
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            color: themeProvider.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        navToView(index);
                                      },
                                      child: Text(
                                        mjournal[index][2],
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300,
                                          color: themeProvider.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        changeColor();
                                      },
                                      child: Icon(Icons.favorite_border,
                                          color: lovee),
                                    ),
                                    const Icon(Icons.delete_outline,
                                        color: Colors.blue)
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                //log an emotion
                //add Journal
              ],
            ),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () {
                  navFunction();
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Search extends StatefulWidget {
  const Search({
    super.key,
    required this.themeProvider,
  });
  final ThemeProvider themeProvider;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {},
        child: Container(
            decoration: BoxDecoration(
                color: widget.themeProvider.isDarkMode
                    ? Colors.black
                    : const Color.fromRGBO(79, 60, 60, 1),
                borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: 'Search..', border: InputBorder.none),
            )),
      ),
    ]);
  }
}
