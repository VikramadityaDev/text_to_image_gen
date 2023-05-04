import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    _appModeCubit = context.read<AppModeCubit>()..loadMode();
    _appThemeCubit = context.read<AppThemeCubit>()..loadTheme();
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
