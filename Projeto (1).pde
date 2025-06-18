import java.util.HashMap; // Importa a classe HashMap para associar nomes de pinos a imagens

PImage imgMapa; // Imagem de fundo do mapa
PImage imgPino; // Imagem do pino
ArrayList<Pino> pinos = new ArrayList<Pino>(); // Lista de objetos do tipo Pino
HashMap<String, String> imagensPinos = new HashMap<String, String>(); // Mapeia nomes dos pinos para caminhos de imagens

void setup() {
  size(1280, 528); // Define o tamanho da janela
  imageMode(CENTER); // Define o modo de desenho das imagens para centralizado
  imgMapa = loadImage("Mapa.jpg"); // Carrega imagem do mapa
  imgPino = loadImage("Pino.png"); // Carrega imagem do pino

  // Adiciona pinos ao mapa com seus nomes e coordenadas
  pinos.add(new Pino("Bloco Azul", 496, 242));
  pinos.add(new Pino("Bloco Amarelo", 476, 372));
  pinos.add(new Pino("Bloco Verde", 505, 156));
  pinos.add(new Pino("Bloco Laranja", 755, 85));
  pinos.add(new Pino("Bloco Vermelho", 250, 212));
  pinos.add(new Pino("Bloco de Medicina", 200, 312));
  pinos.add(new Pino("Bloco 10", 250, 70));
  pinos.add(new Pino("Bloco 9", 340, 60));
  pinos.add(new Pino("Bloco 8", 440, 55));
  pinos.add(new Pino("SIGA", 630, 85));
  pinos.add(new Pino("Cliníca de Odontologia", 665, 230));
  pinos.add(new Pino("Biblioteca", 690, 330));
  pinos.add(new Pino("DCE / Centros Acadêmicos", 200, 360));
  pinos.add(new Pino("Arena Digital", 905, 315));
  pinos.add(new Pino("Prédio Administrativo", 805, 230));
  pinos.add(new Pino("Ginásio", 1010, 270));
  pinos.add(new Pino("Casa Estrela", 880, 170));
  pinos.add(new Pino("Complexo Esportivo", 1010, 150));
  pinos.add(new Pino("Clínica de Fisioterapia", 1100, 250));

  // Mapear as plantas do térreo dos blocos
  imagensPinos.put("Bloco Amarelo", "Bloco1/0.png");
  imagensPinos.put("Bloco Amarelo", "Bloco1/1.png");
  imagensPinos.put("Bloco Amarelo", "Bloco1/2.png");
  imagensPinos.put("Bloco Azul", "Bloco2/0.png");
  imagensPinos.put("Bloco Azul", "Bloco2/1.png");
  imagensPinos.put("Bloco Azul", "Bloco2/2.png");
  imagensPinos.put("Bloco Verde", "Bloco3/0.png");
  imagensPinos.put("Bloco Verde", "Bloco3/1.png");
  imagensPinos.put("Bloco Verde", "Bloco3/2.png");
  imagensPinos.put("Bloco Laranja", "Bloco4/0.png");
  imagensPinos.put("Bloco Laranja", "Bloco4/1.png");
  imagensPinos.put("Bloco Laranja", "Bloco4/2.png");
  imagensPinos.put("Bloco Laranja", "Bloco4/3.png");
  imagensPinos.put("Bloco Vermelho", "Bloco5/0.png");
  imagensPinos.put("Bloco Vermelho", "Bloco5/1.png");
  imagensPinos.put("Bloco Vermelho", "Bloco5/2.png");
  imagensPinos.put("Bloco Vermelho", "Bloco5/3.png");
  imagensPinos.put("Bloco de Medicina", "Bloco6/0.png");
  imagensPinos.put("Bloco de Medicina", "Bloco6/1.png");
  imagensPinos.put("Bloco de Medicina", "Bloco6/2.png");
  imagensPinos.put("Bloco de Medicina", "Bloco6/3.png");
  imagensPinos.put("Bloco 9", "Bloco9/0.png");
  imagensPinos.put("Bloco 9", "Bloco9/1.png");
  imagensPinos.put("Bloco 9", "Bloco9/2.png");
  imagensPinos.put("Bloco 10", "Bloco10/0.png");
  imagensPinos.put("Bloco 10", "Bloco10/1.png");
  imagensPinos.put("Bloco 10", "Bloco10/2.png");
}

void draw() {
  background(0); // Fundo preto
  image(imgMapa, width / 2, height / 2, width, height); // Desenha o mapa

  Pino pinoSobreMouse = null; // Armazena o pino que está sob o mouse

  // Atualiza e exibe cada pino
  for (Pino p : pinos) {
    p.update();
    p.display();
    if (p.wasClicked(mouseX, mouseY)) {
      pinoSobreMouse = p; // Verifica se o mouse está sobre o pino
    }
  }

  // Mostra o nome do pino ao passar o mouse por cima
  if (pinoSobreMouse != null) {
    textAlign(CENTER, BOTTOM);
    textSize(16);

    // Desenha contorno preto do texto
    fill(0);
    for (int dx = -1; dx <= 1; dx++) {
      for (int dy = -1; dy <= 1; dy++) {
        if (dx != 0 || dy != 0) {
          text(pinoSobreMouse.id, pinoSobreMouse.x + dx, pinoSobreMouse.y - 35 + dy);
        }
      }
    }

    // Desenha texto branco por cima
    fill(255);
    text(pinoSobreMouse.id, pinoSobreMouse.x, pinoSobreMouse.y - 35);
  }
}

void mousePressed() {
  // Verifica se algum pino foi clicado
  for (Pino p : pinos) {
    if (p.wasClicked(mouseX, mouseY)) {
      println("Pino clicado: " + p.id); // Imprime no console o nome do pino

      String imagem = imagensPinos.get(p.id); // Obtém caminho da imagem associada
      Launcher launcher = new Launcher(); // Cria um objeto para abrir a imagem ou mostrar mensagem

      if (imagem != null) {
        launcher.abrirJanelaComImagem(dataPath(imagem)); // Abre imagem associada ao pino
      } else {
        launcher.abrirJanelaComMensagem("Sem planta disponível para " + p.id); // Mensagem se não houver imagem
      }
    }
  }
}

// Classe que representa um pino no mapa
class Pino {
  String id; // Nome do pino
  float x, y; // Coordenadas
  float alpha = 255; // Transparência para efeito de fade
  int w = 64, h = 64; // Largura e altura do pino

  Pino(String id_, float x_, float y_) {
    id = id_;
    x = x_;
    y = y_;
  }

  void update() {
    // Efeito de fade se o mouse estiver sobre o pino
    boolean mouseSobre = (mouseX > x - w / 2 &&
                          mouseX < x + w / 2 &&
                          mouseY > y - h / 2 &&
                          mouseY < y + h / 2);
    if (mouseSobre) alpha += 5;
    else alpha -= 5;
    alpha = constrain(alpha, 150, 255); // Limita a transparência
  }

  void display() {
    tint(255, alpha); // Aplica transparência ao pino
    image(imgPino, x, y, w, h); // Desenha o pino
    noTint(); // Remove efeito para próximos elementos
  }

  boolean wasClicked(float mx, float my) {
    // Retorna se o clique está dentro da área do pino
    return (mx > x - w / 2 && mx < x + w / 2 &&
            my > y - h / 2 && my < y + h / 2);
  }
}
