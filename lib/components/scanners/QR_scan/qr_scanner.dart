import 'package:flutter/material.dart';
import 'package:flutter_qr_scan/components/scanners/QR_scan/result_qr.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
//import 'package:mobile_scanner/mobile_scanner.dart';

const bgColor = Colors.white;

class QRscanner extends StatefulWidget {
  const QRscanner({super.key});

  @override
  State<QRscanner> createState() => _QRscannerState();
}

class _QRscannerState extends State<QRscanner> {

  final GlobalKey _globalkey = GlobalKey();
  QRViewController? controller;
  Barcode? result;

  bool isScanCompleted = false;
  //bool isFlashOn = false;
  //bool isFrontCamera = false;
  //MobileScannerController controllers = MobileScannerController();

  void scanQr(QRViewController controller) {
    controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }

  void closeScreen(){
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              /*setState(() {
                isFlashOn =! isFlashOn;
              });
              controller?.toggleFlash();*/
            }, 
            icon: const Icon(Icons.flash_on, 
              color:  Colors.grey,
              size: 30,
            )
          ),
        ],
        centerTitle: true,
        title: const Text(
          'Escáner QR',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child:  Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Coloque el código adentro del recuadro',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'El escaneo comenzará automáticamente',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54
                    ),
                  )
                ],
              )
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.blue, spreadRadius: 3),
                        ],
                      ),
                      height: 222,
                      width: 222,
                      child: QRView(
                        key: _globalkey,
                        onQRViewCreated: scanQr
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (result != null) {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => ResultQR(
                                closeScreen: closeScreen,
                                code: result!.code,
                              )
                            )
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: StadiumBorder(),
                        elevation: 0,
                      ),
                      child: (result?.code) != null 
                        ? const Text(
                          '¡Ver resultado!',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16.0,
                            decoration: TextDecoration.underline,
                          ),
                        ) 
                        : null,
                    ),
                  ],
                ),
              )
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Version 0.0.1',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}