import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepPurple.shade400),
        backgroundColor: Colors.transparent,
        title: RichText(
          text: TextSpan(
              text: 'About ',
              style: TextStyle(color: Colors.amber.shade900, fontWeight: FontWeight.w500, fontSize: 18),
              children: [
                TextSpan(
                  text: 'TexFusion',
                  style: TextStyle(color: Colors.deepPurple.shade500, fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ]
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
              child: Text('Adding Soon..'),
          ),
        ],
      ),
    );
  }
}
