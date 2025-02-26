import 'package:practice_ryde/src/controllers/components/notification_container.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';

class NotificationNavViews extends StatelessWidget {
  const NotificationNavViews({super.key});

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: false,
        title: BoldText(text: 'Your Notifications',fontSize: 16,color:Theme.of(context).colorScheme.secondary,),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: width*.03),
            child: InkWell(
                onTap: (){},
                child: ImageIcon(AssetImage(Appimages.drawer,),size: width*.08,color: Theme.of(context).colorScheme.secondary,),),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*.03),
          child: Column(children: [
            NotificationContainer(
               onTap: (){},
               text: 'Your Rider is on his way',
               time: '5 min ago',
           ),
            NotificationContainer(
              onTap: (){},
              text: 'Your Ride has been cancelled',
              time: '2 day ago',
            ),
            NotificationContainer(
              onTap: (){},
              text: 'You have arrived at your destination',
              time: '5 min ago',
            ),
            NotificationContainer(
              onTap: (){},
              text: 'Your Rider is on his way',
              time: '5 min ago',
            ),
            NotificationContainer(
              onTap: (){},
              text: 'Your Rider is on his way',
              time: '5 min ago',
            )
          ],),
        ),
      ),
    );
  }
}
