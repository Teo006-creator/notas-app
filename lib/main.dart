import 'package:flutter/material.dart';

void main() {
  runApp(const NotaApp());
}

class NotaApp extends StatelessWidget {
  const NotaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notas App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class Nota {
  String titulo;
  String descripcion;
  bool esImportante;
  bool estaCompletada;
  DateTime fecha;
  int prioridad;

  Nota({
    required this.titulo,
    required this.descripcion,
    this.esImportante = false,
    this.estaCompletada = false,
    required this.fecha,
    this.prioridad = 1,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final List<Nota> _notas = [];
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  bool _esImportante = false;
  int _prioridad = 1;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _agregarNota() {
    if (_tituloController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El título es obligatorio'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _notas.add(Nota(
        titulo: _tituloController.text,
        descripcion: _descripcionController.text,
        esImportante: _esImportante,
        fecha: DateTime.now(),
        prioridad: _prioridad,
      ));
      _tituloController.clear();
      _descripcionController.clear();
      _esImportante = false;
      _prioridad = 1;
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Nota agregada exitosamente'),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'DESHACER',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _notas.removeLast();
            });
          },
        ),
      ),
    );
  }

  void _mostrarDialogoAgregar() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nueva Nota'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descripcionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Marcar como importante'),
                value: _esImportante,
                onChanged: (value) {
                  setState(() {
                    _esImportante = value;
                  });
                },
                secondary: const Icon(Icons.star, color: Colors.amber),
              ),
              const SizedBox(height: 8),
              const Text('Prioridad:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Baja'),
                  Radio<int>(
                    value: 1,
                    groupValue: _prioridad,
                    onChanged: (value) {
                      setState(() {
                        _prioridad = value!;
                      });
                    },
                  ),
                  const Text('Media'),
                  Radio<int>(
                    value: 2,
                    groupValue: _prioridad,
                    onChanged: (value) {
                      setState(() {
                        _prioridad = value!;
                      });
                    },
                  ),
                  const Text('Alta'),
                  Radio<int>(
                    value: 3,
                    groupValue: _prioridad,
                    onChanged: (value) {
                      setState(() {
                        _prioridad = value!;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: _agregarNota,
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoInfo() {
    showDialog(
      context: context,
      builder: (context) => AboutDialog(
        applicationName: 'Notas App',
        applicationVersion: '1.0.0',
        applicationIcon: const Icon(Icons.note, size: 48, color: Colors.blue),
        children: const [
          Text('Aplicación demostrativa de widgets en Flutter.'),
          SizedBox(height: 8),
          Text('Incluye: AppBar, ListView, Cards, Switch, Radio, '
               'Slider, Chip, FloatingActionButton, Dialog, SnackBar y más.'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Notas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _mostrarDialogoInfo,
            tooltip: 'Acerca de',
          ),
          PopupMenuButton<String>(
            onSelected: (valor) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ordenar por: $valor')),
              );
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'fecha',
                child: Text('Fecha'),
              ),
              const PopupMenuItem(
                value: 'prioridad',
                child: Text('Prioridad'),
              ),
              const PopupMenuItem(
                value: 'nombre',
                child: Text('Nombre'),
              ),
            ],
            icon: const Icon(Icons.sort),
            tooltip: 'Ordenar',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.list), text: 'Todas'),
            Tab(icon: Icon(Icons.star), text: 'Importantes'),
            Tab(icon: Icon(Icons.check_circle), text: 'Completadas'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                image: const DecorationImage(
                  image: NetworkImage('https://picsum.photos/200'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Usuario Demo',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'usuario@ejemplo.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              selected: true,
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.archive),
              title: const Text('Archivadas'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Archivadas (próximamente)')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Papelera'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Papelera (próximamente)')),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pop(context);
                _mostrarConfiguracion();
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _construirListaNotas(_notas),
          _construirListaNotas(_notas.where((n) => n.esImportante).toList()),
          _construirListaNotas(_notas.where((n) => n.estaCompletada).toList()),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: 'btnLimpiar',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('¿Limpiar notas?'),
                  content: const Text('Se eliminarán todas las notas.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _notas.clear();
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Limpiar'),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.delete_sweep),
          ),
          const SizedBox(height: 16),
          FloatingActionButton.extended(
            heroTag: 'btnAgregar',
            onPressed: _mostrarDialogoAgregar,
            icon: const Icon(Icons.add),
            label: const Text('Nueva Nota'),
          ),
        ],
      ),
    );
  }

  Widget _construirListaNotas(List<Nota> notas) {
    if (notas.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_add,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No hay notas',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Presiona el botón + para agregar una nota',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: notas.length,
      itemBuilder: (context, index) {
        final nota = notas[index];
        return Card(
          elevation: nota.esImportante ? 4 : 2,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ExpansionTile(
            leading: Checkbox(
              value: nota.estaCompletada,
              onChanged: (value) {
                setState(() {
                  nota.estaCompletada = value!;
                });
              },
            ),
            title: Text(
              nota.titulo,
              style: TextStyle(
                fontWeight: nota.esImportante ? FontWeight.bold : FontWeight.normal,
                decoration: nota.estaCompletada ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              nota.esImportante ? '⭐ Importante' : 'Fecha: ${nota.fecha.day}/${nota.fecha.month}/${nota.fecha.year}',
              style: TextStyle(
                color: nota.esImportante ? Colors.amber[700] : Colors.grey,
              ),
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (valor) {
                if (valor == 'eliminar') {
                  setState(() {
                    _notas.remove(nota);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Nota "${nota.titulo}" eliminada')),
                  );
                } else if (valor == 'editar') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Editar (próximamente)')),
                  );
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'editar',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text('Editar'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'eliminar',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Eliminar', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nota.descripcion.isEmpty
                        ? 'Sin descripción'
                        : nota.descripcion),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: [
                        Chip(
                          avatar: Icon(
                            Icons.flag,
                            size: 16,
                            color: nota.prioridad == 3
                                ? Colors.red
                                : nota.prioridad == 2
                                    ? Colors.orange
                                    : Colors.green,
                          ),
                          label: Text(
                            nota.prioridad == 3
                                ? 'Alta'
                                : nota.prioridad == 2
                                    ? 'Media'
                                    : 'Baja',
                          ),
                        ),
                        Chip(
                          avatar: const Icon(Icons.calendar_today, size: 16),
                          label: Text(
                            '${nota.fecha.day}/${nota.fecha.month}/${nota.fecha.year}',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarConfiguracion() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Configuración',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Notificaciones'),
                  subtitle: const Text('Recibir recordatorios'),
                  value: true,
                  onChanged: (value) {},
                  secondary: const Icon(Icons.notifications),
                ),
                SwitchListTile(
                  title: const Text('Tema oscuro'),
                  subtitle: const Text('Cambiar modo de apariencia'),
                  value: false,
                  onChanged: (value) {
                    setModalState(() {});
                  },
                  secondary: const Icon(Icons.dark_mode),
                ),
                const SizedBox(height: 8),
                const Text('Tamaño de texto:'),
                Slider(
                  value: 1.0,
                  min: 0.8,
                  max: 1.5,
                  divisions: 7,
                  label: 'Normal',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Guardando configuración...')),
                        );
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      label: const Text('Cerrar'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}