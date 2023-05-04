import 'dart:io' show Platform;

import 'package:brain_fusion/brain_fusion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:text_to_image_gen/Pages/settings_page.dart';
import 'package:text_to_image_gen/bloc/image_cubit.dart';

import '../widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ImageCubit _imageCubit;
  final TextEditingController _textEditingController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<AIStyle, String> styleDisplayText = {
    AIStyle.noStyle: 'No style',
    AIStyle.render3D: '3D render',
    AIStyle.anime: 'Anime',
    AIStyle.moreDetails: 'More Detailed',
    AIStyle.cyberPunk: 'CyberPunk',
    AIStyle.cartoon: 'Cartoon',
    AIStyle.picassoPainter: 'Picasso painter',
    AIStyle.oilPainting: 'Oil painting',
    AIStyle.digitalPainting: 'Digital painting',
    AIStyle.portraitPhoto: 'Portrait photo',
    AIStyle.pencilDrawing: 'Pencil drawing',
  };

  @override
  void initState() {
    super.initState();
    _imageCubit = ImageCubit();
  }

  @override
  void dispose() {
    _imageCubit.close();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _imageCubit,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const CustomDrawer(),
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              child: Padding(
                  padding: const EdgeInsets.all(12), child: Icon(Iconsax.setting_2 ,
                color: Theme.of(context).colorScheme.primary,
              )),
            ),
          ],
          leading: InkWell(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: Icon(
              Iconsax.element_plus,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: RichText(
            text: TextSpan(
              text: 'Tex',
              style: TextStyle(
                  //color: Colors.amber.shade900,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Aesthetic'),
              children: [
                TextSpan(
                  text: 'Fusion',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Aesthetic'),
                )
              ],
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                MediaQuery.of(context).size.height >
                        MediaQuery.of(context).size.width
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 140,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: TextField(
                                    controller: _textEditingController,
                                    decoration: InputDecoration(
                                      hintText: "Enter Anything in Your Mind",
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _textEditingController.clear();
                                          });
                                        },
                                        icon: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.clear,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onChanged: (text) {
                                      if (text.isEmpty) {
                                        setState(() {
                                          _textEditingController.clear();
                                        });
                                      }
                                    },
                                    onSubmitted: (query) {
                                      if (query.isNotEmpty) {
                                        setState(() {
                                          _textEditingController.text = query;
                                        });
                                        _chooseStyle(
                                            _textEditingController.text);
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_textEditingController
                                          .text.isNotEmpty) {
                                        _chooseStyle(
                                            _textEditingController.text);
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(13),
                                      child: Icon(
                                        Icons.gesture,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextField(
                                  controller: _textEditingController,
                                  decoration: InputDecoration(
                                    hintText: "Enter Anything in Your Mind",
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _textEditingController.clear();
                                        });
                                      },
                                      icon: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Icon(
                                          Icons.clear,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onChanged: (text) {
                                    if (text.isEmpty) {
                                      setState(() {
                                        _textEditingController.clear();
                                      });
                                    }
                                  },
                                  onSubmitted: (query) {
                                    if (query.isNotEmpty) {
                                      setState(() {
                                        _textEditingController.text = query;
                                      });
                                      _chooseStyle(_textEditingController.text);
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (_textEditingController.text.isNotEmpty) {
                                    _chooseStyle(_textEditingController.text);
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(13),
                                  child: Icon(
                                    Icons.gesture,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                BlocBuilder<ImageCubit, ImageState>(
                  builder: (context, state) {
                    if (state is ImageLoading) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(50),
                          child: Lottie.asset(
                            'assets/animations/loading.json',
                            frameRate: FrameRate(60),
                            repeat: true,
                            animate: true,
                          ),
                        ),
                      );
                    }
                    if (state is ImageLoaded) {
                      final image = state.image;
                      return SizedBox(
                        width: Platform.isAndroid
                            ? MediaQuery.of(context).size.width
                            : 500,
                        child: FadeInImage(
                          placeholder:
                              const AssetImage('assets/images/Ai.webp'),
                          image: MemoryImage(image),
                          fit: BoxFit.contain,
                        ),
                      );
                    }
                    if (state is ImageError) {
                      final error = state.error;
                      return Center(
                        child: Text(error),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _chooseStyle(String query) async {
    showDialog<AIStyle>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Choose style for the image :'),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10.0,
                runSpacing: 10.0,
                children: styleDisplayText.entries.map((entry) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _imageCubit.generate(query, entry.key);
                      Navigator.pop(context);
                    },
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
