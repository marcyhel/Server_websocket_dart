import 'dart:io';
import 'dart:async';
import 'dart:convert';

void main() {
  WebSocket.connect("ws://localhost:8080").then((sock) {
    sock.add("Conectado");
    sock.listen(
      (message) {
        print(message);
      },
    );
    readLine().listen((e) {
      processLine(e, sock);
    });
    //send(sock);
  }).catchError((err) {
    print("erro $err");
    exit(1);
  });
}

Future<void> send(sock) async {
  sock.add(stdin.readLineSync());
}

Stream<String> readLine() =>
    stdin.transform(utf8.decoder).transform(const LineSplitter());

void processLine(String line, sock) {
  sock.add(line);
  //print(line);
}
