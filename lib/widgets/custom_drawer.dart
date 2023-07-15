import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Pages/about_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Image.asset('assets/images/Ai.webp'),
            ),
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
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
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
              final Uri url = Uri.parse(
                  'https://github.com/VikramadityaDev/text_to_image_gen/releases/');
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
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
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          ListTile(
            leading: const Icon(Iconsax.info_circle),
            title: Text(
              "About",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Nexa'),
            ),
            subtitle: Text(
              "About this project",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontFamily: 'NexaLight',
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ),
              );
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
              "VikramadityaDev & DJ-Yacine",
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
                  "v1.0.7",
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
    );
  }
}
