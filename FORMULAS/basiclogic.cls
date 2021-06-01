AND()
//exige pelo menos 2 argumentos
//true + false = true
// false + false = false
// true + true = true

//---exemplo
AND(DoNotCall, HasOptedOutOfEmail)

//---exemplo
AND(DoNotCall, HasOptedOutOfEmail, HasOptedOutOfFax)
--------

OR()
//parecido com o and
//leva 2 argumentos
//true + false = false
//false + false = false
//true + true = true

//To make this formula work, we’re going to use a couple of text functions that you can learn more about in Using Text Formulas
BEGINS(Text, Compare_Text)
//informa se uma string(text) comeca com outra string(compare_text)

CONTAINS(Text, Compare_Text)
//informa se uma Sting(text) contem outra string(compare_text)

//com OR

OR(Begins(Title, "Chief"), CONTAINS(Title, "President"))


//Just as with the AND() function, you can write OR() more than one way. You can write BEGINS(Title , "Chief") || CONTAINS(Title , "President").

//OR(), like AND(), can take more than two arguments. To also check if a contact’s Titlecontains the word "Executive", try:

BEGINS(Title, "Chief") ||
CONTAINS(Title, "President") ||
CONTAINS(Title, "Executive")

----------

NOT()
//muda tudo que e true para false

ISBLANK() //se o campo esta em branco
//retorna true se estiver em branco 
//retorna false se estiver preenchido

NOT(
    ISBLANK(FirstName) ||
    ISBLANK(LastName) ||
    ISBLANK(Phone) ||
    ISBLANK(Email) ||
    ISBLANK(MailingAddress) 
)

//o NOT tambem pode ser escrito por !

!(
    ISBLANK(FirstName) ||
    ISBLANK(LastName) ||
    ISBLANK(Phone) ||
    ISBLANK(Email) ||
    ISBLANK(MailingAddress) 
)

------

IF()
//usa 3 argumentos

IF(teste,resultado,alternativa)
//se o teste for verdadeiro, avalie o resultado caso contrario, avalie a alternativa

IF(Mystery_Produce = "Fruit", Mystery_Produce color = "Red", false)
//voce pega o vegetal e verifica se e uma fruta, se for o caso, verifica se e vermelha, se nao, e falso, n e uma fruta


//você quer saber se um contato é um contato primário. Definimos um contato primário como alguém que é um executivo (usando o campo de fórmulas é executivoque criamos antes) e está no departamento de Marketing.
Is_Executive__c && Department = "Marketing"

//com IF
IF(Is_Executive__c, Department = "Marketing", false)

//Descobrimos em qual cidade o contato se baseia olhando para o código de área do número de telefone, com 415 correspondentes a São Francisco e 212 correspondentes a Nova York.
Department = "Marketing" &&
Is_Executive__c &&
BEGINS(Phone, "(415)") ||
Department = "Sales" &&
Is_Executive__c &&
BEGINS(Phone, "(212)")

//com if
IF(Is_Executive__c,
  IF(Department = "Sales", BEGINS(Phone, "212")),
  IF(Department = "Marketing", BEGINS(Phone, "415"), False)), False)



//OUTROS EXEMPLOS DE FORMULA DE CHECKBOX

//Esta fórmula de caixa de seleção designa uma oportunidade tão pequena se a probabilidade for inferior a 50% (0,5), e a receita esperada for inferior a 10.000.
AND(Probability < 0.5, ExpectedRevenue < 10000)

//Esta fórmula marca um caso como prioridade máxima se a prioridade for marcada como alta, o caso é novo ou funcionando, e ou é escalonado ou não foi atualizado em mais de uma semana. Esta fórmula tem um desempenho diferente com base em onde os parênteses são colocados.

ISPICKVAL(Priority, "High") &&
ISPICKVAL (Status, "New") ||
ISPICKVAL (Status, "Working") && 
(IsEscalated || Days_Since_Last_Update__c > 7)

