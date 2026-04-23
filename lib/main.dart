import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppMovilWidgets',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final PageController _pageController = PageController();
  double _progress = 0.0;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView y ProgressBar'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  _progress = (index + 1) / 3.0;
                });
              },
              children: const [
                Center(child: Text('Página 1', style: TextStyle(fontSize: 24))),
                Center(child: Text('Página 2', style: TextStyle(fontSize: 24))),
                Center(child: Text('Página 3', style: TextStyle(fontSize: 24))),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _currentPage > 0
                    ? () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    : null,
                child: const Text('Anterior'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _currentPage < 2
                    ? () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    : null,
                child: const Text('Siguiente'),
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Text('ProgressBar Lineal:', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 40),
          const Text('ProgressBar Circular:', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              value: _progress,
              strokeWidth: 6,
            ),
          ),
          const SizedBox(height: 20),
          Text('Progreso: ${(_progress * 100).toInt()}%'),
        ],
      ),
    );
  }
}