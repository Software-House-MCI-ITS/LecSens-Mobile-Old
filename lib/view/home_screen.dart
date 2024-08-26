import 'package:flutter/material.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:provider/provider.dart';

import '../res/widgets/header.dart';
import '../res/widgets/info_section.dart';
import '../res/widgets/overview_section.dart';
import '../res/widgets/pengaturan_section.dart';
import 'package:lecsens/viewModel/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 1;
  HomeViewModel hm = HomeViewModel();

  @override
  void initState() {
    super.initState();
    hm.setTitle();
    hm.setVoltametryDataListApi(context);
  }

  @override
  Widget build(BuildContext context) {
    final homeviewmodel = Provider.of<HomeViewModel>(context);

    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => hm,
      child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Center(
          child: Header(homeviewmodel: homeviewmodel),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Overview',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
      body: <Widget>[
            OverviewSection(homeViewModel: homeviewmodel),
            InfoSection(homeviewmodel: hm),
            PengaturanSection(homeviewmodel: homeviewmodel),
          ][currentPageIndex]
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, RouteNames.ambilData);
      //   },
      //   child: const Icon(Icons.add),
      //   backgroundColor: Colors.blue,
      // ),
    ),
    );
  }
}
