import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qr_scan/components/scanners/QR_scan/qr_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ResultQR extends StatelessWidget {

  final code;
  final Function() closeScreen;

  const ResultQR({
    super.key,
    required this.closeScreen,
    required this.code
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            closeScreen();
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios_new_rounded,
          color: Colors.black87,
          )
        ),
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
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //show QR Code here...
            const Text(
              'Resultado escaneado',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox( height: 10.0),
            Text(
              code,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
            const SizedBox( height: 10.0 ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 1),
                      content: const Text(
                        '¡Copiado!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: bgColor,
                        ),
                      ),
                      backgroundColor: Colors.black,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)
                      ),
                    ),
                  );
                }, 
                 style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: StadiumBorder(),
                  elevation: 0,
                  side: const BorderSide(
                    width: 1,
                    color: Colors.blue
                  )
                ),
                child: const Text(
                  'Copiar',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}