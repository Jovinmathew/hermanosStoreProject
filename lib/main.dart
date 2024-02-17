import 'package:flutter/material.dart';
import 'package:hermanos/components/thumbnail/component.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 85, 13, 210)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic>? _fetchedData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchDataFromApi();
  }

  Future<void> _fetchDataFromApi() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<dynamic> data = await fetchData();
      setState(() {
        _fetchedData = data;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching data: $error');
    }
  }

  Future<void> _sortDataFromApi() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<dynamic> data = await sortData();
      setState(() {
        _fetchedData = data;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error sorting data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
        sortData: _sortDataFromApi,
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _fetchedData == null
                ? const Text('No data found')
                : ListView.builder(
                    itemCount: _fetchedData!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_fetchedData![index]['title']),
                        subtitle: Text('\$${_fetchedData![index]['price']}'),
                        leading: StyledImage(
                            imageUrl: _fetchedData![index]
                                ['image']), // Placeholder icon
                      );
                    },
                  ),
      ),
    );
  }

  Future<List<dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> sortData() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products?sort=desc'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sort data: ${response.statusCode}');
    }
  }
}

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback sortData;

  const MyAppBar({Key? key, required this.title, required this.sortData})
      : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      leading: Row(
        children: [
          IconButton(
            onPressed: widget.sortData,
            icon: const Icon(Icons.filter_list),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              // Handle onPressed event for the sort icon
            },
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
    );
  }
}
