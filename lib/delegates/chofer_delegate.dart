import 'package:flutter/material.dart';
import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';

class ChoferDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => "Buscar...";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: UsuarioDb().obtenerDatos(0, 10, query),
      builder: (context, AsyncSnapshot<List<Usuario>> snapshot) {
        if (!snapshot.hasData) {
          return _NoData();
        }

        final data = snapshot.data!;

        return data.isEmpty
            ? _NoData()
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    close(context, data[index]);
                  },
                  title: Text("${data[index].nombre} ${data[index].apellido}"),
                  subtitle: Text(data[index].usuario),
                ),
              );
      },
    );
  }
}

class _NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 50),
          Text(
            "No se encontraron registros",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
