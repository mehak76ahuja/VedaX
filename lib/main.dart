import 'package:flutter/material.dart';
import 'sqlite_helper.dart';
import 'texts/chapterOne.dart';
import 'texts/chapterTwo.dart';
import 'texts/chapterThree.dart';
import 'texts/chapterFour.dart';
import 'texts/chapterFive.dart';

void main() {
  runApp(const VedaXApp());
}

class VedaXApp extends StatelessWidget {
  const VedaXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VedaX',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: Colors.white,
      ),
      home: const VedaXHomePage(),
    );
  }
}

class VedaXHomePage extends StatefulWidget {
  const VedaXHomePage({super.key});

  @override
  State<VedaXHomePage> createState() => _VedaXHomePageState();
}

class _VedaXHomePageState extends State<VedaXHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final SqliteHelper _sqliteHelper = SqliteHelper();
  String _description = '';

  Future<void> _fetchDescription() async {
    String firstLetter = _nameController.text.trim().isNotEmpty
        ? _nameController.text[0].toUpperCase()
        : '';

    if (firstLetter.isNotEmpty) {
      String description = await _sqliteHelper.fetchDescription(firstLetter);
      setState(() {
        _description = description;
      });
    } else {
      setState(() {
        _description = 'Please enter a valid letter.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/finalBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 150),
              const Center(
                child: Text(
                  "Welcome to VedaX. Please enter the first letter of your name to get it's significane according to Hindu Mythology",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Search Bar
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter a letter...',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white12,
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),

              // Search Button
              ElevatedButton(
                onPressed: _fetchDescription,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Search'),
              ),

              const SizedBox(height: 20), 

              // Display the fetched description
              if (_description.isNotEmpty) ...[
                Text(
                  _description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  'Don\'t know anything about Hindu Mythology? Let’s start from the basics. '
                  'This is the complete guide about the mythology from the beginning to the end.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VedasInfoPage(
                        appBarTitle: 'The Vedas - Chapter One',
                        chapterContent: chapterOne,
                        nextChapter: VedasInfoPage(
                          appBarTitle: 'The Upanishads - Chapter Two',
                          chapterContent: chapterTwo,
                          nextChapter: VedasInfoPage(
                            appBarTitle: 'The Epics - Chapter Three',
                            chapterContent: chapterThree,
                            nextChapter: VedasInfoPage(
                              appBarTitle: 'The Puranas - Chapter Four',
                              chapterContent: chapterFour,
                              nextChapter: VedasInfoPage(
                                appBarTitle: 'Smritis - Chapter Five',
                                chapterContent: chapterFive,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Get Started'),
              ),
              const Spacer(),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'www.VedaX.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class VedasInfoPage extends StatelessWidget {
  final String appBarTitle;
  final String chapterContent;
  final Widget? nextChapter;

  const VedasInfoPage({
    super.key,
    required this.appBarTitle,
    required this.chapterContent,
    this.nextChapter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/textBg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Expanded(
                            child: Container(
                              color: Colors.black.withOpacity(0.7),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      appBarTitle,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      chapterContent,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    if (nextChapter != null)
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => nextChapter!,
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: const Text('Next Chapter'),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}