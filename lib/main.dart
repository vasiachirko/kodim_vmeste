// lib/main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const KodimVmesteApp());
}

class KodimVmesteApp extends StatelessWidget {
  const KodimVmesteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кодим вместе',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const IdeasScreen(),
    );
  }
}

class IdeasScreen extends StatelessWidget {
  const IdeasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Кодим вместе')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Трекер привычек с напоминаниями',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Хочу простое приложение без рекламы. Главное — пуш в 21:00, если не отметил выполнение',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Теги
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: const Text('flutter'), backgroundColor: Colors.deepPurple.shade50),
                      Chip(label: const Text('напоминания'), backgroundColor: Colors.deepPurple.shade50),
                      Chip(label: const Text('продуктивность'), backgroundColor: Colors.deepPurple.shade50),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Город + награда
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: const Text('Москва'), backgroundColor: Colors.grey.shade200),
                      Chip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.local_pizza, size: 18),
                            SizedBox(width: 4),
                            Text('Пицца'),
                          ],
                        ),
                        backgroundColor: Colors.orange.shade100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Нижняя строка
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: [
                          Chip(
                            label: const Text('Ищу разработчика'),
                            backgroundColor: Colors.orange.shade100,
                          ),
                          Chip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.star, size: 16, color: Colors.green),
                                SizedBox(width: 4),
                                Text('Для новичка'),
                              ],
                            ),
                            backgroundColor: Colors.green.shade100,
                          ),
                          Chip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.favorite, size: 16, color: Colors.pink),
                                SizedBox(width: 4),
                                Text('Готов учить'),
                              ],
                            ),
                            backgroundColor: Colors.pink.shade100,
                          ),
                        ],
                      ),

                      Row(
                        children: const [
                          Icon(Icons.arrow_upward, color: Colors.green, size: 24),
                          SizedBox(width: 4),
                          Text('24', style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(width: 12),
                          Icon(Icons.arrow_downward, color: Colors.red, size: 24),
                          SizedBox(width: 4),
                          Text('2'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Плюсик работает!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}