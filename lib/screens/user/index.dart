import 'package:alert_up_user/screens/user/cho_updates.dart';
import 'package:alert_up_user/screens/user/geofence.dart';
import 'package:alert_up_user/screens/user/user_device_id.dart';
import 'package:alert_up_user/utilities/constants.dart';
import 'package:alert_up_user/widgets/button.dart';
import 'package:alert_up_user/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';

class UserHome extends StatefulWidget {
  UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBar(context, title: "Alert Up", centerTitle: true, actions: [
        Button(
            icon: Icons.person_pin,
            label: "Your ID",
            borderColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            textColor: ACCENT_COLOR,
            onPress: () async {
              String? deviceId = await PlatformDeviceId.getDeviceId;
              if (!mounted) return;
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                        child: UserDeviceId(
                          uniqueId: deviceId!,
                        ),
                      ));
            })
      ]),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
            controller: tabController,
            indicator: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.red, width: 2),
              ),
            ),
            unselectedLabelColor: Colors.grey,
            labelColor: ACCENT_COLOR,
            tabs: const [
              Tab(icon: Icon(Icons.new_label_sharp), text: 'CHO Updates'),
              Tab(icon: Icon(Icons.near_me_rounded), text: 'Geofence'),
            ]),
      ),
      body: TabBarView(
          controller: tabController, children: [CHOUpdates(), GeoFence()]),
    );
  }
}
