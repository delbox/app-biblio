import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/models/models.dart';
import 'package:tracking_app/providers/providers.dart';

class AlmacenDelegate extends SearchDelegate {
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
    final almacenProvider =
        Provider.of<AlmacenProvider>(context, listen: false);

    return FutureBuilder(
      future: almacenProvider.obtenerDatos(query),
      builder: (context, AsyncSnapshot<List<Almacen>> snapshot) {
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
                  title: Text(data[index].descripcion),
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
