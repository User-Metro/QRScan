import 'package:flutter/material.dart';
import 'package:flutter_qr_scan/components/scanners/QR_scan/qr_scanner.dart';
import 'package:flutter_qr_scan/components/scanners/BAR_scan/bar_scanner.dart';

const bgColor = Colors.white;

class NavigatorScan extends StatefulWidget {
  const NavigatorScan({super.key});

  @override
  State<NavigatorScan> createState() => _NavigatorScanState();
}

class _NavigatorScanState extends State<NavigatorScan> {

  int currentPageIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    // QR Scanner
    QRscanner(),

    //Bar Scanner
    BarScanner(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(currentPageIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //unselectedLabelStyle: const TextStyle(color: Colors.white, fontSize: 16),
        //selectedFontSize: 18.0,
        backgroundColor: bgColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code, size: 30),
            label: 'QR Scan',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.barcode_reader, size: 30),
            label: 'Bar Scan',
          ),
        ],
        currentIndex: currentPageIndex,
        selectedItemColor: Color.fromARGB(255, 19, 115, 224),
        onTap: _onItemTapped,
      ),
    );
  }
}