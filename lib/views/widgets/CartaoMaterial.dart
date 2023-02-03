import 'package:flutter/material.dart';
import 'package:meuapp/utils.dart';
import '../../utils/Estilos.dart';

class CartaoMaterial extends StatefulWidget {
  const CartaoMaterial({super.key});

  @override
  State<CartaoMaterial> createState() => _CartaoMaterialState();
}

class _CartaoMaterialState extends State<CartaoMaterial> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // autogroupn67koCV (UDrF3YJLF5Z5iJsSrun67K)
      margin: EdgeInsets.fromLTRB(18, 0, 14, 393),
      width: double.infinity,
      height: 158,
      child: Container(
        // group48095601CVX (522:1806)
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // componentra5 (513:3301)
              margin: EdgeInsets.fromLTRB(0, 0, 0, 36),
              padding: EdgeInsets.fromLTRB(17, 17, 17, 17),
              width: double.infinity,
              decoration: BoxDecoration (
                border: Border.all(color: Estilos.preto),
                color: Estilos.branco,
              ),
              child: Text(
                'Óleo',
                style: SafeGoogleFont (
                  'Roboto',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.1725,
                  color: Estilos.preto,
                ),
              ),
            ),
            Container(
              // material232H (513:3302)
              margin: EdgeInsets.fromLTRB(11.97, 0, 19.03, 0),
              padding: EdgeInsets.fromLTRB(13, 13, 36.9, 12),
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration (
                color: Estilos.branco,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Estilos.preto,
                    offset: Offset(0, 1.8899999857),
                    blurRadius: 4.7350001335,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // recycleicon7RT (513:3305)
                    margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    width: 45,
                    height: 45,
                    child: Image.asset(
                      'assets/mobile/images/recycleicon-Hcu.png',
                      width: 45,
                      height: 45,
                    ),
                  ),
                  Container(
                    // autogroupk7a9XEH (UDrFybabQtq7nFMh13K7a9)
                    margin: EdgeInsets.fromLTRB(0, 7, 52.97, 4.5),
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // leoiZf (513:3304)
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 3.5),
                          child: Text(
                            'Óleo',
                            style: SafeGoogleFont (
                              'Roboto',
                              fontSize: 12.3067655563,
                              fontWeight: FontWeight.w900,
                              height: 1.1725,
                              letterSpacing: 0.4922706223,
                              color: Color(0xff130f26),
                            ),
                          ),
                        ),
                        Text(
                          // unidadetxtViq (513:3317)
                          'Litro',
                          style: SafeGoogleFont (
                            'Roboto',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.1725,
                            color: Estilos.preto,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // group480955943ds (513:3309)
                    margin: EdgeInsets.fromLTRB(0, 11, 0, 11.87),
                    height: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // group48095576Bdb (513:3311)
                          margin: EdgeInsets.fromLTRB(0, 0, 29.74, 0),
                          padding: EdgeInsets.fromLTRB(9, 0, 8.13, 0),
                          height: double.infinity,
                          decoration: BoxDecoration (
                            border: Border.all(color: Estilos.branco),
                            color: Estilos.branco,
                            borderRadius: BorderRadius.circular(11.0655736923),
                          ),
                          child: Text(
                            '-',
                            style: SafeGoogleFont (
                              'Roboto',
                              fontSize: 17.7049160004,
                              fontWeight: FontWeight.w400,
                              height: 1.1725,
                              color: Estilos.preto,
                            ),
                          ),
                        ),
                        Container(
                          // sPw (513:3310)
                          margin: EdgeInsets.fromLTRB(0, 0, 27.13, 0),
                          child: Text(
                            '1',
                            style: SafeGoogleFont (
                              'Roboto',
                              fontSize: 17.7049160004,
                              fontWeight: FontWeight.w400,
                              height: 1.1725,
                              color: Estilos.preto,
                            ),
                          ),
                        ),
                        Container(
                          // group48095575qzy (513:3314)
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          padding: EdgeInsets.fromLTRB(6, 0, 5.13, 0),
                          height: double.infinity,
                          decoration: BoxDecoration (
                            border: Border.all(color: Estilos.branco),
                            color: Estilos.branco,
                            borderRadius: BorderRadius.circular(11.0655736923),
                          ),
                          child: Text(
                            '+',
                            style: SafeGoogleFont (
                              'Roboto',
                              fontSize: 17.7049160004,
                              fontWeight: FontWeight.w400,
                              height: 1.1725,
                              color: Estilos.preto,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}