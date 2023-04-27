import 'package:alert_up_user/provider/user_provider.dart';
import 'package:alert_up_user/utilities/constants.dart';
import 'package:alert_up_user/widgets/image_view.dart';
import 'package:alert_up_user/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CHOUpdates extends StatefulWidget {
  CHOUpdates({Key? key}) : super(key: key);

  @override
  State<CHOUpdates> createState() => _PostersState();
}

class _PostersState extends State<CHOUpdates> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).getPosterList(
          callback: (code, message) {
        if (code != 200) {
          launchSnackbar(context: context, mode: "ERROR", message: message);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider adminProvider = context.watch<UserProvider>();
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: adminProvider.loading == "poster_list"
          ? const Center(
              child: CircularProgressIndicator(
              color: ACCENT_COLOR,
              strokeWidth: 2,
            ))
          : GridView.builder(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 20, bottom: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: .65,
                  crossAxisCount: width < 700
                      ? 2
                      : width < 1000
                          ? 3
                          : width < 1400
                              ? 4
                              : 5),
              itemCount: adminProvider.posters.length,
              itemBuilder: (context, index) {
                Object? value = adminProvider.posters[index].value;
                Map poster = value is Map ? value : {};

                return InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            child: ImageViewer(
                                photos: List<String>.from(adminProvider.posters
                                    .map((e) => (e.value as Map)['imageUrl'])
                                    .toList()),
                                index: index)));
                  },
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(children: [
                        Expanded(
                            child: Text(
                          DateFormat()
                              .format(DateTime.parse(poster['createdAt'])),
                          maxLines: 1,
                          style: TextStyle(fontSize: 10),
                        )),
                      ]),
                    ),
                    Expanded(
                      child: Image.network(
                        poster['imageUrl'] ?? USER_PLACEHOLDER_IMAGE,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ]),
                );
              }),
    );
  }
}