//Esta fórmula, por exemplo, usa parênteses ligeiramente posicionados para verificar se um caso é de alta prioridade, novo ou funcionando, e escalou, ou já se passaram mais de sete dias desde que o caso foi atualizado pela última vez.

ISPICKVAL(Priority, "High") &&
ISPICKVAL (Status, "New") ||
ISPICKVAL (Status, "Working") && IsEscalated ||
Days_Since_Last_Update__c > 7

//Esta fórmula exibe uma caixa de seleção, Ok para Ligar, que é verificada se não há problema em chamar um contato. A fórmula verifica se o contato selecionou Não Ligue. Se o contato não tiver, a fórmula garante que o campo de número de telefone não esteja em branco.

IF(NOT(DoNotcall), NOT(ISBLANK(Phone)), false)


-----
//Numbers, Currency and Percentages

//Number - A positive or negative number, either integer or decimal.
//Currency - A number that comes with a currency sign.
//Percent - A number that comes with a percent sign, stored as a number divided by 100.

/* 
add +
subtract -
multiply *
divide /
exponentiation ^
*/

/*
greater than >
less than <
less than or equal <=
greater than or equal >=
equal =
not equal or do not equal != or <>
*/ 

ROUND() //arredonda um valor numérico que você dá a ele

//calcular um desconto e arredondar-o para dois pontos decimais para que seja um valor de moeda adequado.
ROUND(Price__c - Price__c * Discount__c, 2)

//CALCULAR JUROS POR CENTO
//embora os valores da moeda possam ser negativos, estamos assumindo que Principal__c é positivo. Se não for, esta conta está em apuros!
IF(Principal__c < 10000, 0.02,
  IF(Principal__c >= 10000 &&
    Principal__c < 100000, 0.03, 0.04))


//CALCULAE JUROS ACUMULADOS
//A = Pe^(rt)

//P	- A principal quantidade de dinheiro na conta
//E - A constante matemática 2.71828182845904
//R	- A taxa de juros anual da conta
//T	- O número de anos que a conta foi aberta

//fórmula para calcular juros acumulados e continuamente compostos em uma conta! Você pode vê-lo em ação em qualquer página de conta.
Principal__c * EXP(Interest_Rate__c * (YEAR(TODAY()) - VALUE(YearStarted)))


//EXEMPLOS DE FORMAS NUMERICAS

//Dada a margem percentual, o número de itens vendidos e o preço por item, esta fórmula calcula o lucro da margem bruta.
Margin_percent__c * Items_Sold__c * Price_Item__c

//Esta fórmula de moeda calcula uma comissão, assumindo uma comissão máxima de US $ 500. Dada a existência de uma Comissão de campo porcento personalizado e venda de campo de moeda personalizado, esta fórmula devolve a menor quantia entre US $ 500 e a comissão percentual multiplicada pelo valor de venda.
MIN(500, Sale__c * Commission__c)

//Fórmulas numé séries são úteis para fazer conversões básicas de unidades. Esta fórmula converte temperaturas Celsius em Fahrenheit.
1.8 * Degrees_Celsius__c + 32
E este converte milhas em quilômetros.
Miles__c / 0.6213711921


//ERROS COMUNS

//Dividido por ZERO 0
//certifique se de que NUNCA e ZERO 0
//essa fórmula calcula a receita por empregado em uma conta, dividindo a Receita Anual por Número de Funcionários. Se houver zero funcionários, a fórmula retorna 0, em vez de se der em um erro.

IF(NumberOfEmployees <> 0, AnnualRevenue / NumberOfEmployees, 0)

//Verifique os campos nulos
//usando os operadores =, != para identificar se e nulo
//USE SEMPRE a formula ISBLANK 


//FORMULAS DE DATAS DATA/HORA E HORA

//If you’re subtracting two Time values, the result is in milliseconds and is always positive.

TimeField1__c has the value 10:00 PM and TimeField2__c has the value 9:00 PM:

