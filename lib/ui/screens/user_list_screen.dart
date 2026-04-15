import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/user_provider.dart';
import 'package:flutter_application_1/ui/screens/user_form_screen.dart';
import 'package:flutter_application_1/ui/widgets/user_card.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Gestão de Usuários')),
      body: userProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                // Se a tela for larga (Tablet/Web), mostra Grid. Se estreita, Lista.
                if (constraints.maxWidth > 600) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                    ),
                    itemCount: userProvider.users.length,
                    itemBuilder: (ctx, i) =>
                        UserCard(user: userProvider.users[i]),
                  );
                }
                return ListView.builder(
                  itemCount: userProvider.users.length,
                  itemBuilder: (ctx, i) =>
                      UserCard(user: userProvider.users[i]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showForm(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const UserFormScreen()));
  }
}
