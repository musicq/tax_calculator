import 'package:flutter/material.dart';

class _Cell extends StatelessWidget {
  final String title;
  final bool primary;

  const _Cell({this.title, this.primary = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(color: primary ? Colors.white : Colors.black),
      ),
    );
  }
}

class CTable extends StatelessWidget {
  final List<String> titles;
  final List<List<String>> rows;

  CTable({this.titles, this.rows})
      : assert(titles != null),
        assert(rows != null),
        assert(rows.every((row) => row.length == titles.length));

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        color: Colors.white,
        child: Table(
          border: TableBorder(
            horizontalInside: BorderSide(
              color: Colors.black26,
            ),
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(color: Colors.indigo[300]),
              children: titles
                  .map((title) => _Cell(
                        title: title,
                        primary: true,
                      ))
                  .toList(),
            ),
            for (var row in rows)
              TableRow(children: row.map((item) => _Cell(title: item)).toList())
          ],
        ),
      ),
    );
  }
}