TimeField1__c - TimeField2__c = 3600000
//The result is never a negative number. Subtraction is the elapsed time between two time values, using a 24-hour clock.

//OPERACOES COMUNS DE DATA, HORA

DATAVALUE() //convere uma data/hora em data
DATATIMEVALUE() //extrai um valor de data ou texto e retorna um valor de data/hora com o horario definido como meia-noite GMT
TIMEVALUE() //converte valores de data/hora ou texto em hora
DATE() //converter dia, mes e ano no valor de data
TODAY() //hoje
NOW() //agora
DAY() //extrair o dia
MONTH() // extrair o mes
YEAR() //extrair o ano
TIMENOW()
HOUR()
MINUTE()
SECONDS()
MILLISECONDS()
WEEKDAY()


//saber quantos dias ha entre a data de hoje e a CreateDate de uma conta
TODAY() -  DATAVALUE(CreateDate)

//se fizer ao contrario, o valor e negativo - DATAVALUE(CreateDate) - TODAY()

CASE() //semelhante ao IF
//diferenca - verifica uma serie de declaracoes chamadas casos

CASE(expression, case1, result1, case2, result2, ... , else_result)

//compara expressão ao caso1. Se forem iguais, devolve o resultado1. Se não forem, compara a expressão ao caso2, e assim por diante. Se a expressão não corresponder a nenhum caso, a declaração retorna else_result.

//util para declarações condicionais que têm muitos resultados possíveis

//Se hoje é um domingo, segunda ou terça-feira, adicionar 3 dias úteis é o mesmo que HOJE() + 3.
//Se hoje é uma quarta, quinta ou sexta-feira, adicionar 3 dias úteis é o mesmo que HOJE() + 5 (3 dias úteis e 2 dias de fim de semana).
//Se hoje é um sábado, adicionar 3 dias úteis é o mesmo que HOJE() + 4 (3 dias úteis e 1 dia de fim de semana).

CASE(
  WEEKDAY(TODAY()),
  4, TODAY() + 2 + 3,
  5, TODAY() + 2 + 3,
  6, TODAY() + 2 + 3,
  7, TODAY() + 1 + 3,
  TODAY() + 3
)


//A unidade para adicionar ou subtrair valores de tempo é milissegundos.
//Quando Timefield1__c tem o valor 17:00 PM:

Timefield1__c + 600000 é 17:10
Timefield1__c - 600000 é 16:50

//Os campos de tempo não incluem uma data. Assim, adicionar 25 horas a um valor de tempo é o mesmo que adicionar 1 hora. O relógio recomeça após 24 horas.


//pode subtrair um campo de tempo de outro em uma fórmula, o resultado é em milissegundos e o resultado nunca é um número negativo.

(ClosedTime - OpenTime) / 3600000


//E, para os seguintes tempos, você tem os seguintes resultados.

//Horário fechado = 17:00, OpenTime = 8:00 AM, Tempo Fechado - OpenTime é 9 horas.

//Horário fechado = 5:00 AM, OpenTime = 7:00 AM, Tempo Fechado - OpenTime é 22 horas.


//Você também pode configurar regras de validação baseadas no tempo. A fórmula a seguir verifica se um turno é de pelo menos 4 horas.

Shift_Ends_Time__c <= (Shift_Start_Time__c + 14400000) 


//EXEMPLOS DE DATA, DATA/HORA, HORA

//Esta fórmula encontra o último dia de um mês subtraindo um dia do primeiro dia do mês seguinte. Ele usa a função ADDMONTHS() para calcular cada mês seguinte antes da subtração.
DATE(YEAR(ADDMONTHS(Date__c,1)), MONTH(ADDMONTHS(Date__c,1)), 1) - 1

