import 'package:flutter/material.dart';

class AutocompleteExampleApp extends StatelessWidget {
  const AutocompleteExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Autocomplete Basic User'),
        ),
        body: const Center(
          child: AutocompleteBasicUserExample(),
        ),
      ),
    );
  }
}

@immutable
class User {
  const User({
    required this.email,
    required this.name,
  });

  final String email;
  final String name;

  @override
  String toString() {
    return '$name, $email';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is User && other.name == name && other.email == email;
  }

  @override
  int get hashCode => Object.hash(email, name);
}

class AutocompleteBasicUserExample extends StatelessWidget {
  const AutocompleteBasicUserExample({super.key});

  static const List<User> _userOptions = <User>[
   // retorno API Material/?pesquisa=  
  ];

  static String _displayStringForOption(User option) => option.name;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<User>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.length == 3) {
        
        }
        return _userOptions.where((User option) {
          return option
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (User selection) {
        debugPrint('You just selected ${_displayStringForOption(selection)}');
      },
    );
  }
}
