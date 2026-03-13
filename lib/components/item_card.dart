import 'package:flutter/material.dart';
import 'package:flutter_persona/model/product.dart';

class ItemCard extends StatelessWidget {
  final Product item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 7, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.vertical(
                top: Radius.circular(7),
              ),
              child: Image.network(item.image ?? ""),
            ),
          ),
          Text(
            item.title ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 1),
          Text(
            "${item.price}",
            style: TextStyle(fontWeight: FontWeight(600), fontSize: 15),
          ),
        ],
      ),
    );
  }
}