//Esta fórmula encontra o número de dias úteis entre hoje e um Date__c antes de hoje. Primeiro a fórmula encontra o número de dias úteis entre hoje e uma segunda-feira conhecida no passado, neste caso, 8 de janeiro de 1900. Dividimos esse número por 7 e usamos o FLOOR() para convertê-lo de dias para semanas. Em seguida, multiplicamos por 5 para convertê-lo de semanas para dias úteis. A fórmula encontra a diferença entre esse valor e o número de dias úteis desde Date__c e a mesma referência segunda-feira. O resultado é o número de dias úteis entre hoje e um Date__c passado.
(5 * (FLOOR((TODAY() - DATE(1900, 1, 8)) / 7)) + MIN(5, MOD(TODAY() - DATE(1900, 1, 8), 7)))
-
(5 * (FLOOR((Date__c - DATE(1900, 1, 8)) / 7)) + MIN(5, MOD(Date__c - DATE(1900, 1, 8), 7 )))

//Esta fórmula adiciona Num_Years__c a Date__c. Ele usa ADDMONTHS(), que lida automaticamente com anos bissextos. Addmonths() considera o último dia de um mês ao realizar operações de matemática. Então, quando você adiciona um mês a uma data que é o dia 30, e o último dia do mês, o resultado é o último dia do próximo mês. Esse valor resultante pode ser o 31º. Da mesma forma, 28 de fevereiro (em um ano não bissexto) mais um mês é 31 de março.Note
ADDMONTHS(Date__c, Num_Years__c * 12)

//Esta fórmula em Casos verifica se os representantes estão ligando para os clientes em um momento preferido. O campo De tempo preferido representa a hora em que um contato especificou que prefere ser contatado para casos de saída. Uma vez que o TIMEVALUE() retorna um valor no fuso horário GMT, o -7 nesta fórmula converte-o em PDT, que é o fuso horário deste contato.
IF(
  IF((HOUR(TIMEVALUE(CreatedDate)) - 7) < 0,
    24 + (HOUR(TIMEVALUE(CreatedDate)) -7),
    (HOUR(TIMEVALUE(CreatedDate)) - 7))
= HOUR(Contact.Preferred_Time__c), TRUE, FALSE)


//ERROS COMUNS
//Conversão entre data, data/hora e hora
//nao sao intercambiaveis
//Se for escrito para retornar um valor de data/hora, uma fórmula com o tipo de retorno data não funcionará. Para converter entre Data, Data/Hora e Hora, use as funções incorporadas DATEVALUE(), DATETIMEVALUE() e TIMEVALUE(). Lembre-se que hoje() retorna a data atual como um valor de data, enquanto NOW() retorna a data e a hora atuais como um valor de data/hora. E o TIMENOW() retorna a data e a hora atuais como um valor de tempo.

//Trabalhando com fusos horários. 
//Os valores de data, data/hora e hora são sempre exibidos no fuso horário do usuário que os está visualizando. Os valores de data/hora são convertidos e armazenados como GMT quando um registro é salvo e, em seguida, convertido novamente quando um usuário fora do GMT os vê. Quando você converte uma data para uma data/hora, a hora é sempre meia-noite GMT. Certifique-se de considerar fusos horários ao converter um valor de data/hora com TEXT(). Quando você converte uma data/hora para texto, ela retorna o tempo em GMT, indicado por um Z no final do valor. O TEXT() sempre gera um valor de texto com o tempo em GMT — não o fuso horário da sua organização. Os valores de tempo não têm local ou fuso horário associados e não são convertidos entre usuários em diferentes fusos horários. Quando você converte uma data/hora para tempo usando timevalue(), o valor GMT é devolvido.

//Anos bissextos e datas inválidas. 
//Ao converter os valores de Data ou Data/Hora ou adicionar anos, meses ou dias a uma data ou data/hora, certifique-se de que seu resultado ainda é uma data válida. Por exemplo, se sua fórmula tiver o resultado em 31 de junho de 2015, o campo de fórmulas exibe #Error! Da mesma forma, se sua fórmula retornar em 29 de fevereiro de 2013 (um ano não bissexto), o campo exibe um erro. Certifique-se de que suas fórmulas respondam por anos bissextos e os diferentes períodos de meses.


