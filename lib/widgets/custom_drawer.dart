import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:text_to_image_gen/Pages/home_page.dart';
import 'package:text_to_image_gen/widgets/accents_color.dart';
import 'package:text_to_image_gen/widgets/theme_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            Container(
              child: DrawerHeader(
                child: Center(
                  child: Image.asset('assets/images/Ai.png'),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Iconsax.home),
              title: Text(
                "Home",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Nexa'),
              ),
              subtitle: Text(
                "Main page",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NexaLight',
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.layer),
              title: Text(
                "Appearance",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Nexa'),
              ),
              subtitle: Text(
                "Select accent color",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NexaLight',
                ),
              ),
              onTap: () => showDialog(
                  context: context,
                  builder: (context) {
                    return const AccentColors();
                  }),
            ),
            ListTile(
              leading: const Icon(
                Iconsax.brush,
              ),
              title: Text(
                'Theme Mode',
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Nexa'),
              ),
              subtitle: Text(
                "Select theme mode",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NexaLight',
                ),
              ),
              onTap: () => showDialog(
                  context: context,
                  builder: (context) {
                    return const ThemeModeDialog();
                  }),
            ),
            ListTile(
              leading: const Icon(Iconsax.hierarchy_2),
              title: Text(
                "Source code",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Nexa'),
              ),
              subtitle: Text(
                "Github link",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NexaLight',
                ),
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
              leading: const Icon(Iconsax.refresh_circle),
              title: Text(
                "Check for update",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Nexa'),
              ),
              subtitle: Text(
                "Check releases",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NexaLight',
                ),
              ),
              onTap: () async {
                final Uri url =
                    Uri.parse('https://github.com/VikramadityaDev/text_to_image_gen/releases/');
                if (!await launchUrl(url,
                    mode: LaunchMode.externalApplication)) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
            ListTile(
              leading: const Icon(
                Iconsax.sms_tracking,
              ),
              title: Text(
                "Join us on telegram",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Nexa'),
              ),
              subtitle: Text(
                "For more new apps",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NexaLight',
                ),
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
            ListTile(
              leading: const Icon(
                Iconsax.verify,
              ),
              title: Text(
                "</> & Crafted with 💛",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Nexa'),
              ),
              subtitle: Text(
                "VikramadityaDev",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NexaLight',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'v1.0.3',
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                        fontFamily: 'Nexa'),
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
