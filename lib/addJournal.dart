import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'package:intl/intl.dart';
import 'data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddJournal extends StatefulWidget {
  const AddJournal({super.key});

  @override
  State<AddJournal> createState() => _AddJournalState();
}

class _AddJournalState extends State<AddJournal> {
  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();
  void completed() {
    if (_title.text.isNotEmpty || _content.text.isNotEmpty) {
      setState(() {
        String title = _title.text;
        String content = _content.text;
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
        String formatForDate = DateFormat('yyyy-MM-dd').format(now);
        String dateTime = formattedDate;
        if (title.isEmpty) {
          title = formatForDate;
        }
        mjournal.add([title, content, dateTime]);
      });
    }
    Navigator.pop(context);
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
        backgroundColor: // themeProvider.isDarkMode ? Colors.black : Colors.white,
            themeProvider.isDarkMode
                ? Color.fromRGBO(42, 42, 46, 1)
                : Color.fromRGBO(255, 255, 255, 1),
        body: Column(
          children: [
            //appBar
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      completed();
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      completed();
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //titile
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextField(
                controller: _title,
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'title',
                  hintStyle: TextStyle(
                    color:
                        themeProvider.isDarkMode ? Colors.white : Colors.black,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            //line
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                thickness: 1,
              ),
            ),
            //write
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: TextField(
                  controller: _content,
                  style: TextStyle(
                    color:
                        themeProvider.isDarkMode ? Colors.white : Colors.black,
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'how was you day??',
                    hintStyle: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
