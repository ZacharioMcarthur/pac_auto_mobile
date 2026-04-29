import 'package:flutter/material.dart';

class CustomListViewBuilder<T> extends StatelessWidget {
  final List<T> items;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry? padding;
  final bool? isSeparated;
  final IndexedWidgetBuilder? separatorBuilder;
  final ScrollPhysics? physics;

  const CustomListViewBuilder({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.padding,
    this.isSeparated = false,
    this.separatorBuilder,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSeparated == true
        ? ListView.separated(
            padding: padding,
            physics: physics,
            itemCount: items.length,
            itemBuilder: itemBuilder,
            separatorBuilder: separatorBuilder ??
                (context, index) => const Divider(
                      thickness: 1,
                    ),
          )
        : ListView.builder(
            padding: padding,
            physics: physics,
            itemCount: items.length,
            itemBuilder: itemBuilder,
          );
  }
}
