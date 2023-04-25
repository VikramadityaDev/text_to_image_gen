import 'dart:async';
import 'dart:ui' as ui;

import 'package:brain_fusion/brain_fusion.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:text_to_image_gen/Pages/about_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _queryController = TextEditingController();

  final AI _ai = AI();

  Future<Uint8List> _generate(String query) async {
    Uint8List image = await _ai.runAI(query, AIStyle.render3D);
    return image;
  }

  final GlobalKey _globalKey = GlobalKey();

  bool _isDownloading = false;
  bool _isDownloadInitiated = false;
  bool run = false;
  String query = "";

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepPurple.shade400),
        backgroundColor: Colors.transparent,
        title: RichText(
          text: TextSpan(
              text: 'Tex',
              style: TextStyle(color: Colors.amber.shade900, fontWeight: FontWeight.w500, fontSize: 18),
              children: [
                TextSpan(
                  text: 'Fusion',
                  style: TextStyle(color: Colors.deepPurple.shade500, fontWeight: FontWeight.w500, fontSize: 18),
                )
              ]
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            scaffoldKey.currentState?.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset(
              'assets/animations/me.json',
              repeat: true,
              reverse: true,
              animate: true,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Lottie.asset(
                'assets/animations/set.json',
                repeat: true,
                reverse: true,
                animate: true,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.deepPurple.shade50,
          child: Column(
            children: [
              Container(
                color: Colors.deepPurple.shade50,
                child: DrawerHeader(
                  child: Center(
                      child: Text(
                        "TexFusion AI App",
                        style: TextStyle(
                            fontSize: 18, color: Colors.deepPurple.shade400),
                      ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.source_rounded,
                  color: Colors.black54,
                ),
                title: Text(
                  "Source Code",
                  style: TextStyle(
                      fontSize: 16, color: Colors.deepPurple.shade400),
                ),
                onTap: () async {
                  final Uri url = Uri.parse(
                      'https://github.com/VikramadityaDev/text_to_image_gen/');
                  if (!await launchUrl(url,
                      mode: LaunchMode.externalApplication)) {
                    throw Exception('Could not launch $url');
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.update,
                  color: Colors.black54,
                ),
                title: Text(
                  "Check for update",
                  style: TextStyle(
                      fontSize: 16, color: Colors.deepPurple.shade400),
                ),
                onTap: () async {
                  final Uri url =
                  Uri.parse('https://telegram.me/vikimediaofficial/');
                  if (!await launchUrl(url,
                      mode: LaunchMode.externalApplication)) {
                    throw Exception('Could not launch $url');
                  }
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'v1.0.2',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.deepPurple.shade400,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
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
                      width: 1.5,
                      color: Colors.deepPurple.shade400,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Colors.deepPurple.shade400,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.9,
                width: MediaQuery.of(context).size.width,
                child: run
                    ? FutureBuilder<Uint8List>(
                  future: _generate(_queryController.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.all(120.0),
                        child: Lottie.asset(
                          'assets/animations/loading.json',
                          repeat: true,
                          reverse: true,
                          animate: true,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'Something went wrong. Please Re-generate.',
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return RepaintBoundary(
                        key: _globalKey,
                        child: InkWell(
                          onTap: () {
                            _saveScreen();
                          },
                          child: Image.memory(snapshot.data!),
                        ),
                      );
                    } else {
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
            SizedBox(
              height: MediaQuery.of(context).size.width / 5.5,
            ),
            const Text(
              'Click the image to save in Gallery.',
              softWrap: true,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80),
              child: ElevatedButton(
                onPressed: () {
                  String newQuery = _queryController.text;
                  if (newQuery.isNotEmpty) {
                    setState(() {
                      query = newQuery;
                      run = true;
                    });
                  } else {
                    if (newQuery.isEmpty) {
                      Fluttertoast.showToast(
                        msg: 'Query is empty !!',
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                      );
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
          ],
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          "Made With Love ❤️ VikiMedia",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
  _saveScreen() async {
    if (_isDownloading) {
      // Do nothing if a download is already in progress.
      Fluttertoast.showToast(
        msg: 'Download in progress. Please wait.',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.amber,
        timeInSecForIosWeb: 3,
      );
      return;
    }
    if (_isDownloadInitiated) {
      return;
    }
    _isDownloadInitiated = true;
    Fluttertoast.showToast(
      msg: 'Download Started !',
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
    );
    _isDownloading = true;
    RenderRepaintBoundary boundary =
    _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 12);
    ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      final result = await ImageGallerySaver.saveImage(
        byteData.buffer.asUint8List(),
        quality: 100,
      );
      print(result);
      Fluttertoast.showToast(
        msg: 'Image Successfully Saved To Gallery.',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        timeInSecForIosWeb: 3,
      );
    }
    _isDownloadInitiated = false;
    _isDownloading = false;
  }
}