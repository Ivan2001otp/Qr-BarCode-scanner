import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatelessWidget {
  final double? width;
  final double? heigth;

  final double? qrSize;
  final String qrData;
  //helps to add extra pixel in size,default value is true.
  final bool? gapLess;

  final int? qrVersion;

  final double? qrPadding;

  final double? qrBorderRadius;

  final String? semanticsLabel;

  final Color? qrBackgroundColor;

  final Color? qrForegroundColor;

  const QRCode({
    this.width,
    this.heigth,
    this.qrSize,
    this.gapLess,
    required this.qrData,
    this.qrVersion,
    this.qrPadding,
    this.qrBorderRadius,
    this.qrBackgroundColor,
    this.qrForegroundColor,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadius.circular(qrBorderRadius ?? 0),
      child: QrImageView(
        data: qrData,
        size: qrSize,
        gapless: gapLess ?? true,
        version: qrVersion ?? QrVersions.auto, //automaticallyl assigns version.
        padding: EdgeInsets.all(qrPadding ?? 0),
        semanticsLabel: semanticsLabel ?? '',
        backgroundColor: qrBackgroundColor ?? Colors.transparent,
        eyeStyle: QrEyeStyle(color: qrForegroundColor ?? Colors.transparent),
        dataModuleStyle:
            QrDataModuleStyle(color: qrForegroundColor ?? Colors.transparent),
        // foregroundColor: qrForegroundColor ?? Colors.transparent,
      ),
    );
  }


}
