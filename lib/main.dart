import 'package:brain_fusion/brain_fusion.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

/// The [main] function is the entry point of the application
void main() {
  // Call the runApp function to start the app
  runApp(const MyApp());
}

// The [MyApp] widget is the root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.deepPurple.shade400,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // The text editing controller for the query.
  final TextEditingController _queryController = TextEditingController();

  // Initializes the [AI] class from the 'brain_fusion' package.
  final AI _ai = AI();

  // The boolean value to run the function.
  bool run = false;

  // The [_generate] function to generate image data.
  Future<Uint8List> _generate(String query) async {
    // Call the runAI method with the required parameters.
    Uint8List image = await _ai.runAI(query, AIStyle.render3D);
    return image;
  }

  @override
  void dispose() {
    // Dispose the [_queryController].
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Imagination Generator',
            style: TextStyle(color: Colors.deepPurple.shade400)),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  controller: _queryController,
                  decoration: InputDecoration(
                    hintText: 'Enter your imagination...',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          width: 1.5, color: Colors.deepPurple.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          width: 1.5, color: Colors.deepPurple.shade400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  child: run
                      ? FutureBuilder<Uint8List>(
                          // Call the [_generate] function to get the image data.
                          future: _generate(_queryController.text),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // While waiting for the image data, display a loading indicator.
                              return Padding(
                                padding: const EdgeInsets.all(100.0),
                                child: Lottie.asset(
                                  'assets/loading.json',
                                  repeat: true,
                                  reverse: true,
                                  animate: true,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              // If an error occurred while getting the image data, display an error message.
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              // If the image data is available, display the image using Image.memory().
                              return Image.memory(snapshot.data!);
                            } else {
                              // If no data is available, display a placeholder or an empty container.
                              return Container();
                            }
                          },
                        )
                      : const Center(
                          child: Text(
                            'See Magic Here 🪄',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: ElevatedButton(
                  onPressed: () {
                    // Get the user input from the [_queryController].
                    String query = _queryController.text;
                    if (query.isNotEmpty) {
                      // If the user input is not empty, set [run] to true to generate the image.
                      setState(() {
                        run = true;
                      });
                    } else {
                      // If the user input is empty, print an error message.
                      if (kDebugMode) {
                        print('Query is empty !!');
                      }
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(0.0),
                    ),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.deepPurple.shade400,
                          Colors.deepPurpleAccent.shade200,
                        ],
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 88.0,
                        minHeight: 45.0,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Generate',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text("Made With Love ❤️ Vikramaditya", textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
      ),
    );
  }
}
