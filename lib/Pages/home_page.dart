import 'dart:io' show Platform, File, Directory;

import 'package:brain_fusion/brain_fusion.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:text_to_image_gen/Pages/settings_page.dart';
import 'package:text_to_image_gen/bloc/image_cubit.dart';
import 'package:path/path.dart' as xp;
import 'package:text_to_image_gen/utils/app_language.dart';

import '../bloc/app_directory_cubit.dart';
import '../utils/strings.dart';
import '../widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ImageCubit _imageCubit;
  late AppDirectoryCubit _appDirectoryCubit;
  late Directory directory;
  final TextEditingController _textEditingController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<AIStyle, String> styleDisplayText = {
    AIStyle.noStyle: 'No style',
    AIStyle.render3D: '3D render',
    AIStyle.anime: 'Anime',
    AIStyle.islamic: 'Islamic',
    AIStyle.iconography: 'Icon Graphy',
    AIStyle.mosaic: 'Mosaic',
    AIStyle.moreDetails: 'More Detailed',
    AIStyle.cyberPunk: 'CyberPunk',
    AIStyle.cartoon: 'Cartoon',
    AIStyle.picassoPainter: 'Picasso painter',
    AIStyle.oilPainting: 'Oil painting',
    AIStyle.digitalPainting: 'Digital painting',
    AIStyle.portraitPhoto: 'Portrait photo',
    AIStyle.pencilDrawing: 'Pencil drawing',
  };

  Future<void> _saveImage(Uint8List canvas) async {
    final String path = _appDirectoryCubit.state.path;
    try {
      if (path != pathHint) {
        directory = Directory(path);
        final appDir = Directory('${directory.path}/$app');
        if (!(await appDir.exists())) {
          await appDir.create();
        }
        final image =
            '''IMG-${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}--${DateTime.now().hour.toString()}-${DateTime.now().minute.toString()}-${DateTime.now().millisecond.toString()}-TexFusion.jpeg''';
        final filePath = xp.join(appDir.path, image);
        final file = File(filePath);
        await file.writeAsBytes(canvas).whenComplete(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('${translation(context).imageWasSaved} : $filePath'),
              elevation: 10,
            ),
          );
        });
      } else {
        _choosePath();
      }
    } catch (e) {
      if (kDebugMode) {
        print('when save image : $e');
      }
      _choosePath();
    }
  }

  @override
  void initState() {
    super.initState();
    _imageCubit = ImageCubit();
    _appDirectoryCubit = context.read<AppDirectoryCubit>()..loadPath();
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
                if (FocusScope.of(context).hasFocus) {
                  FocusScope.of(context).unfocus();
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(
                  Iconsax.setting_2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
          leading: InkWell(
            onTap: () {
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
              }
              scaffoldKey.currentState?.openDrawer();
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
              }
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextField(
                          autofocus: false,
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText:
                                translation(context).putAnythingInYourMind,
                            labelText:
                                translation(context).putAnythingInYourMind,
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
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
                              if (FocusScope.of(context).hasFocus) {
                                FocusScope.of(context).unfocus();
                              }
                              setState(() {
                                _textEditingController.text = query;
                              });
                              _chooseStyle(_textEditingController.text);
                            }
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        width: MediaQuery.of(context).size.width * 0.20,
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
                              FocusScope.of(context).unfocus();
                              _chooseStyle(_textEditingController.text);
                            }
                          },
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 14.0),
                              child: Icon(
                                Icons.gesture,
                                size: 32,
                              ),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 300,
                              width: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(100),
                                child: Lottie.asset(
                                  'assets/animations/loading.json',
                                  frameRate: FrameRate(120),
                                  repeat: true,
                                  animate: true,
                                ),
                              ),
                            ),
                            Text(
                              translation(context).loading,
                              style: const TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      );
                    }
                    if (state is ImageLoaded) {
                      final image = state.image;
                      if (Platform.isAndroid) {
                        if (MediaQuery.of(context).orientation ==
                            Orientation.portrait) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/images/Ai.webp'),
                                    image: MemoryImage(image),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: InkWell(
                                      focusColor: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      borderRadius: BorderRadius.circular(7),
                                      onTap: () async {
                                        await _saveImage(image);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ],
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  translation(context).download,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: InkWell(
                                    focusColor: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    borderRadius: BorderRadius.circular(7),
                                    onTap: () async {
                                      await _saveImage(image);
                                    },
                                    child: SizedBox(
                                      width: 125,
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Container(
                                              width: 125,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ],
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  translation(context).download,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/images/Ai.webp'),
                                    image: MemoryImage(image),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        if (MediaQuery.of(context).size.width >
                            MediaQuery.of(context).size.height) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: InkWell(
                                    focusColor: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    borderRadius: BorderRadius.circular(7),
                                    onTap: () async {
                                      await _saveImage(image);
                                    },
                                    child: SizedBox(
                                      width: 125,
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Container(
                                              width: 125,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ],
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  translation(context).download,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/images/Ai.webp'),
                                    image: MemoryImage(image),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/images/Ai.webp'),
                                    image: MemoryImage(image),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: InkWell(
                                      focusColor: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      borderRadius: BorderRadius.circular(7),
                                      onTap: () async {
                                        await _saveImage(image);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ],
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  translation(context).download,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    }
                    if (state is ImageError) {
                      final error = state.error;
                      if (kDebugMode) {
                        print(error);
                      }
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Text(
                            "${translation(context).failed} .${translation(context).noResultFound}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
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
          title: Text('${translation(context).chooseStyle} :'),
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

  void _choosePath() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${translation(context).chooseDirectory} :'),
          content: Text(translation(context).confirmDirectory),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(translation(context).no),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              child: Text(translation(context).yes),
            ),
          ],
        );
      },
    );
  }
}
