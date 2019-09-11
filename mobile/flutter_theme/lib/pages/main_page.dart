import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_theme/config/provider_config.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Demo'),
      ),
      body: Align(
        child: RaisedButton(
          onPressed: () => _openLanguagePage(context),
          child: const Text('Theme Setting'),
        ),
      ),
    );
  }

  void _openLanguagePage(BuildContext context) {
    final navigator = Navigator.of(context);
    navigator.push(
      MaterialPageRoute(builder: (_) => ProviderConfig.shared().getThemePage()),
    );
  }
}
