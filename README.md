# Caderno de Campo do Vale - Conversor de Unidades da Roça

## 1. Apresentação do Software

O **Conversor de Unidades da Roça** é uma funcionalidade integrada ao aplicativo Caderno de Campo do Vale. Desenvolvido para facilitar o dia a dia do produtor rural, o sistema funciona como uma calculadora em tempo real que converte as principais unidades de medida utilizadas na região agropecuária. 

### O que o app faz:
A aplicação permite que o usuário digite um valor numérico, selecione a unidade de origem e defina a unidade de destino. As conversões suportadas englobam:
- **Área:** Hectares, Alqueires goianos, Acres e Metros quadrados.
- **Massa:** Sacas, Arrobas, Quilogramas e Toneladas.

O resultado da conversão é exibido instantaneamente na tela a cada caractere digitado. Uma das principais inovações técnicas da interface é a **reatividade bidirecional (via de mão dupla)**: ambos os campos atuam simultaneamente como origem e destino, atualizando-se mutuamente em tempo real (via `onChanged` e `setState`). Inspirada nas melhores práticas de design (como o aplicativo de conversão da Samsung), a navegação conta com recursos avançados como a transição ágil de abas por gestos (`PageView` com swipe) e menus de contexto dinâmicos (`PopupMenuButton`) para a seleção rápida das unidades.
O resultado da conversão é exibido instantaneamente na tela a cada caractere digitado. Uma das principais inovações técnicas da interface é a **reatividade bidirecional (via de mão dupla)**: qualquer um dos dois campos pode ser a origem, e o outro é recalculado a partir do último campo editado, em tempo real (via `onChanged` e `setState`). Inspirada nas melhores práticas de design (como o aplicativo de conversão da Samsung), a navegação conta com recursos avançados como a transição ágil de abas por gestos (`PageView` com swipe) e menus suspensos (`PopupMenuButton`) para a seleção rápida das unidades.

Além disso, o sistema conta com um botão de limpeza rápida de estado e uma estratégia dupla de verificação:
1. **Prevenção:** Bloqueia, na própria digitação (`TextInputFormatter`), a entrada de mais de um separador decimal (vírgula ou ponto).
2. **Validação:** Rejeita caracteres inválidos (letras e sinal negativo), digitados ou colados, e impede valores que excedem os limites, exibindo mensagens de alerta vermelhas e precisas diretamente no escopo visual do campo afetado.

### Fatores de Conversão Utilizados:
A arquitetura da interface separa as grandezas em abas ("Área" e "Massa") para evitar cruzamento de dados incompatíveis. Os fatores matemáticos aplicados no código são:
- **Área:** 1 Alqueire Goiano = 4,84 Hectares
- **Área:** 1 Acre = 0,4047 Hectares
- **Área:** 1 Hectare = 10000 Metros quadrados
- **Massa:** 1 Saca = 4 Arrobas
- **Massa:** 1 Saca = 60 Quilogramas
- **Massa:** 1 Arroba = 15 Quilogramas
- **Massa:** 1 Tonelada = 1000 Quilogramas

*Nota: Os campos aceitam vírgula ou ponto como decimal e não utilizam separador de milhar para facilitar a edição em dispositivos móveis.*

---

## 2. Instruções de Execução (Como Rodar)

Para executar o projeto em sua máquina local, certifique-se de ter o ambiente Flutter devidamente configurado. Em seguida, siga os passos abaixo:

1. Clone o repositório ou acesse a pasta raiz do projeto através do seu terminal.
2. Baixe e atualize as dependências do projeto executando o comando:
   ```bash
   flutter pub get
   ```
3. Conecte um dispositivo físico ou inicie um emulador Android/iOS.
4. Execute os testes automatizados (conversões de unidade e abertura do app) utilizando:
   ```bash
   flutter test
   ```
5. Execute a aplicação utilizando o comando:
   ```bash
   flutter run
   ```
6. Durante a execução, utilize o comando de **Hot Reload** (tecla `r` no terminal ou `Ctrl + S` na IDE) para visualizar as alterações instantaneamente sem precisar recompilar todo o aplicativo.

---

## 3. Estrutura da Equipe e Responsabilidades

O trabalho foi desenvolvido em equipe, com divisão de papéis e responsabilidades para garantir a eficiência e a qualidade do produto final. Seguem os integrantes e suas respectivas atribuições:

**Construtor:** Matheus Vieira da Silva  
**Responsabilidade:** Implementação da lógica matemática de conversão entre as unidades agropecuárias, gerenciamento do estado reativo da aplicação (utilização de `setState`) para atualizações em tempo real baseadas no evento `onChanged`, e construção das validações de entrada de dados para garantir que valores inválidos acionem mensagens de alerta no campo visual.

**Designer de Interface:** Giovana Lyssa Galdino Ribeiro  
**Responsabilidade:** Estruturação do layout da tela de conversão, garantindo total aderência à identidade visual estabelecida no Caderno de Campo do Vale. Tomada de decisões de design orientadas ao uso no campo, focando na clareza da hierarquia visual, adequação de contraste e dimensionamento estratégico dos alvos de toque, além da formatação visual correta dos resultados (padrão brasileiro).

**Relator:** Elenilton Filho Nunes da Silva  
**Responsabilidade:** Estruturação da arquitetura base para o início do desenvolvimento (incluindo a configuração inicial da navegação com `NavigationBar` interligando as telas). Elaboração, padronização e organização da documentação do projeto (como este `README.md`), gerenciamento das versões e commits no repositório Git, e condução da demonstração prática ao vivo do software.

---

## 4. Decisões de interface para o uso no campo

1. **Alvos de toque de 48 dp e teclado numérico.**
   O seletor de unidade e as abas têm área de toque mínima de 48 dp, e o campo abre o
   teclado numérico com vírgula decimal. No campo o produtor usa o celular com luvas,
   mãos sujas ou em movimento, e alvos pequenos causam toques errados.

2. **Contraste e hierarquia visual.**
   O valor é exibido em 28 sp, em verde escuro (#1E5631, contraste 8,6:1). A sigla da
   unidade usa cinza escuro (#616161, 6,2:1) para ser legível sob sol forte. A aba selecionada é preenchida em verde escuro com texto branco (8,6:1), e não apenas em verde claro, para que a aba ativa seja identificada de longe. O erro
   aparece como texto na cor vermelha, logo abaixo do campo, acompanhado de borda vermelha, e não apenas como mudança de cor.
