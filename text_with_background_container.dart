

class TextContainerWidget extends StatelessWidget {

  final String title;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Alignment? alignment;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final List<Color>? color;
  final VoidCallback? onTap;
  
  const TextContainerWidget(this.title, {Key? key,this.onTap,this.width,this.height,this.textStyle,this.alignment,this.borderRadius,this.padding,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onTap!(),
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 31.h,
        alignment: alignment ?? Alignment.centerLeft,
        padding: padding ?? EdgeInsets.only(left: 30.w),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(6.r)),
           gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: color ?? [Color(0xffFFFEFE),Color(0xffD9D9D9)]
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: const Offset(0,3)
            )
          ],
        ),
        child: Text(
          title,
          style: textStyle ?? TextStyle(
              shadows:  [
                Shadow(
                  offset: const Offset(0, 4),
                  blurRadius: 5.0,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.buttonDarkGreenColor),
        ),
      ),
    );
  }
}