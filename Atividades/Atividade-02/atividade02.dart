import 'dart:convert';

class Dependente {
  late String nome;

  Dependente(this.nome);
}

class Funcionario {
  late String nome;
  late List<Dependente> dependentes;

  Funcionario(this.nome, this.dependentes);
}

class EquipeProjeto {
  late String nomeProjeto;
  late List<Funcionario> funcionarios;

  EquipeProjeto(this.nomeProjeto, this.funcionarios);

  Map<String, dynamic> toJson() {
    return {
      'nomeProjeto': nomeProjeto,
      'funcionarios': funcionarios.map((funcionario) {
        return {
          'nome': funcionario.nome,
          'dependentes': funcionario.dependentes.map((dependente) {
            return {'nome': dependente.nome};
          }).toList()
        };
      }).toList()
    };
  }
}

void main() {
  var dependente1 = Dependente("Ana");
  var dependente2 = Dependente("Carlos");
  var dependente3 = Dependente("Bia");

  var funcionario1 = Funcionario("João", [dependente1, dependente2]);
  var funcionario2 = Funcionario("Maria", [dependente3]);

  var listaFuncionarios = [funcionario1, funcionario2];

  var equipeProjeto = EquipeProjeto("Projeto Dart", listaFuncionarios);

  var encoder = JsonEncoder.withIndent('  ');
  print(encoder.convert(equipeProjeto.toJson()));
}
