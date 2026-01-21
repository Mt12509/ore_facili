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
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildCard(
              context,
              title: 'Aggiungi Servizio',
              icon: Icons.add_circle,
              color: Colors.blue,
              onTap: () {
                // Naviga alla schermata "Aggiungi Servizio"
              },
            ),
            _buildCard(
              context,
              title: 'Aggiungi Utente',
              icon: Icons.person_add,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddUserScreen(existingUsers: []),
                  ),
                );
              },
            ),
            _buildCard(
              context,
              title: 'Esporta Prospetto',
              icon: Icons.file_download,
              color: Colors.orange,
              onTap: () {
                // Naviga alla schermata "Esporta Prospetto"
              },
            ),
            _buildCard(
              context,
              title: 'Calcola Orario',
              icon: Icons.calculate,
              color: Colors.red,
              onTap: () {
                // Naviga alla schermata "Calcola Orario"
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class AddUserScreen extends StatefulWidget {
  final List<Map<String, String>> existingUsers;

  const AddUserScreen({super.key, required this.existingUsers});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();

  void _saveUser() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final surname = _surnameController.text.trim();

      final isDuplicate = widget.existingUsers.any((user) =>
          user['name'] == name && user['surname'] == surname);

      if (isDuplicate) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Utente già esistente!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        widget.existingUsers.add({'name': name, 'surname': surname});
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Utente aggiunto con successo!'),
          backgroundColor: Colors.green,
        ),
      );

      _nameController.clear();
      _surnameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aggiungi Utente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Il nome è obbligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _surnameController,
                    decoration: const InputDecoration(
                      labelText: 'Cognome',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _saveUser,
                    child: const Text('Salva'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Nome')),
                  DataColumn(label: Text('Cognome')),
                ],
                rows: widget.existingUsers.map((user) {
                  return DataRow(cells: [
                    DataCell(Text(user['name']!)),
                    DataCell(Text(user['surname']!)),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
