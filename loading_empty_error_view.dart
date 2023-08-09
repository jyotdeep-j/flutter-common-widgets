

//Loading View
class CircleViewWidget extends StatelessWidget {

  const CircleViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:const Center(
          child:  CircularProgressIndicator(color: AppColors.appThemeColor)
        ));
  }
}

//Error View
class ErrorViewWidget extends StatelessWidget {

  const ErrorViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:Center(
          child: Text('Something went wrong',
      style: TextStyle(
            color: Colors.red,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500
      ),
    ),
   ));
  }
}


//Empty View
class EmptyViewWidget extends StatelessWidget {

   const EmptyViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(child:Text('No Data Found',
      style: TextStyle(
        color: Colors.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500
      ),
      )),
    );
  }
}