//LISTAS DE OPCOES EM FORMULAS

//Um campo picklist permite que você escolha um valor de uma lista pré-preenchida. Embora você não possa escrever uma fórmula que retorna uma picklist como resultado, você provavelmente tem que referenciar picklists em seus campos de fórmula.

//exige que um usuário preencha o campo de texto Outro Tipo se definir o Tipo da conta como "Outro".

ISPICKVAL(Type, "Other") &&
ISBLANK(Other_Type__c)

//Três funções tomam valores de picklist como argumentos em todos os campos de fórmula: ISPICKVAL(), CASE() e TEXT().

ISPICKVAL (picklist_field, text_value)
// retorna verdadeiro se o valor de picklist_field corresponder text_value e falso de outra forma.
//da pra combinar ISPICKVAL() com PRIORVALUE()

//impede que um usuário altere o tipo de um caso de um valor selecionado anteriormente de volta para branco.
NOT(ISPICKVAL(PRIORVALUE(Type), "")) &&
ISPICKVAL(Type, "")


//Esta fórmula com o tipo de retorno de número atribui a um caso uma prioridade com base em seu tipo.

CASE(Type,
  "Electrical", 1,
  "Electronic", 2,
  "Mechanical", 3,
  "Structural", 4,
  "Other", 5,
5)

//A fórmula compara tipo a cada caso, atribuindo uma prioridade quando encontra uma correspondência. Os casos elétricos são priorizados de 1, caixas eletrônicas 2, e assim por diante.


TEXT() //converte um valor de picklist em um valor de texto na linguagem mestre da sua organização, não no idioma do usuário atual. Depois que um valor de picklist foi convertido em um valor de texto, você pode usar funções de texto, como BEGINS() e CONTAINS(), nele.

//Esta fórmula, por exemplo, exibe o Status de um caso como uma sentença.

"This case is " & TEXT(Status)


//ISPICKVAL() e CASE() são úteis para criar regras de validação que verifiquem se um determinado valor de picklist está selecionado. 

//digamos que você deseja que os usuários insiram uma razão quando eles alteram o valor de lista de status de um caso para Escalado.

AND(
  ISPICKVAL(Status, "Escalated"),
  ISBLANK(Reason_for_Escalating__c)
)


//Usaremos o CASE() para atribuir a cada possibilidade uma prioridade com base nas seguintes condições.

CASE(Account.Rating,
  "Hot", 1,
  "Warm", IF(Is_Executive__c, 1, 2),
  "Cold", IF(Is_Executive__c, 2, 3),
3)

//Nesta fórmula, utilizamos declarações IF() dentro da declaração CASE maior para verificar com mais eficiência todos os seis casos.

//EXEMPLOS PICKLIST
//Esta fórmula retorna o número de dias desde que uma conta foi ativada com base no status do contrato do campo de picklist personalizado e na data personalizada data de contrato ativado. Se o Status do Contrato não for ativado, o campo será em branco.
IF(ISPICKVAL(Contract_Status__c, "Activated"),
  TODAY() -
  Contract_Activated_Date__c, null)

//Esta fórmula usa a data personalizada data de pagamento data Data de vencimento e o status de pagamento de campo picklist personalizado com as opções Pagas e Não Pagas no objeto Contrato. Se o Status de Pagamento não for pago e passar da data de vencimento do pagamento, o campo de fórmula exibe pagamento em atraso! Caso contrário, o campo está em branco.
IF(AND(Payment_Due_Date__c < TODAY(),
  ISPICKVAL(Payment_Status__c,
  "UNPAID")),
  "Payment overdue!", null)

//Esta regra de validação usa ISPICKVAL() e PRIORVALUE() para exibir um erro se alguém tentar alterar o Status de um lead de "Fechado - Convertido" ou "Fechado - Não Convertido" para "Aberto - Não Contatado".
ISPICKVAL(Status, "Open - Not Contacted") &&
BEGINS(TEXT(PRIORVALUE(Status)), "Closed")

