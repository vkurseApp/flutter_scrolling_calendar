import 'package:flutter/material.dart';
import 'package:scrolling_years_calendar/month_view.dart';
import 'package:scrolling_years_calendar/utils/screen_sizes.dart';
import 'package:scrolling_years_calendar/year_title.dart';

class YearView extends StatelessWidget {
  const YearView({
    required this.context,
    required this.year,
    required this.currentDateColor,
    required this.monthNames,
    required this.onMonthTap,
    required this.monthTitleStyle,
    required this.daysColor,
  });

  final BuildContext context;
  final int year;
  final Color currentDateColor;
  final List<String> monthNames;
  final Function? onMonthTap;
  final TextStyle monthTitleStyle;
  final Color daysColor;

  double get horizontalMargin => 16.0;
  double get monthViewPadding => 8.0;

  Widget buildYearMonths(BuildContext context) {
    final List<Row> monthRows = <Row>[];
    final List<MonthView> monthRowChildren = <MonthView>[];

    for (int month = 1; month <= DateTime.monthsPerYear; month++) {
      monthRowChildren.add(
        MonthView(
          context: context,
          year: year,
          month: month,
          padding: monthViewPadding,
          currentDateColor: currentDateColor,
          monthNames: monthNames,
          onTap: onMonthTap,
          titleStyle: monthTitleStyle,
          daysColor: daysColor,
        ),
      );

      if (month % 2 == 0) {
        monthRows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<MonthView>.from(monthRowChildren),
          ),
        );
        monthRowChildren.clear();
      }
    }

    return Column(
      children: List<Row>.from(monthRows),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getYearViewHeight(context),
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: horizontalMargin,
              vertical: 0.0,
            ),
            child: YearTitle(year),
          ),
          Container(
            margin: EdgeInsets.only(
              left: horizontalMargin,
              right: horizontalMargin,
              top: 8.0,
            ),
            child: const Divider(
              color: Colors.black26,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: horizontalMargin - monthViewPadding,
              vertical: 0.0,
            ),
            child: buildYearMonths(context),
          ),
        ],
      ),
    );
  }
}
