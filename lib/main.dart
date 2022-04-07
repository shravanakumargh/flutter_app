import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:krishworks_flutter_app/screens/aboutUs.dart';
import 'package:krishworks_flutter_app/screens/home.dart';
import 'package:krishworks_flutter_app/screens/settingsScreen.dart';
import 'package:krishworks_flutter_app/screens/updates.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (orientation.name == "landscape") {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ]);
      }
      return const MaterialApp(
        title: 'Krishworks',
        home: MyHomePage(),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff002633),
        title: Container(
            height: 50,
            width: 400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Creates border
                color: Colors.blue),
            padding: const EdgeInsets.all(10),
            child: Center(
                child: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Creates border
                  color: Colors.white),
              indicatorColor: Colors.black,
              labelStyle: const TextStyle(color: Colors.blue),
              controller: _tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.white,
              automaticIndicatorColorAdjustment: true,
              tabs: const [
                Tab(text: "Home"),
                Tab(text: "About us"),
                Tab(text: "Updates"),
              ],
            ))),
        leading: IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              size: 36,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Center(
                      widthFactor: 50,
                      child: Container(
                          width: 500,
                          height: 200,
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: OtpTextField(
                              numberOfFields: 6,

                              showFieldAsBox: true,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              keyboardType: TextInputType.number,
                              autoFocus: true,

                              onCodeChanged: (String code) {
                                //handle validation or checks here
                              },

                              onSubmit: (String verificationCode) {
                                DateTime dateTime = DateTime.now();

                                var passcode = dateTime.day *
                                    dateTime.month *
                                    dateTime.year;

                                var pass = passcode.toString();
                                if (pass.length != 6) {
                                  pass = "0" * (6 - pass.length) + pass;
                                }
                                if (verificationCode == pass) {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingsPage()),
                                  );
                                }
                              }, // end onSubmit
                            ),
                          ))));
            }),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomeScreen(),
          AboutUsScreen(),
          UpdatesScreen(),
        ],
      ),
    );
  }
}