//ERROS COMUNS
//As únicas funções que podem tomar campos de picklist como parâmetros em todos os campos de fórmula são ISPICKVAL(), CASE() e TEXT(). O uso de valores de picklist em qualquer outra função resulta em um erro. Este campo de fórmula de caixa de seleção, por exemplo, destina-se a exibir uma caixa de seleção que indica se a Fonte de chumbo é "Referência de parceiro". O operador igual (=), no entanto, não suporta campos de picklist, e esta fórmula causa um erro.
LeadSource = "Partner Referral"
//Em vez disso, use ISPICKVAL() para verificar o valor de um campo de picklist ou use TEXT() para converter um valor de picklist em Texto antes de usar o operador de iguais.
ISPICKVAL(LeadSource, "Partner Referral")
TEXT(LeadSource) = "Partner Referral"



//TEXTO EM FORMULAS
//As fórmulas que usam o tipo de retorno texto podem concatenar valores de texto, converter números e datas em texto ou exibir texto condicionalmente.

//A coisa mais simples que você pode fazer é concatenar duas cordas de texto com o operador &. Por exemplo, você pode exibir o nome completo de um contato combinando o nome e o sobrenome.

FirstName & " " & LastName

//Converting to and from Text Values

//TEXT() converte um campo por cento, número, data, data/hora, picklist ou moeda em texto.
//TEXT() retorna a saída sem qualquer formatação, vimas ou sinais de moeda. 
//TEXT(percent_value), se percent_value for definido para 30%, retorna 0,3.

TEXT()//Quando o TEXT() receber um valor de data ou data/hora, ele retorna uma sequência com a formatação de data/data/hora padrão. 
//Por exemplo, se date_value corresponder a 17 de março de 2015, o TEXT(date_value) retorna 2015-03-17. 
//Para datetime_value 17 de março de 2015 às 17:00, TEXT(datetime_value) retorna 2015-03-17 17:00:00Z. O Z indica que o tempo devolvido está em GMT — TEXT() sempre retorna valores data/hora em GMT, não o fuso horário do usuário atual ou sua organização.

VALUE() //Você também pode converter valores de outra forma usando VALUE(), que pega um valor de texto e retorna um número. 
//Se o VALUE() receber um valor que não é um Número, incluindo quaisquer caracteres especiais que não sejam um ponto decimal ou menos sinal (negativo), ele exibir #Error! Por exemplo, se text_value for $500, VALUE (text_value) retornará um erro. O VALUE() também retorna um erro se text_value estiver em branco.

BEGINS(text, compare_text) //returns true if text begins with compare_text. 
CONTAINS(text, compare_text) //returns true if compare_text is anywhere in text.
SUBSTITUTE(text, old_text, new_text) //returns text with any instance of old_text substituted with new_text, much like the find and replace function in a text editor.


//ATRIBUIT MA CLASSIFICACAO DE COTA

//Avaliar um lead com base em sua receita, pais ou origem
//Hot—AnnualRevenue is greater than $1 million, the Country is the United States, and the LeadSource is Partner Referral.
//Warm—AnnualRevenue is greater than $1 million, the Country is the United States, and the LeadSource is either Purchased List or Web.
//Cold—The account doesn’t meet any of those conditions.

IF(
  AnnualRevenue > 1000000 &&
  CONTAINS(CASE(Country, "United States", "US", "America",
    "USA", "NA"), "US"),
  IF(
    ISPICKVAL(LeadSource, "Partner Referral"), "Hot",
    IF(
      ISPICKVAL(LeadSource, "Purchased List") ||
      ISPICKVAL(LeadSource, "Web"),
      "Warm", "Cold"
    )
  ), "Cold"
)


//IMAGE com CASE()

IMAGE()
//A função IMAGE() leva até quatro argumentos. A IMAGEM (image_url, alternate_text, altura, largura) exibe a imagem especificada por image_url com as dimensões especificadas pelos argumentos de altura e largura opcionais. Se a imagem não puder ser exibida, a função será exibida alternate_text.

