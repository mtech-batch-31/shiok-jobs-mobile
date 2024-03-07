import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/View/job_list_view.dart';
import 'package:shiok_jobs_flutter/View/profile_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      const JobList(),
      const ProfilePage(),
    ];

    return Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: children,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Job List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.man),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.amber[800],
        ));
  }
}
