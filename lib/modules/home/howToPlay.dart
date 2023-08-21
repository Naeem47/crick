// import 'package:flutter/material.dart';
// import 'package:tempalteflutter/constance/themes.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class HowtoPlayScreen extends StatefulWidget {
//   @override
//   _HowtoPlayScreenState createState() => _HowtoPlayScreenState();
// }

// class _HowtoPlayScreenState extends State<HowtoPlayScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AllCoustomTheme.getThemeData().primaryColor,
//             AllCoustomTheme.getThemeData().primaryColor,
//             Colors.white,
//             Colors.white,
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: Stack(
//         children: <Widget>[
//           SafeArea(
//             child: Scaffold(
//               backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
//               body: Stack(
//                 alignment: AlignmentDirectional.bottomCenter,
//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[
//                       Container(
//                         color: AllCoustomTheme.getThemeData().primaryColor,
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               height: AppBar().preferredSize.height,
//                               child: Row(
//                                 children: <Widget>[
//                                   Material(
//                                     color: Colors.transparent,
//                                     child: InkWell(
//                                       onTap: () {
//                                         Navigator.pop(context);
//                                       },
//                                       child: Container(
//                                         width: AppBar().preferredSize.height,
//                                         height: AppBar().preferredSize.height,
//                                         child: Icon(
//                                           Icons.close,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Center(
//                                       child: Text(
//                                         'How To Play',
//                                         style: TextStyle(
//                                           fontFamily: 'Poppins',
//                                           fontSize: 24,
//                                           fontStyle: FontStyle.italic,
//                                           fontWeight: FontWeight.w500,
//                                           color: AllCoustomTheme.getThemeData()
//                                               .backgroundColor,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     width: AppBar().preferredSize.height,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Builder(
//                           builder: (BuildContext context) {
//                             return WebView(
//                               initialUrl:
//                                   'https://starsportsfantasy.com/Fantasy/howtoplay',
//                               javascriptMode: JavascriptMode.unrestricted,
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
