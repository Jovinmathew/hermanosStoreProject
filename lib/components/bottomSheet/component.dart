import 'package:flutter/material.dart';

class FilterBottomSheet extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onSelectCategory;
  final VoidCallback onReset;
  final Function(String) onSort;

  const FilterBottomSheet({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelectCategory,
    required this.onReset,
    required this.onSort,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            trailing: TextButton(
              child: Text('Reset'),
              onPressed: onReset,
            ),
            leading: Icon(Icons.filter_alt),
            title: Text('Filter Categories'),
          ),
          Wrap(
            spacing: 8.0,
            children: categories
                .map(
                  (category) => ElevatedButton(
                    onPressed: () => onSelectCategory(category),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedCategory == category ? Colors.black : null,
                    ),
                    child: Text(category),
                  ),
                )
                .toList(),
          ),
          ListTile(
            leading: Icon(Icons.swap_vert),
            title: Text('Sort By'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => onSort('asc'),
                child: Text('Ascending'),
              ),
              ElevatedButton(
                onPressed: () => onSort('desc'),
                child: Text('Descending'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
