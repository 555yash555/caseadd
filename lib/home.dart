import 'package:flutter/material.dart';
import 'authentication/login/login.dart';
import 'package:juridentt/resources/auth.dart';
import 'package:juridentt/features/teams/viewaccess.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addcase');
                },
                child: const Text('Add new case'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/viewcase');
                },
                child: const Text('view case'),
              ),
              ElevatedButton(
                onPressed: () {
                  Auth().signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text('Logout'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TeamsPage(),
                    ),
                  );
                },
                child: const Text('teams'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
