
//a atribuição ordinal começa em zero. Por exemplo, se você tivesse um enum como o seguinte.

public enum myEnums {
            Enum1,
            Enum2,
            Enum3
 }

//Se você tentasse acessar o valor ordinal do terceiro enum, o valor da variável enumOrd seria 2.

Integer enumOrd = myEnums.Enum3.ordinal();

//----- Colecoes - Apex suporta apenas 3 biblioteca de coleta com inúmeros tipos e métodos de extensão. 
 NOTE - //List
 //Uma lista em uma coleção ordenada de elementos que funciona muito igual a uma matriz tradicional. Na verdade, matrizes no Apex são sinônimos de listas, e você pode usá-las intercambiavelmente. Por exemplo, a seguir é uma maneira de declarar uma variável como uma lista de strings.
List<String> myStrings =  new List<String>();

//Alternativamente, você pode declarar a variável myStrings como uma matriz, mas atribuí-la a uma lista em vez de uma matriz.
String[] myStrings = new List<String>();

//Outra coisa que você pode fazer é declarar a lista e inicializar seus valores, tudo em um passo, como o seguinte.
List<String> myStrings =  new List<String> {'String1', 'String2', 'String3' };

//Você também pode adicionar valores à lista depois de criada, como esta:
List<String> myStrings = new List<String>();
myStrings.add('String1');
myStrings.add('String2');
myStrings.add('String3');

//Você provavelmente criará muitas variáveis de lista no seu desenvolvimento apex, porque a saída de cada consulta SOQL é uma lista. Por exemplo, você pode criar uma lista de contas usando código, como o seguinte:
List<Account> myAccounts = [SELECT Id, Name FROM Account];

//Como matrizes, listas têm índices que começam em zero. Assim, você pode acessar o nome da primeira conta na lista com código como este:
List<Account> myAccounts = [SELECT Id, Name FROM Account];
String firstAccount = myAccounts[0].Name;

NOTE - //SET
//Um conjunto é uma coleção não rdenada de elementos que não contém duplicatas. Um conjunto é comumente usado para armazenar valores de ID porque o valor é sempre único. Em seguida, você pode usar o conjunto como parte de uma cláusula WHERE em uma consulta SOQL. 
//--------Por exemplo, aqui estamos criando um conjunto que contém dois IDs exclusivos para Contas. Em seguida, usamos o conjunto na consulta SOQL para retornar contas apenas para esses IDs.
Set<ID> accountIds = new
  Set<ID>{'001d000000BOaHSAA1','001d000000BOaHTAA1'};  
List<Account> accounts = [SELECT Name
  FROM Account WHERE Id IN :accountIds];    


NOTE - //Map
//Um mapa é uma coleção de pares de valor-chave. Cada chave mapeia para um único valor. Um mapa é útil quando você precisa encontrar algo rapidamente por uma chave. Os valores-chave devem ser únicos, para que você possa ter um mapa que continha valores de ID para a chave e, em seguida, mapeado para um sObject. 
//--------Por exemplo, você pode usar o seguinte código para declarar uma variável de mapa chamada AccountMap que contém todas as contas mapeadas para seus IDs.
Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Name FROM Account]);

//Em seguida, você pode acessar um registro de conta específico usando o método get e o código semelhante ao seguinte.
Id accId = '001d000000BOaHSAA1';
Account account = accountMap.get(accId);


NOTE - //sObjct Types
//O termo sObject refere-se a qualquer objeto que possa ser armazenado no banco de dados da plataforma Force.com. Uma variável sObject representa uma linha de dados e só pode ser declarada no Apex usando o nome API SOAP do objeto. por exemplo:
Account a = new Account();
MyCustomObject__c co = new MyCustomObject__c();

//Similar to the SOAP API, Apex allows the use of the generic sObject abstract type to represent any object. The sObject data type can be used in code that processes different types of sObjects.
//The new operator still requires a concrete sObject type, so all instances are specific sObjects. For example:
sObject s = new Account();

//You can also use casting between the generic sObject type and the specific sObject type. For example:
// Cast the generic variable s from the example above
// into a specific account and account variable a
Account a = (Account)s;
// The following generates a runtime error
Contact c = (Contact)s;

//Because sObjects work like objects, you can also have the following:
Object obj = s;
// and
a = (Account)obj;

//DML operations work on variables declared as the generic sObject data type as well as with regular sObjects.

//sObject variables are initialized to null, but can be assigned a valid object reference with the new operator. For example:
Account a = new Account();

//Developers can also specify initial field values with comma-separated name = value pairs when instantiating a new sObject. For example:
Account a = new Account(name = 'Acme', billingcity = 'San Francisco');

//Custom labels are not standard sObjects. You cannot create a new instance of a custom label. You can only access the value of a custom label using system.label.label_name. For example:
String errorMsg = System.Label.generic_error;

NOTE - //Visualforce
//Por enquanto, só queremos dar-lhe uma ideia básica de como ele funciona mostrando-lhe um exemplo. Você pode usar o seguinte código de marcação para renderizar uma página simples usada para inserir dados de contato.
<apex:page standardController="Contact">
  <apex:form>
    <apex:pageBlock title="Edit Contact" mode="Edit">
       <apex:pageBlockButtons >
         <apex:commandButton action="{!edit}" id="editButton" value="Edit"/>
         <apex:commandButton action="{!save}" id="saveButton" value="Save"/>
         <apex:commandButton action="{!cancel}" id="cancelButton" value="Cancel"/>
       </apex:pageBlockButtons>
       <apex:pageBlockSection >
          <apex:inputField value="{!contact.lastname}" />
          <apex:inputField value="{!contact.accountId}"/>
          <apex:inputField value="{!contact.phone}"/>
       </apex:pageBlockSection>
    </apex:pageBlock>
  </apex:form>
</apex:page>




//https://developer.salesforce.com/docs/atlas.en-us.198.0.apexcode.meta/apexcode/langCon_apex_data_types.htm






