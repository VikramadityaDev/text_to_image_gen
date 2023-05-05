import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:text_to_image_gen/bloc/app_directory_cubit.dart';

import '../bloc/app_mode_cubit.dart';
import '../bloc/app_theme_cubit.dart';
import '../utils/strings.dart';
import '../widgets/app_theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late AppModeCubit _appModeCubit;
  late AppThemeCubit _appThemeCubit;
  final List<AppTheme> _themes = appThemes.keys.toList();
  late AppDirectoryCubit _appDirectoryCubit;
  final FilePicker filePicker = FilePicker.platform;

  @override
  void initState() {
    super.initState();
    _appDirectoryCubit = context.read<AppDirectoryCubit>()..loadPath();
    _appModeCubit = context.read<AppModeCubit>()..loadMode();
    _appThemeCubit = context.read<AppThemeCubit>()..loadTheme();
  }

  Future<void> _pickDirectory() async {
    String? directoryPath;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      int versionNumber = int.parse(androidInfo.version.release.split('.')[0]);
      try {
        if (versionNumber < 10) {
          if (await Permission.storage.isDenied) {
            await Permission.storage.request();
          } else if (await Permission.storage.isGranted) {
            directoryPath = await filePicker.getDirectoryPath();
            if (directoryPath != null) {
              _appDirectoryCubit.changePath(directoryPath);
            } else {
              message();
            }
          } else {
            await Permission.storage.request();
          }
        } else {
          if (await Permission.manageExternalStorage.isDenied) {
            await Permission.manageExternalStorage.request();
          } else if (await Permission.manageExternalStorage.isGranted) {
            directoryPath = await filePicker.getDirectoryPath();
            if (directoryPath != null) {
              _appDirectoryCubit.changePath(directoryPath);
            } else {
              message();
            }
          } else {
            await Permission.manageExternalStorage.request();
          }
        }
      } catch (e) {
        message();
        if (kDebugMode) {
          print('Error picking directory in android: $e');
        }
      }
    } else {
      try {
        directoryPath = await filePicker.getDirectoryPath();
        if (directoryPath != null) {
          _appDirectoryCubit.changePath(directoryPath);
        } else {
          message();
        }
      } catch (e) {
        message();
        if (kDebugMode) {
          print('Error picking directory: $e');
        }
      }
    }
  }

  void message() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content:
              const Text('There is error . Try Again later or restart the app'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<AppDirectoryCubit, AppDirectoryState>(
                builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: const Icon(Icons.folder),
                  title: const Text('Main Directory'),
                  subtitle: Text(state.path),
                  trailing: ElevatedButton(
                    onPressed: _pickDirectory,
                    child: const Text('Change'),
                  ),
                ),
              );
            }),
            BlocBuilder<AppModeCubit, AppModeState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'App Mode ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).splashColor,
                          ),
                          child: CheckboxListTile(
                            title: const Text('System Mode'),
                            value: state.mode == system,
                            onChanged: (value) {
                              if (value == true) {
                                _appModeCubit.changeMode(system);
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).splashColor,
                          ),
                          child: CheckboxListTile(
                            title: const Text('Light Mode'),
                            value: state.mode == light,
                            onChanged: (value) {
                              if (value == true) {
                                _appModeCubit.changeMode(light);
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).splashColor,
                          ),
                          child: CheckboxListTile(
                            title: const Text('Dark Mode'),
                            value: state.mode == dark,
                            onChanged: (value) {
                              if (value == true) {
                                _appModeCubit.changeMode(dark);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            BlocBuilder<AppThemeCubit, AppThemeState>(
              builder: (context, state) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Themes',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: _themes.map((theme) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).splashColor,
                                ),
                                child: CheckboxListTile(
                                  title: Text(theme.name),
                                  value: _appThemeCubit.state.theme == theme,
                                  onChanged: (bool? value) {
                                    if (value == true) {
                                      _appThemeCubit.updateTheme(theme);
                                    }
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