//Hot, the formula shows five stars
//Warm, the formula shows three stars
//Cold, the formula shows one star

IMAGE(
  CASE(Rating__C,
    "Hot", "/img/samples/stars_500.gif",
    "Warm", "/img/samples/stars_300.gif",
    "Cold", "/img/samples/stars_100.gif",
    "/img/samples/stars_000.gif"),
"Unknown")

//EXEMPLOS DE TESTE

//Esta fórmula usa o campo Estado/Província de Billing de uma conta baseada nos EUA para classificá-la como Norte, Sul, Leste, Oeste ou Central.
IF(ISBLANK(BillingState), "None",
IF(CONTAINS("AK:AZ:CA:HA:NV:NM:OR:UT:WA", BillingState), "West",
IF(CONTAINS("CO:ID:MT:KS:OK:TX:WY", BillingState), "Central",
IF(CONTAINS("CT:ME:MA:NH:NY:PA:RI:VT", BillingState), "East",
IF(CONTAINS("AL:AR:DC:DE:FL:GA:KY:LA:MD:MS:NC:NJ:SC:TN:VA:WV", BillingState), "South",
IF(CONTAINS("IL:IN:IA:MI:MN:MO:NE:ND:OH:SD:WI", BillingState), "North", "Other"))))))
//Esta fórmula incorpora um link com a função HYPERLINK(). Geralmente, o HYPERLINK (url, display_text, target) exibe um link para url com display_text. O argumento de destino opcional determina como a página da Web é exibida quando o link é clicado. Se você deixar o alvo em branco, o link será aberto em uma nova janela do navegador por padrão.

HYPERLINK("https://www.salesforce.com", "Salesforce")

//Esta fórmula pega o e-mail de campo e o usa para criar uma URL. A fórmula usa FIND() e SUBSTITUTE() para encontrar o sinal @ no endereço de e-mail e substituir tudo à esquerda dele por www.
SUBSTITUTE(Email, LEFT(Email, FIND("@", Email)), "www.")


//Erros comuns com fórmulas de texto
//Conversão de valores em texto. Certifique-se de verificar o tipo de um campo antes de usá-lo em uma fórmula. Por exemplo, um administrador anterior da Salesforce poderia ter criado um campo personalizado que mantém uma data como um valor de texto. Se esse for o caso, você pode usar TEXT() ou DATEVALUE() para trabalhar com valores de Texto e Data em conjunto.


//FORMULAS AUXILIARES

//Usar campos de fórmula de ajudante é uma ótima maneira de tornar suas fórmulas curtas e fáceis de entender. Um campo de ajudante faz apenas parte de um cálculo maior e é referenciado pelo campo de fórmula final. Você pode usar campos de fórmula de ajudante com qualquer tipo de fórmula, mas vamos olhar para um exemplo agora.

//Digamos que você queira escrever uma fórmula de texto chamada Case_Category__c que exibe uma categoria para um caso (Verde, Amarelo ou Vermelho) dependendo de quanto tempo esse caso está aberto. Normalmente, você pode escrever algo assim.

IF(((NOT(IsClosed)) && (TODAY() - DATEVALUE(CreatedDate) > 20)), "RED",
 IF((NOT(IsClosed)) && (TODAY() - DATEVALUE(CreatedDate) > 10), "YELLOW",
 "GREEN"))

//Você pode simplificar esta fórmula colocando a lógica para calcular a idade do caso em outro campo de fórmula. Vamos chamar esse campo de Case_Age_In_Days__c.
TODAY() - DATEVALUE(CreatedDate)

//Então, podemos reescrever Case_Category__c assim.
IF(((NOT(IsClosed)) && (Case_Age_In_Days__c > 20)), "RED",
 IF((NOT(IsClosed)) && (Case_Age_In_Days__c > 10), "YELLOW",
 "GREEN"))

 