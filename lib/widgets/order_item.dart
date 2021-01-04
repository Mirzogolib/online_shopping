import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shopping/models/order.dart';
import 'dart:math';

class OrderItem extends StatefulWidget {
  final Order order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height:
          _expanded ? min(widget.order.products.length * 20.0 + 130, 180) : 100,
      duration: Duration(milliseconds: 300),
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.order.amount}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(
                  widget.order.dateTime,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                ),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: _expanded
                    ? min(widget.order.products.length * 20.0 + 30, 140)
                    : 0,
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  children: widget.order.products
                      .map(
                        (product) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${product.quantity}x \$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      )
                      .toList(),
                ))
          ],
        ),
      ),
    );
  }
}
