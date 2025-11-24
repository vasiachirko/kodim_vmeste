import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const ProviderScope(child: KodimVmesteApp()));
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

class IdeasScreen extends ConsumerWidget {
  const IdeasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Кодим вместе')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Заголовок идеи
                  Text(
                    'Трекер привычек с напоминаниями',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),

                  // Короткое описание
                  Text(
                    'Хочу простое приложение, чтобы ставить цели на день и получать пуш в 21:00, если не отметил выполнение',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Теги + город + награда (в одной строке)
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Chip(
                          label: Text('Flutter'),
                          backgroundColor: Colors.deepPurple.shade50),
                      Chip(
                          label: Text('Москва'),
                          backgroundColor: Colors.grey.shade200),
                      Chip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.local_pizza, size: 16),
                            SizedBox(width: 4),
                            Text('Пицца'),
                          ],
                        ),
                        backgroundColor: Colors.orange.shade100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Статус внизу + голоса
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(
                          'Ищу разработчика',
                          style: TextStyle(color: Colors.orange.shade700),
                        ),
                        backgroundColor: Colors.orange.shade100,
                      ),
                      Row(
                        children: const [
                          Icon(Icons.arrow_upward,
                              color: Colors.green, size: 20),
                          Text('24'),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_downward,
                              color: Colors.red, size: 20),
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
