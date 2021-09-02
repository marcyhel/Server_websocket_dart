import 'dart:io';

class Sala {
  List<WebSocket> clientes = [];
  List<String> nick = [];
  Sala() {}
  void escutar() {
    clientes.forEach((element) {
      element.listen((event) {
        print(event);
        // print("dd");
        sendOthers(event, element);
      });
    });
  }

  void sendOthers(String mensagem, WebSocket exeption) {
    clientes.forEach((element) {
      if (element != exeption) {
        element.add(mensagem);
      }
    });
  }

  void sendAll(String mensagem) {
    clientes.forEach((element) {
      element.add(mensagem);
    });
  }

  void addCliente(cliente) {
    clientes.add(cliente);
  }
}

main() {
  List<Sala> salas = [];
  var sala = Sala();
  print('rodando');
  HttpServer.bind('localhost', 8080).then((server) {
    server.listen((HttpRequest request) {
      WebSocketTransformer.upgrade(request).then((cliente) {
        print("conect");
        cliente.add(sala.clientes.length.toString());

        if (sala.clientes.length < 2) {
          sala.addCliente(cliente);
        }
        if (sala.clientes.length == 2) {
          sala.sendAll("pronto");
          sala.escutar();
          salas.add(sala);
          sala = Sala();
        }
      });
      //request.response.write('Hello, world!');
      //request.response.close();
    });
  });
}
