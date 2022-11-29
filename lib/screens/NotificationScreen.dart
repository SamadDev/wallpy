// import 'package:flutter/material.dart';
// import 'package:new_wallpaper/localization/language.dart';
// import 'package:provider/provider.dart';
// import 'package:super_hero_client/Helper/AppData.dart';
// import 'package:super_hero_client/Models/NotificationModel.dart';
// import 'package:super_hero_client/Providers/OtherProvider.dart';
//
// class NotificationScreen extends StatelessWidget {
//   static const String route = '/NotificationScreen';
//
//   @override
//   Widget build(BuildContext context) {
//     final languageCode =
//         Provider.of<Language>(context, listen: false).languageCode;
//     return Scaffold(
//
//       body: FutureBuilder<List<NotificationModel>>(
//         future: Provider.of<OtherProvider>(context, listen: false)
//             .getNotifications(),
//         builder: (context, snapshot) => snapshot.connectionState ==
//             ConnectionState.waiting
//             ? Center(child: CircularProgressIndicator())
//             : ListView.separated(
//           itemCount: snapshot.data!.length,
//           itemBuilder: (context, index) => ListTile(
//             leading: Icon(
//               !snapshot.data![index].state
//                   ? Icons.notifications_active
//                   : Icons.notifications,
//               color: !snapshot.data![index].state
//                   ? Colors.green
//                   : Colors.grey,
//             ),
//             title: Text(
//                 adOrderState[snapshot.data![index].title][languageCode]),
//             trailing: Text(
//               timeAgo(DateTime.parse(snapshot.data![index].createdAt),
//                   context),
//               style: textTheme(context).caption,
//             ),
//           ),
//           separatorBuilder: (context, index) => Divider(),
//         ),
//       ),
//     );
//   }
// }
//
// String timeAgo(DateTime d, BuildContext context) {
//   Duration diff = DateTime.now().difference(d);
//   if (diff.inDays > 365)
//     return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "${words(context)["year"]}" : "${words(context)["years"]}"} ${words(context)["ago"]}";
//   if (diff.inDays > 30)
//     return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "${words(context)["month"]}" : "${words(context)["months"]}"} ${words(context)["ago"]} ";
//   if (diff.inDays > 7)
//     return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "${words(context)["week"]}" : "${words(context)["weeks"]}"} ${words(context)["ago"]} ";
//   if (diff.inDays > 0)
//     return "${diff.inDays} ${diff.inDays == 1 ? "${words(context)["day"]}" : "${words(context)["days"]}"} ${words(context)["ago"]} ";
//   if (diff.inHours > 0)
//     return "${diff.inHours} ${diff.inHours == 1 ? "${words(context)["hour"]}" : "${words(context)["hours"]}"} ${words(context)["ago"]} ";
//   if (diff.inMinutes > 0)
//     return "${diff.inMinutes} ${diff.inMinutes == 1 ? "${words(context)["minute"]}" : "${words(context)["minutes"]}"} ${words(context)["ago"]} ";
//   return "${words(context)["just-now"]}";
// }
