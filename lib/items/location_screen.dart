import 'package:flutter/material.dart';

import '../util/common_card.dart';
import '../util/common_search_bar.dart';
import '../util/remove_focuse.dart';
import '../util/time_zone_utils.dart';
import '../util/utility.dart';

class LocationList extends StatefulWidget {
  final String selectedLocation;

  const LocationList({super.key, required this.selectedLocation});

  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  List<String> timezoneList = [];
  final myController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    timezoneList = TimeZoneUtils.getTimeZoneLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(silver),
        appBar: buildAppBar(context),
        body: RemoveFocuse(
            onClick: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 24,
                                right: 24,
                                top: 16,
                                bottom: 16,
                              ),
                              child: CommonCard(
                                color: const Color(silver),
                                radius: 36,
                                child: CommonSearchBar(
                                  text: "Search TimeZone",
                                  iconData: Icons.search,
                                  enabled: true,
                                  textEditingController: myController,
                                ),
                              ),
                            )
                          ] +
                          getListView(
                              myController.text.toLowerCase().toString()),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(silver),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(purple),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        "World Clock",
        style: kTopRowTextStyle,
      ),
    );
  }

  List<Padding> getListView(String searchValue) {
    var finalList = [];

    if (searchValue.isNotEmpty) {
      finalList = getSearchTimeZoneList(searchValue);
    } else {
      finalList = timezoneList;
    }

    List<Padding> listView = [];
    for (int index = 0; index < finalList.length; index++) {
      listView.add(Padding(
        padding: const EdgeInsets.all(10),
        child: PhysicalModel(
            color: const Color(silver),
            elevation: 18,
            shadowColor: const Color(silver).withOpacity(0.9),
            borderRadius: BorderRadius.circular(30),
            child: ListTile(
              title: Text(
                finalList[index],
                style: widget.selectedLocation == finalList[index]
                    ? kSelectedTextStyle
                    : kTopRowTextStyle,
              ),
              onTap: () {
                Navigator.pop(context, finalList[index]);
              },
              leading: CircleAvatar(
                backgroundColor: Colors.purple,
                child: Text(index.toString()),
              ),
            )),
      ));
    }
    return listView;
  }

  List getSearchTimeZoneList(String searchValue) {
    return timezoneList
        .where((element) => element.toLowerCase().contains(searchValue))
        .toList();
  }
}
