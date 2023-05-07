import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        backgroundColor: Colors.transparent,
        title: RichText(
          text: TextSpan(
              text: 'About ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Aesthetic',
              ),
              children: [
                TextSpan(
                  text: 'TexFusion',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Aesthetic',
                  ),
                ),
              ]),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Description',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Nexa',
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'The TexFusion AI app was created by the Flutter framework and is a new AI art generation tool that can create amazing images from just text prompts. TexFusion AI can also make variations of your existing image. It uses the brain_fusion API to get realistically rendered images.',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'NexaLight',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Features',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Nexa',
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '- Generate Images from Text \n - High Quality images. \n - Unlimited Response. \n - Added 12 Styles. \n - Download Image \n - Accent Color Mode. \n - Theme Mode. \n - Lightweight & User Friendly.',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'NexaLight',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'How its work ?',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Nexa',
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "1. Make sure you enter a more descriptive prompt. As this is a new API, it is going to take time to produce HD images with a less descriptive prompt. So, make sure you describe the image correctly that you want as output. \n \n 2. Try to select styles while creating your image. Check different styles and see how the output image looks.",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'NexaLight',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Fork the repository, and don't forget to star the repository 🌟",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Nexa',
                    color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Social Links',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Nexa',
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final Uri url =
                        Uri.parse('https://github.com/VikramadityaDev/');
                    if (!await launchUrl(url,
                        mode: LaunchMode.externalApplication)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  child: const Text(
                    'Github',
                    style: TextStyle(fontSize: 15, fontFamily: 'Nexa'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final Uri url =
                        Uri.parse('https://telegram.me/Aditya@1190/');
                    if (!await launchUrl(url,
                        mode: LaunchMode.externalApplication)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  child: const Text(
                    'Telegram',
                    style: TextStyle(fontSize: 15, fontFamily: 'Nexa'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Text(
          "Made By  VikramadityaDev &️ DJ-Yacine",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            fontFamily: 'NexaLight',
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
