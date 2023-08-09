
class AppBarWidget extends StatelessWidget {
  
  final String? title;
  final bool isBackEnable;
  final bool isDayEnable;
  final bool isResumeUpload;
  final VoidCallback? onMenuClick;

  const AppBarWidget({Key? key, this.title, this.isBackEnable = true,this.isResumeUpload=false,this.isDayEnable = false,this.onMenuClick})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return
      Container(
      height: 66.h,
      width: double.infinity,
      color: AppColors.appBarColor4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        }, child: Container(
                      width: 35,
                        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 7.h),
                        child: SvgPicture.asset(AppIcons.back,height: 20.h,))),
                    SizedBox(width: 10.w),
                    GestureDetector(
                        onTap: ()=>
                          onMenuClick!(),
                        child: SvgPicture.asset(AppIcons.menu,height: 30.h,)),
                  ],
                ),
              ),
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Abril',
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        Container(
                  margin: EdgeInsets.only(right: 20.w),
                    child: Badge(
                      isLabelVisible: count!="0"?true:false,
                      label: Text(count),
                      child: SvgPicture.asset(AppIcons.notification,height: 30.h,),
                    )),
        ],
      ),
    );
  }
}
