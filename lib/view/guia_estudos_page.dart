import 'package:flutter/material.dart';

class GuiaEstudosPage extends StatefulWidget {
  const GuiaEstudosPage({super.key});

  @override
  State<GuiaEstudosPage> createState() => _GuiaEstudosPageState();
}

class _GuiaEstudosPageState extends State<GuiaEstudosPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}