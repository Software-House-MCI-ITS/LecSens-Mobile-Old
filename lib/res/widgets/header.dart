import 'package:flutter/material.dart';
import 'package:lecsens/viewModel/home_view_model.dart';
import 'package:provider/provider.dart';

class Header extends StatefulWidget {
  final HomeViewModel homeviewmodel;
  const Header({super.key, required this.homeviewmodel});

  @override
  HeaderState createState() {
    return HeaderState();
  }
}

class HeaderState extends State<Header> {
  @override
  void initState() {
    super.initState();
    widget.homeviewmodel.setTitle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 25, 16, 0),
      child: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => widget.homeviewmodel,
        child: Consumer<HomeViewModel>(
          builder: (context, value, child) {
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value.title.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'lib/res/images/lecsens_logo.png',
                  height: 30.0,
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
