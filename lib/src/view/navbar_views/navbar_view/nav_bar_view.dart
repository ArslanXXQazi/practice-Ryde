import 'package:practice_ryde/src/controllers/constants/linker.dart';
import 'package:practice_ryde/src/view/navbar_views/history_nav_view/ride_history_nav_view/history_nav_view.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({super.key});

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  int _selectedIndex=0;
  bool selectscreen=true;
  bool profileview=true;
  void navOntap(int index)
  {
    setState(() {
      _selectedIndex=index;
    });
  }

  List  widgetOptions=
      [
        HomeNavView(),
        NotificationNavViews(),
        RideHistoryNavView(ontap: (){},),
        ProfileNavView(ontap: (){},),
        HistoryDetailView(image: Appimages.soloCar, carType: "sdf", location: "dfdf", date: "sdfsdf", price: "sdfsd", ontap: (){}),
        EditProfileView(image: Appimages.arslan,ontap: (){},),
      ];


  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body:
      _selectedIndex==2 ?(selectscreen==true?RideHistoryNavView(ontap: (){setState(() {selectscreen=false;});}):
      HistoryDetailView(image: Appimages.soloCar, carType: "Solo (1-4)", location: "Islamabad shopping mall", date: "12 sep 2023", price: "75", ontap: (){
        setState(() {selectscreen=true;});
      })): _selectedIndex==3?(profileview==true?ProfileNavView(ontap: (){setState((){profileview=false;});}):
          EditProfileView(image: Appimages.arslan,ontap: (){setState(() {profileview=true;});},))
     : widgetOptions.elementAt(_selectedIndex),
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar:
      Padding(
        padding: EdgeInsets.only(bottom: height*.02,right: width*.04,left: width*.04),
        child: Container(
          height: height*.09,
          decoration: BoxDecoration(
            color: Appcolor.yellow,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BottomNavigationBar(
              backgroundColor: Appcolor.yellow,
              currentIndex: _selectedIndex,
                onTap: navOntap,
                selectedItemColor: Colors.white,
               selectedFontSize: 12,
               selectedIconTheme:IconThemeData(color: Colors.white,size: 35),
               showSelectedLabels: true,
               showUnselectedLabels: false,
                unselectedItemColor: Colors.white60,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: TextStyle(
                  fontFamily: 'satoshi_bold'
                ),
                items:
                [
                  // BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                  // BottomNavigationBarItem(icon: Icon(Icons.notifications),label: 'Notification'),
                  // BottomNavigationBarItem(icon: ImageIcon(AssetImage(Appimages.page)),label: 'History'),
                  // BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: 'Profile'),

                  BottomNavigationBarItem(icon: ImageIcon(AssetImage(Appimages.homeNav),),label: 'Home'),
                  BottomNavigationBarItem(icon: ImageIcon(AssetImage(Appimages.notificationNav)),label: 'Notification'),
                  BottomNavigationBarItem(icon: ImageIcon(AssetImage(Appimages.historyNav)),label: 'History'),
                  BottomNavigationBarItem(icon: ImageIcon(AssetImage(Appimages.profileNav)),label: 'Profile'),

                ]
            ),
          ),
        ),
      )
    );
  }
}
