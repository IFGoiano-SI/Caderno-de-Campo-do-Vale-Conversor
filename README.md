# Caderno de Campo do Vale - Conversor de Unidades da Roça

## 1. Apresentação do Software

O **Conversor de Unidades da Roça** é uma funcionalidade integrada ao aplicativo Caderno de Campo do Vale. Desenvolvido para facilitar o dia a dia do produtor rural, o sistema funciona como uma calculadora em tempo real que converte as principais unidades de medida utilizadas na região agropecuária. 

### O que o app faz:
A aplicação permite que o usuário digite um valor numérico, selecione a unidade de origem e defina a unidade de destino. As conversões suportadas englobam:
- Hectares
- Alqueires goianos
- Sacas
- Arrobas

O resultado da conversão é exibido instantaneamente na tela a cada caractere digitado. Uma das principais inovações técnicas da interface é a **reatividade bidirecional (via de mão dupla)**: ambos os campos atuam simultaneamente como origem e destino, atualizando-se mutuamente em tempo real (via `onChanged` e `setState`). 

Além disso, o sistema conta com um botão de limpeza rápida de estado e validação rigorosa de entrada, impedindo o processamento de caracteres inválidos e exibindo mensagens de alerta diretamente no escopo visual do campo afetado.

### Fatores de Conversão Utilizados:
A arquitetura da interface separa as grandezas em abas ("Área" e "Massa") para evitar cruzamento de dados incompatíveis. Os fatores matemáticos aplicados no código são:
- **Área:** 1 Alqueire Goiano = 4,84 Hectares
- **Massa:** 1 Saca = 4 Arrobas

---

## 2. Instruções de Execução (Como Rodar)

Para executar o projeto em sua máquina local, certifique-se de ter o ambiente Flutter devidamente configurado. Em seguida, siga os passos abaixo:

1. Clone o repositório ou acesse a pasta raiz do projeto através do seu terminal.
2. Baixe e atualize as dependências do projeto executando o comando:
   ```bash
   flutter pub get
   ```
3. Conecte um dispositivo físico ou inicie um emulador Android/iOS.
4. Execute a aplicação utilizando o comando:
   ```bash
   flutter run
   ```
5. Durante a execução, utilize o comando de **Hot Reload** (tecla `r` no terminal ou `Ctrl + S` na IDE) para visualizar as alterações instantaneamente sem precisar recompilar todo o aplicativo.

---

## 3. Estrutura da Equipe e Responsabilidades

O trabalho foi desenvolvido em equipe, com divisão de papéis e responsabilidades para garantir a eficiência e a qualidade do produto final. Seguem os integrantes e suas respectivas atribuições:

**Construtor:** Matheus Vieira da Silva  
**Responsabilidade:** Implementação da lógica matemática de conversão entre as unidades agropecuárias, gerenciamento do estado reativo da aplicação (utilização de `setState`) para atualizações em tempo real baseadas no evento `onChanged`, e construção das validações de entrada de dados para garantir que valores inválidos acionem mensagens de alerta no campo visual.

**Designer de Interface:** Giovana Lyssa Galdino Ribeiro  
**Responsabilidade:** Estruturação do layout da tela de conversão, garantindo total aderência à identidade visual estabelecida no Caderno de Campo do Vale. Tomada de decisões de design orientadas ao uso no campo, focando na clareza da hierarquia visual, adequação de contraste e dimensionamento estratégico dos alvos de toque, além da formatação visual correta dos resultados (padrão brasileiro).

**Relator:** Elenilton Filho Nunes da Silva  
**Responsabilidade:** Estruturação da arquitetura base para o início do desenvolvimento (incluindo a configuração inicial da navegação com `NavigationBar` interligando as telas). Elaboração, padronização e organização da documentação do projeto (como este `README.md`), gerenciamento das versões e commits no repositório Git, e condução da demonstração prática ao vivo do software.
