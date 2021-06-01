//Quando você tem uma ideia para uma fórmula, pense sobre isso na linguagem cotidiana antes de puxar para cima o Editor de Fórmula Avançada. Comece se perguntando qual é o seu objetivo e descrevendo-o conversamente.

//Este exemplo veio da Comunidade Trailblazer do Salesforce: Diga que seu objetivo é garantir que se alguém além de um administrador de sistema marcar uma oportunidade como "Lost Fechada", eles têm que fornecer uma explicação.

//Para este exemplo, assumimos que você já tem o campo picklist personalizado, Loss Reason, preenchido com razões válidas para perder uma oportunidade. Como ninguém deve ser capaz de salvar um registro sem fornecer uma razão, usamos uma fórmula de regra de validação para alcançar nosso objetivo.

//Em linguagem simples, sua fórmula é:

//Mostre um erro quando o estágio de uma oportunidade é alterado para "Closed Lost" por alguém que não é um administrador do sistema, e a Razão de Perda está em branco.

//Depois de escrever sua fórmula, procure palavras-chave como "e", "ou" e "se" que correspondam às funções usadas ao longo deste módulo. Essas funções são os blocos de construção de fórmulas maiores e mais complicadas. Reconhecê-las em seus casos de uso ajuda a implementar tais fórmulas.

//Para verificar se o usuário não é um administrador do sistema, insira $Profile.Name, um campo de mesclagem que representa o perfil que faz edições no registro. Para verificar se o StageName foi atualizado, use ISCHANGED(). ISCHANGED() retorna verdadeiro se o valor atual de um campo difere do valor anterior.

//Você pode verificar o resto de suas necessidades com ISPICKVAL(). Para obter mais informações sobre o ISPICKVAL(), consulte Usando picklists em Fórmulas.

AND(
  $Profile.Name <> "System Administrator",
  ISCHANGED(StageName),
  ISPICKVAL(StageName, "Closed Lost"),
  ISPICKVAL(Loss_Reason__c, "")
)

//Quando trabalhamos em fórmulas de texto, escrevemos uma fórmula que atribui dinamicamente uma classificação a uma liderança baseada no país, receita e fonte.

