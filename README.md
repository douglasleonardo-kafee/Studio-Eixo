# 🧘‍♀️ Studio Pilates Manager — Sistema de Gestão

Aplicativo nativo para Android desenvolvido em **Kotlin** com **Jetpack Compose (Material 3)** e preparado para integração com o **Supabase** (PostgreSQL em nuvem). O sistema foi criado para simplificar a rotina administrativa e operacional de estúdios de Pilates, oferecendo uma interface limpa, intuitiva e acolhedora voltada ao uso exclusivo do instrutor ou administrador.

---

## ✨ Funcionalidades Principais

* **📊 Dashboard Mensal:**
  * **Faturamento Mensal:** Cálculo automático do valor arrecadado (alunos marcados como *Pago*), valor previsto total e valor pendente, acompanhado de barra de progresso visual.
  * **Controle de Mensalidades:** Visualização rápida com contadores de alunos *Pagos* vs *Pendentes* e alternância de status com apenas **1 toque**.
  * **Gestão de Reposições:** Painel dedicado aos alunos que possuem aulas a repor, permitindo dar baixa (`-1 aula`) com feedback em tempo real.

* **📅 Grade de Horários e Turmas (Agenda):**
  * Organização diária em blocos de horários (das **07:00 às 19:00**) com seletor de dia da semana (Segunda-feira a Sábado).
  * **Limite Rígido de Turma:** Controle automático de capacidade máxima de **no máximo 4 alunos por horário**, exibindo visualmente `X/4 vagas ocupadas` ou badge de **TURMA LOTADA**.
  * **Gestão de Presença e Faltas:** Permite adicionar alunos à turma, remover agendamentos ou **Marcar Falta** (que desagenda o aluno e incrementa automaticamente `+1` no seu saldo de aulas a repor).

* **👥 Gestão de Clientes (CRUD Completo):**
  * Cadastro e edição completa de alunos: Nome completo, Telefone/WhatsApp, Valor da mensalidade (R$), Status do mês atual (Pago / Pendente), Saldo de reposições e Observações clínicas/físicas (lesões, hérnias de disco, gestantes, etc.).
  * **Busca em Tempo Real:** Filtro rápido por nome ou telefone.
  * **Ações Rápidas:** Discagem direta para o telefone do aluno e exclusão com confirmação de segurança.

* **⚙️ Configuração Dinâmica do Supabase:**
  * Botão de status na barra superior (AppBar) para visualizar e configurar a `SUPABASE_URL` e `SUPABASE_ANON_KEY` diretamente na aplicação.
  * O aplicativo já vem configurado com dados de demonstração locais (seed data), permitindo testar imediatamente sem necessidade de configuração prévia de banco de dados.

---

## 🎨 Identidade Visual (UI/UX)

O design segue uma abordagem minimalista, acolhedora e moderna focada em saúde e bem-estar:
* **Cor Primária:** Verde Água (`#20B2AA` / `#00897B` / `#4DB6AC`), transmitindo tranquilidade, saúde e equilíbrio.
* **Fundo e Superfícies:** Branco puro (`#FFFFFF`) e cinza muito suave (`#F8F9FA` / `#E0F2F1`) para leitura leve e cards bem definidos.
* **Textos e Tipografia:** Cinza escuro/chumbo (`#2D3748`) para excelente contraste e legibilidade.
* **Badges de Status:**
  * 🟢 **Pago / Presente:** Verde (`#2E7D32` / `#E8F5E9`)
  * 🟠 **Pendente / Lotado:** Laranja (`#E65100` / `#FFF3E0`)
  * 🔵 **Aulas a Repor:** Ciano (`#00838F` / `#E0F7FA`)

---

## 🛠️ Tecnologias Utilizadas

* **Linguagem:** [Kotlin](https://kotlinlang.org/)
* **Interface:** [Jetpack Compose](https://developer.android.com/jetpack/compose) com **Material 3**
* **Arquitetura & Estado:** MVVM (Model-View-ViewModel), `StateFlow`, Coroutines, Repository Pattern
* **Backend / Banco de Dados:** [Supabase](https://supabase.com/) (PostgreSQL em nuvem)
* **Build System:** Gradle (Kotlin DSL) com Version Catalogs (`libs.versions.toml`)

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
* **Android Studio** (Ladybug 2024.2+ ou superior).
* **JDK 17** ou superior configurado no Android Studio.
* Emulador Android ou dispositivo físico com Android 7.0 (API 24) ou superior.

### Passo a Passo

1. **Abrir o Projeto:**
   No Android Studio, selecione **Open** e abra a pasta do projeto `trabalhoaldyr`.

2. **Sincronizar o Gradle:**
   Aguarde a sincronização do Gradle (*Gradle Sync*).

3. **Executar o App:**
   Selecione o módulo `app` e clique no botão **Run** (`Shift + F10`) no Android Studio para rodar no emulador ou dispositivo físico.

---

## 🗄️ Estrutura do Banco de Dados (Supabase)

O arquivo `supabase_schema.sql` na raiz do projeto contém o script SQL pronto para execução no **SQL Editor** do Supabase.

### Tabelas Principais:
* `clientes`: Dados cadastrais (`id`, `nome`, `telefone`, `valor_mensalidade`, `pago`, `aulas_repor`, `observacoes`).
* `agendamentos`: Relaciona os clientes aos dias da semana e horários das turmas (`id`, `cliente_id`, `dia_semana`, `horario`), com chave estrangeira em cascata (`ON DELETE CASCADE`).

---

## 👨‍💻 Autor

Projeto desenvolvido para gestão de estúdio de Pilates.
