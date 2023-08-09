

class TextFieldWidget extends StatelessWidget {

  final TextInputType? inputType;
  final String? title;
  final String? initialValue;
  final bool? isPasswordHide;
  final bool? isEnabled;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const TextFieldWidget({Key? key,this.inputType,required this.title,this.initialValue,this.isPasswordHide,this.isEnabled,this.readOnly,this.validator,this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      enabled: isEnabled,
      initialValue: initialValue,
      onChanged: onChanged,
      obscureText: isPasswordHide ?? false,
      keyboardType: inputType ?? TextInputType.text,
      validator: validator,
      decoration: InputDecoration(
        hintText: title,
        isDense:true,
        contentPadding: EdgeInsets.only(left: 10.w,bottom: 7.h),
        hintStyle: TextStyle(
            color: AppColors.normalGreyColor,
            fontWeight: FontWeight.w400,
            fontSize: 12.sp
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 3, color: Color(0xffF5F5F5)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color:Colors.grey),
        ),
      ),
    );
  }
}
