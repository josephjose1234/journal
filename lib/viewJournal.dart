import 'data.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'package:provider/provider.dart';


class ViewJournal extends StatefulWidget {
  final int Ind;
  const ViewJournal({super.key, required this.Ind});

  @override
  State<ViewJournal> createState() => _ViewJournalState();
}

class _ViewJournalState extends State<ViewJournal> {
  late int Indx;
  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();
  @override
  void initState() {
    super.initState();
    Indx = widget.Ind;
    _title = TextEditingController(text: mjournal[Indx][0]);
    _content = TextEditingController(text: mjournal[Indx][1]);
  }

  void edited() {
    if (_title.text.isNotEmpty || _content.text.isNotEmpty) {
      setState(() {
        String content = _content.text;
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
        String dateTime = formattedDate;
        String formatForDate = DateFormat('yyyy-MM-dd').format(now);
        String title = _title.text;
        if (title.isEmpty) {
          title = formatForDate;
        }
        //  mjournal.add([title, content,dateTime]);
        mjournal[Indx][0] = title;
        mjournal[Indx][1] = content;
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Set system overlay style based on the selected theme
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // statusBarBrightness:
        //     themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: // themeProvider.isDarkMode ? Colors.black : Colors.white,
            themeProvider.isDarkMode
                ? const Color.fromRGBO(42, 42, 46, 1)
                : const Color.fromRGBO(255, 255, 255, 1),
        body: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      edited();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      child:
                          const Icon(Icons.arrow_back, size: 30, color: Colors.blue),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      edited();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      child: const Text(
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
            Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextField(
                controller: _title,
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                thickness: 1,
              ),
            ),
            //write
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: TextField(
                  controller: _content,
                  maxLines: null,
                  style: TextStyle(
                    color:
                        themeProvider.isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: const InputDecoration(
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
