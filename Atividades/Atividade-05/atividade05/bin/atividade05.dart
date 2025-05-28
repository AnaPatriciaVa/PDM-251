import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() async {

  const String username = 'meu_email';
  const String password = 'senha_do_app';

  stdout.write('Digite o e-mail do destinatário: ');
  String? destinatario = stdin.readLineSync();

  stdout.write('Digite o assunto do e-mail: ');
  String? assunto = stdin.readLineSync();

  stdout.write('Digite a mensagem: ');
  String? mensagem = stdin.readLineSync();

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'Dart SMTP Sender')
    ..recipients.add(destinatario ?? '')
    ..subject = assunto ?? 'Sem Assunto'
    ..text = mensagem ?? '';

  try {
    final sendReport = await send(message, smtpServer);
    print('\n✅ Email enviado com sucesso: $sendReport');
  } on MailerException catch (e) {
    print('\n❌ Erro ao enviar o email: $e');
    for (var p in e.problems) {
      print('Problema: ${p.code}: ${p.msg}');
    }
  }
}
