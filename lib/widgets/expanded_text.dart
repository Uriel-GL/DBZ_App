import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandedText extends StatefulWidget {
  final String text;

  const ExpandedText({super.key, required this.text});

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  bool isTextExpanded = false;

  @override
  Widget build(BuildContext context) {
    
    var textPainter = TextPainter(
      text: TextSpan(text: widget.text),
      maxLines: 8,
      textDirection: TextDirection.ltr
    );

    textPainter.layout(maxWidth: 375);
    var maxLength = textPainter.maxLines! * 20;

    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        text: isTextExpanded
          ? widget.text
          : widget.text.length > maxLength 
            ? "${widget.text.substring(0, maxLength)}..."
            : widget.text,
        style: const TextStyle(
          fontFamily: 'Oswald',
          fontSize: 18,
          height: 1.5,
          color: Color(0xff1d1b20) //Color de texto por defecto
        ),
        children: [
          const TextSpan(text: " "),
          widget.text.length > maxLength
          ? TextSpan(
            text: isTextExpanded ? "Ver menos" : "Ver más",
            style: const TextStyle(
              fontFamily: 'Oswald',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xffF47A20),
              decoration: TextDecoration.underline,
              decorationColor: Color(0xffF47A20),
              decorationThickness: 0.8,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  isTextExpanded = !isTextExpanded;
                });
              }
          )
          : const TextSpan()
        ]
      ),
    );
  }
}
