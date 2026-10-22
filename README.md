# CodeGrace

Plataforma gamificada para o ensino de tecnologia e logica de programacao voltada ao publico feminino, desenvolvida com Flutter e integrada a valorizacao de mulheres pioneiras na Computacao.

---

## Sumario

- [Sobre o Projeto](#sobre-o-projeto)
- [Motivacao e Justificativa](#motivacao-e-justificativa)
- [Metodologia do Projeto](#metodologia-do-projeto)
- [Funcionalidades Principais](#funcionalidades-principais)
- [Arquitetura de Software](#arquitetura-de-software)
- [Tecnologias e Ferramentas](#tecnologias-e-ferramentas)
- [Instalacao e Execucao Local](#instalacao-e-execucao-local)
- [Integracao Continua e Entrega (CI/CD)](#integracao-continua-e-entrega-cicd)
- [User Stories Atendidas](#user-stories-atendidas)
- [Equipe e Agradecimentos](#equipe-e-agradecimentos)

---

## Sobre o Projeto

O **CodeGrace** e uma solucao de software educativo desenvolvida como Projeto Interdisciplinar de Computacao (SLTPICO) no curso de Bacharelado em Ciencia da Computacao do **Instituto Federal de Sao Paulo (IFSP - Campus Salto)**, e submetida a **X Feira de Ciencia, Mostra Tecnologica e Empreendedorismo (IFCiencia 2026)** sob o tema *"Ciencia Delas: Mulheres na Ciencia"*.

O nome do aplicativo e uma homenagem a **Grace Hopper**, pioneira da computacao, criadora da linguagem Flow-Matic (base do COBOL) e responsavel pela popularizacao do termo *bug*. O projeto combina o ensino dos fundamentos de programacao (variaveis, estruturas condicionais e logica) com a trajetoria inspiradora de mulheres historicas na tecnologia, como **Ada Lovelace** e **Grace Hopper**.

---

## Motivacao e Justificativa

Apesar do papel historico fundamental desempenhado por mulheres nos primordios da ciencia da computacao, observa-se uma baixa participacao e retencao feminina em cursos e carreiras de exatas e tecnologia. Estudos da UNESCO (2017) apontam que apenas cerca de 30% das estudantes no ensino superior optam por areas de STEM (Ciencia, Tecnologia, Engenharia e Matematica).

Uma pesquisa de campo realizada pela equipe do projeto com 20 mulheres sem background tecnico revelou que:
- **55%** possuem curiosidade e interesse em aprender programacao.
- As principais barreiras apontadas incluem a **didatica tradicional confusa**, o **ambiente masculinizado**, a **falta de incentivo** e a **escassez de referencias femininas (Role Models)**.
- A maioria indicou preferencia por **conteudos curtos, dinamicos e gamificados**.

O CodeGrace surge para preencher essa lacuna, oferecendo uma ponte acessivel entre o uso cotidiano do computador e o pensamento computacional.

---

## Metodologia do Projeto

O desenvolvimento seguiu a abordagem do **Design Thinking (DT)** centrado na pessoa usuaria, articulando quatro fases principais:

1. **Descobrir:** Pesquisa exploratoria de campo (questionario quanti-qualitativo com TCLE aprovado) e consolidacao de dados via **Mapa de Empatia** e **Matriz CSD** (Certezas, Suposicoes e Duvidas).
2. **Definir:** Analise dos dados coletados, formulacao das perguntas **How Might We (HMW)** e delimitacao do escopo pedagogico e tecnico.
3. **Desenvolver:** Criacao da matriz interdisciplinar de disciplinas (Algoritmos e Logica I/II, Entretenimento Digital, Estrutura de Dados e Banco de Dados), prototipagem de baixa e alta fidelidade, e implementacao em Flutter com o padrao MVVM.
4. **Entregar:** Validacao em campo, coleta de feedback com docentes e usuarias, e disponibilizacao da versao compilada (.apk) no GitHub Releases para a IFCiencia 2026.

---

## Funcionalidades Principais

- **Licao Interativa da Ada Lovelace:** Quiz progressivo dividido em niveis (Tutorial, Facil, Medio e Dificil) abordando variaveis, logica de programacao e historico de Ada Lovelace.
- **Avatar e Balao de Fala Dinamico:** Feedback imediato e motivacional fornecido em tempo real pela personagem durante a resolucao das questoes.
- **Pontuacao e Gamificacao:** Sistema de progresso e contagem de pontos acumulados ao concluir cada desafio.
- **Tema Personalizado Catppuccin Mocha:** Identidade visual moderna com alto contraste e acessibilidade ergonomica baseada nas diretrizes do Material 3.

---

## Arquitetura de Software

O aplicativo foi desenvolvido utilizando o padrao arquitetural **MVVM (Model-View-ViewModel)** combinado com a biblioteca de gerenciamento de estado **Provider**:

```
lib/
├── models/
│   └── quiz_question.dart       # Modelo de dados da pergunta e opcoes
├── viewmodels/
│   └── quiz_viewmodel.dart      # Regras de negocio, pontuacao e controle de estado (ChangeNotifier)
├── views/
│   ├── home_page.dart           # Tela inicial e selecao de modulos
│   └── quiz_page.dart           # Interface do quiz interativo e dialogos da Ada
├── theme/
│   └── catppuccin_theme.dart    # Paleta de cores e temas do Material 3
└── main.dart                    # Ponto de entrada e configuracao da injecao de dependencia (MultiProvider)
```

---

## Tecnologias e Ferramentas

- **Linguagem:** Dart (v3+)
- **Framework:** Flutter (v3.24+)
- **Gerenciamento de Estado:** Provider
- **Design System:** Material 3 + Catppuccin Mocha Theme
- **Controle de Versao & CLI:** Git e GitHub CLI
- **Automacao de CI/CD:** GitHub Actions

---

## Instalacao e Execucao Local

### Pre-requisitos
- Flutter SDK instalado e configurado (`flutter doctor`).
- Android SDK (com `cmdline-tools` e licencas aceitas).

### Passos para execucao

1. Clone o repositorio do projeto:
   ```bash
   git clone <URL_DO_REPOSITORIO>
   cd codegrace
   ```

2. Instale as dependencias:
   ```bash
   flutter pub get
   ```

3. Execute o aplicativo em modo de desenvolvimento (Desktop Linux ou Emulador):
   ```bash
   flutter run
   ```

4. Para gerar o instalador do aplicativo para celulares Android (APK release):
   ```bash
   flutter build apk --release
   ```
   O arquivo `.apk` sera gerado em: `build/app/outputs/flutter-apk/app-release.apk`.

---

## Integracao Continua e Entrega (CI/CD)

O repositorio conta com uma pipeline automatizada via **GitHub Actions** (`.github/workflows/flutter-ci.yml`) que realiza:

1. **Validacao de Codigo:** Execucao de `dart format` e `flutter analyze` em cada Push e Pull Request para a branch `main`.
2. **Build Automatizado:** Compilacao do pacote Android (`app-release.apk`) em ambiente limpo de integracao.
3. **Publicacao de Release:** Criacao automatica de entrada na aba **Releases** do GitHub sempre que uma nova tag com padrao `v*` (ex: `v0.1.0-ifciencia`) e enviada para o repositorio.

---

## User Stories Atendidas

- **US-01:** Como usuaria que se identifica como mulher, quero ter representacao feminina na plataforma a fim de me sentir representada e motivada.
- **US-02:** Como usuaria, quero ter acesso as respostas das perguntas para entender meus erros e saber meu progresso.
- **US-03:** Como usuaria, quero resolver e refazer fases sobre programacao basica a fim de aprender, revisar e reforcar meu aprendizado.
- **US-04:** Como usuaria, quero ter acesso a minha pontuacao e ao meu progresso a fim de gerenciar meus estudos.

---

## Equipe e Agradecimentos

### Discentes (Grupo 2 - BCC4)
- Eduardo Martins Correa
- Fabio Haruo de Freitas Nishioka
- Murilo Rodrigues de Oliveira
- Yasmin Sampieri Tonello Cury

### Orientadora
- **Profa. Dra. Suellen Martinelli**

### Instituicao
- **Instituto Federal de Educacao, Ciencia e Tecnologia de Sao Paulo (IFSP - Campus Salto)**
- Disciplina: Projeto Interdisciplinar de Computacao (SLTPICO)
