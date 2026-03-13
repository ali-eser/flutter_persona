import 'package:flutter/material.dart';
import 'package:flutter_persona/components/item_card.dart';
import 'package:flutter_persona/model/product.dart';
import 'package:flutter_persona/services/api_service.dart';
import 'package:flutter_persona/views/cart.dart';
import 'package:flutter_persona/views/item_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  bool isLoading = false;
  String errMsg = "";
  List<Product> items = [];
  ApiService api = ApiService();
  final Set<int> itemIds = {};

  @override
  void initState() {
    loadItems();
    super.initState();
  }

  Future<void> loadItems() async {
    try {
      setState(() {
        isLoading = true;
      });

      List<Product> response = await api.fetch();

      setState(() {
        items = response;
      });
    } catch (err) {
      setState(() {
        errMsg = "Something went wrong while loading products";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = items.where((element) {
      final name = element.title ?? "";
      return name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Persona Store",
                    style: TextStyle(
                      letterSpacing: -1.7,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CartView(items: items, itemIds: itemIds),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),

              SizedBox(height: 15),

              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 226, 228, 236),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 15),
              if (isLoading)
                Center(child: CircularProgressIndicator())
              else if (errMsg != "")
                Center(child: Text(errMsg))
              else
                Expanded(
                  child: GridView.builder(
                    itemCount: filteredItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ItemPage(item: item, itemIds: itemIds),
                            ),
                          );
                        },
                        child: ItemCard(item: item),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
