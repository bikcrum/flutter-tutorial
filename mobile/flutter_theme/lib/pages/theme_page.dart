import 'package:flutter/material.dart';
import 'package:flutter_theme/config/global_config.dart';
import 'package:flutter_theme/json/theme_power.dart';
import 'package:flutter_theme/model/global_model.dart';
import 'package:flutter_theme/model/theme_page_model.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ThemePageModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Setting'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: model.themes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (_, index) {
          final theme = model.themes[index];
          return _buildThemeItem(context, theme);
        },
      ),
    );
  }

  Widget _buildThemeItem(BuildContext context, ThemePower theme) {
    final globalModel = Provider.of<GlobalModel>(context);
    final Color iconColor = theme.themeType == ThemeType.dark ? Colors.grey : Colors.white;
    return InkWell(
      onTap: () => _updateTheme(context, theme),
      child: Card(
        color: theme.colorPower.color(),
        child: globalModel.currentThemePower == theme
            ? Icon(
                Icons.check,
                color: iconColor,
                size: 40,
              )
            : null,
      ),
    );
  }

  void _updateTheme(BuildContext context, ThemePower theme) {
    final model = Provider.of<ThemePageModel>(context);
    final globalModel = Provider.of<GlobalModel>(context);
    model.logic.updateTheme(globalModel, theme);
  }
}
