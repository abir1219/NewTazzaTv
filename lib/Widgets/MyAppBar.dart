import 'package:flutter/material.dart';
import 'package:new_tazza_tv_flutter/Screens/Dashboard.dart';

class MyAppBar extends StatefulWidget  with PreferredSizeWidget{
  final strState;
  const MyAppBar({Key? key, this.strState}) : super(key: key);

  @override
  State<MyAppBar> createState() {
    return _MyAppBarState();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF196df9),
      leadingWidth: 120,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 73, 32, 188)
            ],
          ),
        ),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(
                  indexing: 0,
                ),
              ));
        },
        child: Container(
          margin: const EdgeInsets.only(left: 5),
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
      title: Center(
          child: Text(
            widget.strState,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          )),
      actions: [
        const Icon(
          Icons.search,
          color: Colors.white,
          size: 28,
        ),
        const SizedBox(
          width: 15,
        ),
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _key.currentState!.openEndDrawer();
          },
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }
}
