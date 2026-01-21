import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestione Orari',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestione Orari'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: const Text('Aggiungi Servizio'),
                leading: const Icon(Icons.add_circle, color: Colors.blue),
                onTap: () {
                  // Naviga alla schermata "Aggiungi Servizio"
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: const Text('Aggiungi Utente'),
                leading: const Icon(Icons.person_add, color: Colors.green),
                onTap: () {
                  // Naviga alla schermata "Aggiungi Utente"
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: const Text('Esporta Prospetto'),
                leading: const Icon(Icons.file_download, color: Colors.orange),
                onTap: () {
                  // Naviga alla schermata "Esporta Prospetto"
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: const Text('Calcola Orario'),
                leading: const Icon(Icons.calculate, color: Colors.red),
                onTap: () {
                  // Naviga alla schermata "Calcola Orario"
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}