IF(AND(AnnualRevenue > 1000000, CONTAINS(CASE(Country,
"United States", "US", "America", "US", "USA", "US", "US", "US",
"NA"), "US")), IF(ISPICKVAL(LeadSource, "Partner Referral"),
"Hot", IF(OR(ISPICKVAL (LeadSource, "Purchased List"),
ISPICKVAL(LeadSource, "Web")), "Warm”, "Cold")), "Cold")

//Embora esta fórmula seja sintáticamente correta, é quase impossível dizer o que ela faz ou como a lógica funciona. Como o espaço branco e os retornos não importam nas fórmulas, é fácil tornar sua fórmula mais legível com espaços. Aqui está a mesma fórmula, mas limpa com recuos e retornos.

IF(
  AND(AnnualRevenue > 1000000,
  CONTAINS(CASE(Country, "United States", "US", "America",
    "US", "USA", "US", "US", "US", "NA"), "US")),
  IF(
    ISPICKVAL(LeadSource, "Partner Referral"), "Hot",
    IF(
      OR(
        ISPICKVAL(LeadSource, "Purchased List"),
        ISPICKVAL(LeadSource, "Web")
      ), "Warm”, "Cold"
    )
  ), "Cold"
)

//Outra maneira de tornar as afirmações lógicas mais fáceis de ler é usando operadores lógicos em vez de funções. Quando você usa && e em vez de AND(), ou || em vez de OR(), é mais fácil para alguém ler sua fórmula seguir o fluxo lógico. Aqui está a mesma fórmula mais uma vez, com && e || em vez de AND() e OR().

IF(
  AnnualRevenue > 1000000 &&
  CONTAINS(CASE(Country, "United States", "US", "America", "US",
    "USA", "US", "US", "US", "NA"), "US"),
  IF(
    ISPICKVAL(LeadSource, "Partner Referral"), "Hot",
    IF(
      ISPICKVAL(LeadSource, "PurchasedList") ||
      ISPICKVAL(LeadSource, "Web"),
      "Warm", "Cold"
    )
  ), "Cold"
)

//Ao escrever uma fórmula complicada, é fácil ficar atolado em declarações lógicas aninhadas e referências a outros campos. Muitas vezes, a fórmula mais simples é a melhor fórmula.

//Esta fórmula de regra de validação retorna verdadeira se a Data de Encerramento de uma oportunidade não estiver no mês atual

OR (
CloseDate < DATE( YEAR(TODAY()), MONTH(TODAY()), 1),
IF (
AND (
MONTH (TODAY() ) =1,
CloseDate > DATE( YEAR(TODAY() ), MONTH(TODAY() ), 31)),
true,
IF (
AND (
MONTH (TODAY() ) =2,
CloseDate > DATE( YEAR(TODAY() ), MONTH(TODAY() ), 28)),
true,
IF (
AND (
MONTH (TODAY() ) =3,
CloseDate > DATE( YEAR(TODAY() ), MONTH(TODAY() ), 31)),
true,
IF (
AND (
MONTH (TODAY() ) =4,
CloseDate > DATE( YEAR(TODAY() ), MONTH(TODAY() ), 30)),
true,
IF (
AND (
MONTH (TODAY() ) =5,
CloseDate > DATE( YEAR(TODAY() ), MONTH(TODAY() ), 31)),
true,
IF (
AND (
MONTH (TODAY() ) =6,
CloseDate > DATE( YEAR(TODAY() ), MONTH(TODAY() ), 30)),
true,
IF (
AND (
MONTH (TODAY() ) =7,
CloseDate > DATE( YEAR(TODAY() ), MONTH(TODAY() ), 31)),
true,
IF (
AND (
MONTH (TODAY() ) =8,
CloseDate > DATE( YEAR(TODAY() ), MONTH(TODAY() ), 31)),
true,
IF (
AND (
MONTH (TODAY() ) =9,
CloseDate > DATE( YEAR(TODAY() ), MONTH(TODAY() ), 30)),
true,
IF (
AND (
MONTH (TODAY() ) =10,
CloseDate > DATE( YEAR(TODAY() ), MONTH(TODAY() ), 31)),
true,
IF (
AND (
MONTH (TODAY() ) =11,
CloseDate > DATE( YEAR(TODAY() ), MONTH(TODAY() ), 30)),
true,
IF (
AND (
MONTH (TODAY() ) =12,
CloseDate > DATE( YEAR(TODAY() ), MONTH(TODAY() ), 31)),
true, false
)))))))))))))

//Esta verificação complexa determina se a Data de Encerramento é mais cedo do que o primeiro dia do mês atual, ou mais tarde do último dia deste mês. Mas, na verdade, o dia não importa: se o mês e o ano da Data de Encerramento são os mesmos do mês e ano do mês atual, então é o mesmo mês. Então podemos reescrever a fórmula como:

NOT(
  AND(
    MONTH( CloseDate ) = MONTH( TODAY() ),
    YEAR( CloseDate ) = YEAR( TODAY() )
  )
)

//Se sua fórmula parece mais complicada do que deveria ser, provavelmente é — tente abordar o problema de um ângulo diferente para simplificar as coisas.


//Date1__c is a Date field.
//Date2__c is a formula field that creates a date from Date1__c.
DATE( YEAR( Date1__c ), MONTH( Date1__c ), DAY( Date1__c ) )

//The following formula returns the date of the last day of the month for a given date (assume February always has 28 days):

DATE(
 YEAR( SomeDate__c ),
 MONTH( SomeDate__c ),
 IF(
   OR(
     MONTH( SomeDate__c ) = 4,
     MONTH( SomeDate__c ) = 6,
     MONTH( SomeDate__c ) = 9,
     MONTH( SomeDate__c ) = 11
   ),
   30,
   IF(
     MONTH( SomeDate__c ) = 2,
     28,
     31
   )
 )
)

//The formula first checks for months with 30 days, then February, and the remaining months are 31 days. It requires a nested IF() function, which isn’t very readable and compiles to 1069 characters for Date1__c and a whopping 7,271 characters for Date2__c! Why? Because the formula references the date seven times. Compare that to this revised version of the formula:

DATE(
 YEAR( SomeDate__c ),
 MONTH( SomeDate__c ),
 CASE(
   MONTH( SomeDate__c ),
   2, 28,
   4, 30,
   6, 30,
   9, 30,
   11, 30,
   31
 )
)
//Not only is this easier to read, the formula compiles to only 645 characters for Date1__c and 3,309 characters for Date2__c, and it now references the date three times instead of seven.

//This example came from the Salesforce Answers community . A picklist stores the name of an agent responsible for an opportunity. The formula calculates a commission, based on Base Commission value and a multiplier. But because Base_Commission__c is referenced in each condition of the CASE() statement, the formula exceeds the compile size.

CASE( Agent__c,
  "John", Base_Commission__c * 2,
  "Jane", Base_Commission__c * 6,
  /* Repeat for many other agents */
  Base_Commission__c
)

//To fix this, move Base_Commission__c outside the CASE() function. The formula can be rewritten as:

Base_Commission__c * CASE( Agent__c,
  "John", 2,
  "Jane", 6,
  /* Repeat for many other agents */
  1
)