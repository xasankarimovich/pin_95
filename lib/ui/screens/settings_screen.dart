import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isPasswordEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPasswordEnabled = prefs.getBool('isPasswordEnabled') ?? false;
    });
  }

  Future<void> _togglePassword(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPasswordEnabled', value);
    setState(() {
      _isPasswordEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SwitchListTile(
        title: const Text('Enable Password'),
        value: _isPasswordEnabled,
        onChanged: _togglePassword,
      ),
    );
  }
}
