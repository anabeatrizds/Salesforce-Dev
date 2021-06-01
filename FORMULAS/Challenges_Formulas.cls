//this formula should reference the hidden IsClosed checkbox field on the Opportunity object, and you will be creating the formula as an Opportunity validation rule.
//The validation rule should be on the Opportunity object
//The validation rule should be named 'Close_Date_Alert'
//The validation rule should fire if IsClosed is not selected and CloseDate is yesterday or earlier
//The validation rule should display the error 'Hey McFly, unless you are planning to go back in time, please update your close date' at the top of the page when triggered

AND(CloseDate < TODAY(), NOT(IsClosed)


//calcule o volume de um cilindro para você, arredondado para o número inteiro mais próximo, dado o seu raio e altura. 
//V = πr2h
//onde estão o raio do cilindro, h é a altura, e π é o Pi constante
//Crie 2 campos personalizados do tipo Número no objeto Oportunidade: 'raio' com um nome de API resultante de 'radius__c' e 'altura' com um nome de API resultante de 'height__c'.
//a fórmula deve ser nomeada 'Volume de cilindro', com o nome API resultante 'Cylinder_Volume__c' e deve ser criada no objeto Opportunity.
//A fórmula deve fazer referência aos campos personalizados 'radius__c' e 'height__c'.
//A fórmula deve usar 3.14159 como uma aproximação de Pi.
//A fórmula deve ter 0 pontos decimais.

3.14159 *  radius__c * radius__c *  height__c


//Crie uma fórmula de regra de validação que não permita que um usuário marque um caso como escalonado a menos que a prioridade seja definida como 'Alta', o caso não foi encerrado quando criado, e o caso não é encerrado.
//A regra de validação deve estar no objeto Case.
//A regra de validação deve ser nomeada "Mark_as_Escalated".
//A regra de validação deve ser acionada se alguém tentar definir um caso como escalonado e ele é fechado, fechado quando criado, ou não tem prioridade de Alta.
//A regra de validação deve exibir a mensagem de erro "Você só pode definir um caso como escalonado se for de alta prioridade e não fechado" no campo Escalado quando acionado.
//Adicione o campo 'Escalado' ao layout da página Case.

IF( IsEscalated , OR(IsClosedOnCreate , 
ISPICKVAL(Status, "Closed"), 
ISPICKVAL(Priority, "Low"), 
ISPICKVAL(Priority, "Medium")), 
null)

//Os gerentes de vendas pediram uma solução rápida para ver a completude nos leads. Crie um campo de fórmula de ajudante que olhe para 5 campos-chave no objeto Lead e avalie sua completude, em seguida, um segundo campo de fórmula que faz referência à fórmula do ajudante e retorna uma imagem.
//O campo de fórmula do ajudante deve estar no objeto Lead com o nome de 'Ajudante de Qualidade de Chumbo' e um nome de API resultante de 'Lead_Quality_Helper__c'.
//A fórmula do ajudante deve ser do tipo Número.
//A fórmula do ajudante deve avaliar os seguintes 5 campos: E-mail, telefone, empresa, título e indústria e retornar 0 se em branco e 1 se não estiver em branco. A fórmula deve então adicionar todos os valores juntos para devolver um valor total.
//A fórmula de imagem deve estar no objeto Lead com um nome de 'Qualidade de chumbo' e um nome de API resultante de 'Lead_Quality__c'.
//A fórmula da imagem deve fazer referência à fórmula do ajudante e retornar uma imagem com base no número devolvido pela fórmula do ajudante. A fórmula de imagem deve ser do tipo Texto. Nota: Todas essas imagens já estão disponíveis na sua Edição de Desenvolvedores.
//1 = /img/amostras/stars_100.gif com texto alternativo '1 estrela'
//2 = /img/amostras/stars_200.gif com texto alternativo '2 estrelas'
//3 = /img/amostras/stars_300.gif com texto alternativo '3 estrelas'
//4 = /img/amostras/stars_400.gif com texto alternativo '4 estrelas'
//5 = /img/amostras/stars_500.gif com texto alternativo '5 estrelas'
//Se nenhum dos campos for preenchido, o padrão deve ser /img/samples/stars_000.gif com texto alternativo '0 estrelas'.
//A fórmula 'Qualidade de chumbo' deve ser adicionada ao layout da página do Lead Layout.






//Crie um campo de fórmula que classifique uma oportunidade como "Early", "Middle" ou "Late". Este campo de fórmula deve usar TODAY() para calcular qual a porcentagem do tempo entre o CreatedDate e o CloseDate de uma oportunidade passou, e rotular a oportunidade de acordo.
//Esta fórmula deve estar no objeto Oportunidade
//Esta fórmula deve ser nomeada 'Progresso de Oportunidade' com o nome de API resultante Opportunity_Progress__c
//Esta fórmula deve retornar 'Early' se menos ou igual a 25% de uma oportunidade já passou
//Esta fórmula deve retornar 'Middle' se entre 25% e 75% de uma oportunidade tiver passado
//Esta fórmula deve retornar 'Atrasado' se mais de 75% de uma oportunidade já passou
//Esta fórmula deve fazer referência a um campo de fórmula de ajudante, também no Objeto oportunidade, com o tipo Porcentagem e o nome Por cento concluído
//O percentual concluído deve retornar a porcentagem do tempo que passou entre o CreatedDate e o CloseDate de uma oportunidade

Percent Completed field:
(DATEVALUE( CreatedDate ) - CloseDate ) / 100

Opportunity progress :
IF(  Percent_Completed__c  < 25 , "Early", 
IF(Percent_Completed__c >25 && Percent_Completed__c <75 ,"Middle","Late"))




///LASTDAYMONTH
DATE(
YEAR( TODAY() ),
MONTH( TODAY() ),
IF(
OR(
MONTH( TODAY() ) = 4,
MONTH( TODAY() ) = 6,
MONTH( TODAY()) = 9,
MONTH( TODAY()) = 11
),
30,
IF(
MONTH( TODAY() ) = 2,
28,
31
)
)
)