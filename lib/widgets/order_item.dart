import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as od;

class OrderItem extends StatefulWidget {
  final od.OrderItem order;
  const OrderItem(this.order, {Key? key}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  bool sysTheme = ThemeData.light().useMaterial3;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: sysTheme == true ? Colors.white : Colors.grey[800],
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text(
            '\$${widget.order.amount!.toStringAsFixed(2)}',
            style: TextStyle(
                color: sysTheme == true ? Colors.black : Colors.white),
          ),
          subtitle: Text(
            DateFormat('dd MMMM, yyyy hh:mm a').format(widget.order.dateTime!),
            style: TextStyle(
                color: sysTheme == true ? Colors.black : Colors.white),
          ),
          trailing: IconButton(
            icon: _expanded
                ? Icon(
                    Icons.expand_more,
                    color: sysTheme == true ? Colors.black : Colors.white,
                  )
                : Icon(
                    Icons.expand_less,
                    color: sysTheme == true ? Colors.black : Colors.white,
                  ),
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
        ),
        if (_expanded)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            height: min(widget.order.products!.length * 20.0 + 100, 180),
            child: ListView(
              children: widget.order.products!
                  .map(
                    (prod) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            prod.title!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: sysTheme == true
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            '${prod.quantity!} x \$${prod.price!}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
      ]),
    );
  }
}
