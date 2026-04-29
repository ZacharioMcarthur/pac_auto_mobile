import 'package:flutter/material.dart';

class CustomTabView extends StatelessWidget {
  final List<Widget> tabViews;
  final List<String> tabTitles;
  final Color primaryColor;
  final Color secondaryColor;
  final Color labelColor;
  final double tabFontSize;
  final double tabBarHeight;

  const CustomTabView({
    Key? key,
    required this.tabViews,
    required this.tabTitles,
    required this.primaryColor,
    required this.secondaryColor,
    required this.labelColor,
    this.tabFontSize = 20,
    this.tabBarHeight = 0.03, // You can customize the height ratio here
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    
    return Expanded(
      child: DefaultTabController(
        length: tabTitles.length,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: labelColor,
                indicator: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                labelColor: labelColor,
                labelStyle: TextStyle(
                  fontSize: tabFontSize,
                ),
                tabs: tabTitles
                    .map((title) => Tab(text: title))
                    .toList(),
              ),
            ),
            SizedBox(
              height: screenHeight * tabBarHeight,
            ),
            Expanded(
              child: TabBarView(
                children: tabViews,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
