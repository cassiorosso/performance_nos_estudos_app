import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:performance_nos_estudos_app/models/conteudo_model.dart';
import 'package:performance_nos_estudos_app/models/revisao_model.dart';

import '../../controllers/revisoes_controller.dart';
import '../../stores/area_store.dart';
import '../../stores/user_store.dart';

class NovoConteudoDialog extends StatefulWidget {
  const NovoConteudoDialog({super.key});

  @override
  State<NovoConteudoDialog> createState() => _NovoConteudoDialogState();
}

class _NovoConteudoDialogState extends State<NovoConteudoDialog> {
  final revisoesController = GetIt.I<RevisoesController>();
  final usuarioStore = GetIt.I<UsuarioStore>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerDate = TextEditingController();
  final areaStore = GetIt.I<AreaStore>();
  final List<DropdownMenuEntry<int>> areaEntries = <DropdownMenuEntry<int>>[];
  late DateTime data;

  String conteudoNome = "";
  late int acertoInt;
  int areaId = 1;

  @override
  void initState() {
    for (int x = 0; x < areaStore.areas.length; x++) {
      areaEntries.add(DropdownMenuEntry(
          value: areaStore.areas[x].id, label: areaStore.areas[x].nome));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.note_add_outlined,
            ),
          ),
          Flexible(
            child: Text(
              "Novo Conteúdo",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FittedBox(
                  fit: BoxFit.contain,
                  child: Text("\nNome do Conteúdo")),
              TextFormField(
                onChanged: (value) => conteudoNome = value,
                maxLength: 35,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira o nome do conteúdo ';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Ex.: Algebra linear",
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const FittedBox(
                  fit: BoxFit.contain,
                  child: Text("\nÁrea")),
              DropdownMenu(
                  enableFilter: true,
                  leadingIcon: const Icon(Icons.search),
                  //initialSelection: 1,
                  onSelected: (value) {
                    if (value != null) {
                      areaId = value;
                    }
                  },
                  dropdownMenuEntries: areaEntries),
              const FittedBox(
                  fit: BoxFit.contain,
                  child: Text("\nData da sua primeira revisão")),
              TextFormField(
                controller: _controllerDate,
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira uma data';
                  }
                  return null;
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      locale: const Locale('pt', 'BR'),
                      context: context,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2035));
                  if (pickedDate != null) {
                    setState(() {
                      _controllerDate.text =
                          revisoesController.formattedDate(pickedDate);
                      data = pickedDate;
                    });
                  }
                },
                decoration: const InputDecoration(
                  hintText: "Ex.: 12/12/2022",
                  border: OutlineInputBorder(),
                ),
              ),
              const FittedBox(
                  fit: BoxFit.contain,
                  child:
                      Text("\nPorcentagem de acerto da revisão")),
              TextFormField(
                onChanged: (value) => acertoInt = double.parse(value).round(),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.parse(value) < 1 ||
                      double.parse(value) > 100) {
                    return 'A porcentagem deve ser um valor válido!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Ex.: 50%",
                  border: OutlineInputBorder(),
                  suffix: Text("%"),
                  isDense: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow((RegExp("[0-9]")))
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child: const Text("Cancelar",
                  style: TextStyle(color: Colors.white))),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ConteudoModel conteudo =
                      ConteudoModel(areaId: areaId, nome: conteudoNome, usuarioId: usuarioStore.user.id);
                  RevisaoModel revisao = RevisaoModel(
                      acerto: acertoInt,
                      concluida: false,
                      data: data,
                      dataProxima: revisoesController.calculateDate(
                          date: data, acerto: acertoInt),
                      usuarioId: usuarioStore.user.id);
                  revisoesController.createConteudoRevisao(
                      conteudo: conteudo, revisao: revisao);
                  Navigator.pop(context);
                }
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child: const Text(
                "Confirmar",
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }
}
