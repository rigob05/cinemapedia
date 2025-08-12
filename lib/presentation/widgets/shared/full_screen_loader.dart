import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  FullScreenLoader({super.key});

  final message = <String>[
    '🤖 Entrenando al bot',
    'Cargando magia ✨ ahora sí',
    'Ya casi 🏃‍♂️💨 casi',
    'Modo turbo activado 🚀',
    'Haciendo café ☕ para el servidor',
    'Sacudiendo 🧹 los bits',
    'Acomodando paquetes 📦 en fila',
    'Wifi, pórtate bien 📶 por favor',
    '🐢 Lento pero seguro... luego rápido',
    'Encontrando el botón de “funcionar” 🔘',
    'Compilando chistes 😂 en segundo plano',
    '🧠 Pensando... pensando... ¡listo!',
    'Guardando cambios 💾 como si fuera final',
    'Subiendo nivel ⬆️ de epicidad',
    'Afilando el código 🗡️',
    '🧩 Armando piezas en su lugar',
    'Pon música 🎵 esto ayuda',
    'Despertando servidores 😴 → 😎',
    'Listando pendientes 📋 y borrándolos ✨',
    'Ok, ok… ahora sí 🚦',
  ];

  Stream<String> getLoadingMessages() {
    return Stream.periodic(const Duration(milliseconds: 1300), (step) {
      return message[step];
    }).take(message.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(' Awanta en lo que carga cuyeyo'),
          SizedBox(height: 24),
          CircularProgressIndicator(strokeWidth: 4),
          SizedBox(height: 24),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Cargando....');
              return Text(snapshot.data ?? '');
            },
          ),
        ],
      ),
    );
  }
}
