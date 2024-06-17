import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lipi/colors.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontsize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;

  const AppText(
      {super.key,
      required this.text,
      this.fontsize = 14,
      this.fontWeight = FontWeight.normal,
      this.color = Colors.black,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.montserrat(
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

class AppLargeText extends StatelessWidget {
  final String text;
  final double fontsize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;

  const AppLargeText(
      {super.key,
      required this.text,
      this.fontsize = 20,
      this.fontWeight = FontWeight.w600,
      this.color = Colors.black,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.montserrat(
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

class CurvedTextFields extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final double width;
  final double height;
  final Color? containerColor;
  final Color? textColor;
  final Color? hintColor;
  final int? maxLines;
  final int? maxLength;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;

  final double? fontSize;
  final FontWeight? fontWeight;

  const CurvedTextFields(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.obscureText,
      required this.keyboardType,
      required this.controller,
      required this.width,
      required this.height,
      this.containerColor = Colors.white,
      this.textColor = Colors.black,
      this.hintColor = Colors.grey,
      this.maxLines = 1,
      this.maxLength = 20,
      this.borderRadius = 10,
      this.borderWidth = 1.0,
      this.borderColor = Colors.white,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: TextField(
            style: GoogleFonts.montserrat(),
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: (value) {
              print(value);
            },
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              prefixIcon: icon,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: GoogleFonts.montserrat(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: hintColor,
              ),
            )));
  }
}

class MyButton extends StatelessWidget {
  void Function()? onPressed;
  final String text;
  final double? fontsize;
  final FontWeight? fontWeight;
  final Color? myTextColor;
  final Color? buttonColor;
  final double? height;
  final double? width;
  final double? borderRadius;

  MyButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.fontsize = 14,
      this.fontWeight = FontWeight.normal,
      this.myTextColor = textColor,
      this.buttonColor = secondaryColor,
      this.height = 50,
      this.width = 200,
      this.borderRadius = 10});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 246, 193, 189).withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: Center(
          child: AppText(
            text: text,
            color: myTextColor!,
            fontsize: 18,
          ),
        ),
      ),
    );
  }
}

class GPTTypingText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Duration speed;

  const GPTTypingText({
    Key? key,
    required this.text,
    this.textStyle = const TextStyle(fontSize: 16.0, color: Colors.white),
    this.speed = const Duration(milliseconds: 50),
  }) : super(key: key);

  @override
  State<GPTTypingText> createState() => _GPTTypingTextState();
}

class _GPTTypingTextState extends State<GPTTypingText>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: widget.text.length * widget.speed.inMilliseconds));
    _opacityAnim = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) => Opacity(
        opacity: _opacityAnim.value,
        child: Text(
          widget.text
              .substring(0, (_controller.value * widget.text.length).floor()),
          style: widget.textStyle,
        ),
      ),
    );
  }
}
