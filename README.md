# ecopoint

Proporcionando Negócios Sustentáveis
## RESUMO E INFORMAÇÕES PARA AVALIAÇÃO

Esse é um aplicativo desenvolvido para melhorar a qualidade dos serviços de reciclagem. 
Foi desenvolvido no Android Studio, usando o software Flutter e a Linguagem de Programação Dart. 
##
https://developer.android.com/studio

https://flutter.dev/

https://dart.dev/
##

Empregamos alguns "packages" fundamentais para o projeto, como databases, por exemplo. Todos eles podem ser encontrados na pasta "pubspec.yaml", mas também abaixo:
  firebase_core: ^0.4.5
  firebase_auth: ^0.16.1
  cloud_firestore: ^0.13.7
  firebase_storage: ^3.1.6
  image_picker: ^0.6.7+11
  ##
  https://pub.dev/packages/firebase_core
  https://pub.dev/packages/cloud_firestore
  https://pub.dev/packages/firebase_auth
  https://pub.dev/packages/firebase_storage
  https://pub.dev/packages/image_picker
  
  ##
Na pasta lib, é possível vizualizar quatro itens principais: 
O arquivo "main" é onde incia-se o processo. Dali segue-se para a aplicação completa.
A pasta "CadLog" contém as telas nas quais o usuário comum cadastrar-se-á e usará o aplicativo, incluindo Login/Cadastro na tela "Login.dart", tela "Home" (que engloba a tela de cupons conquistados - chamada de "Cupons.dart", resumo do aplicativo  - "description.dart" - e aquela na qual estarão os desafios a serem cumpridos - "Desafios.dart" ou "Painel Secundario", onde é possível informar a cada empresa que o seu desafio foi completo para que se verifique a veracidade disso, usando a tela "GeralAnuncio.dart"). 

A pasta "Company", como o próprio nome sugere, possui como foco as empresas. Nela, na tela "Login2.dart" é feito o cadastro com mais personalização em "Vido.dart", em que pode-se adiconar a logo da empresa e atualizar seu nome. Ademais, na Novo.dart (que se encontra na pasta "CadLog"), são criados os desafios, incluindo os requisitos, o título e o seu prêmio. Esses aparecem automaticamente na tela do usuário já mencionada. Outrossim, na seção "CriarAnuncio.dart", vemos a tela em que a empresa pode encontrar (e/ou apagar) os desafios por ela criados. Enfim, temos a tela "DesafiosCOmpletos", onde vê-se os usuários que completaram cada desafio. Caso seja verificado que o usuário realmente cumpriu todos os pré-requisitos, confirma-se tal feito e o usuário recebe um cupom com o prêmio estabelecido. 

Por fim, temos a pasta "Classes", que é onde se criam cada classe utilizada ao longo do trabalho - como "Usuario.dart", "Empresa.dart" "Proposta.dart" (utilizada como sinônimo de Desafio) e "item proposta". 
