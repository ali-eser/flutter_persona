import 'package:flutter/material.dart';
import 'package:flutter_persona/model/product.dart';

class ItemPage extends StatefulWidget {
  final Product item;
  final Set<int> itemIds;

  const ItemPage({super.key, required this.item, required this.itemIds});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.item.title ?? "Item"),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.item.image ?? "",
                height: 250,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
              SizedBox(height: 20),
              Text(
                widget.item.title ?? "",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight(600),
                  letterSpacing: -1,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "${widget.item.rating?.rate.toString()} from ${widget.item.rating?.count.toString()} reviews",
                style: TextStyle(fontWeight: FontWeight(500), fontSize: 17),
              ),
              SizedBox(height: 10),
              Text(
                widget.item.description ?? "",
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, letterSpacing: -0.35),
              ),
              SizedBox(height: 5),
              Text(
                "US\$${widget.item.price.toString()}",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight(500)),
              ),
              Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.itemIds.add(widget.item.id ?? 0);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Successfully added to cart!"),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: 80, left: 20, right: 20),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  "Add to cart",
                  style: TextStyle(
                    fontWeight: FontWeight(700),
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
