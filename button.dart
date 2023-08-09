
class ButtonWidget extends StatelessWidget {

  final String title;
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsets? margin;
  final String? icon;
  final Color? buttonColor;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  
  ButtonWidget({Key? key,
    required this.title,
    this.width,
    this.height,
    this.radius,
    this.margin,
    this.icon,
    this.buttonColor,
    this.textStyle,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: Container(
        margin: margin,
        alignment: Alignment.center,
        width: width ?? 162.w,
        height: height ?? 27.h,
        decoration: BoxDecoration(
            color: buttonColor ?? AppColors.buttonColor,
            borderRadius: BorderRadius.circular(radius ?? 20.r),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0.5, 1)
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: textStyle ?? TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            SvgPicture.asset(icon ?? '')
          ],
        ),
      ),
    );
  }
}
