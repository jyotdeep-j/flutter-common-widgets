

class DrawerWidget extends StatelessWidget {

  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       return Drawer(
          backgroundColor: AppColors.appBarColor4,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 120.h,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            child:
                            const Icon(Icons.clear, color: Colors.white)),
                      ),
                      Text(
                        'Header',
                        style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 0,
                thickness: 2,
                color: AppColors.dividerColor,
              ),
              ItemWidget('Home 1', onTap: () {
              },),
              const Divider(
                height: 0,
                thickness: 0.5,
                color: AppColors.dividerColor,
              ),
              ItemWidget('Home 2', onTap: () {
              },),
              const Divider(
                height: 0,
                thickness: 0.5,
                color: AppColors.dividerColor,
              ),
              ItemWidget('Home 3', onTap: () {
              },),
              const Divider(
                height: 0,
                thickness: 0.5,
                color: AppColors.dividerColor,
              ),
              ItemWidget('Home 4', onTap: () {
              },),
              const Divider(
                height: 0,
                thickness: 0.5,
                color: AppColors.dividerColor,
              ),
              ItemWidget('Home 5', onTap: () {
              },),
              const Divider(
                height: 0,
                thickness: 0.5,
                color: AppColors.dividerColor,
              ),
              ItemWidget('Home 6', onTap: () {
             
              },),
              const Divider(
                height: 0,
                thickness: 0.5,
                color: AppColors.dividerColor,
              ),
              ItemWidget('Home 7', onTap: () {
            
              },)
            ],
          ),
        );
  
  }

}

class ItemWidget extends StatelessWidget {
  String title;
  VoidCallback onTap;
  ItemWidget(this.title, {Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 68,
      margin: EdgeInsets.only(left: 15.w),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
        onTap: () {
          Navigator.pop(context);
          onTap();
        },
      ),
    );
  }
}

