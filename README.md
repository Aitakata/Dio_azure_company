# Dio_azure_company
Implementação do Desafio do modulo 3 durante a trilha Processamento de dados com Power BI do bootcamp Suzano - Analise de dados como Power BI

Descrição dos arquivos:
* script_bd_company - script para a criação do BD no MySQL
* script_insert_company.sql - script para popular o BD no MySQL
* azure_company.pbix - ambiente dentro do Power BI em que o BD foi importado e depois realizada as transformações para adequar as consultas.

Etapas
1. Criação de uma instância na Azure para MySQL

Tentamos a implementação usando Mysql no Azure. Como não tenho uma conta corporativa tentei usar minha conta de estudante, mas ao tentar criar o banco de dados recebe a mensagem
![image](https://github.com/user-attachments/assets/9e4febc6-3949-4cb8-95e3-79b5f1705ff8)
aparentemente tenho limitaçoes na conta, por isso, baixei o MySQL localmente e fiz as implementaçoes. 

2. Criar o banco de dados
   O banco de dados foi criado a partir de:
   https://github.com/julianazanelatto/power_bi_analyst/tree/main/M%C3%B3dulo%203/Desafio%20de%20Projeto <br>
Alterações implementadas:
*	Quando acronimo manter tudo em maiúsculo.
  Ex.Ssn -> SSN (Social Security Number)
-	Sempre que a palavra se referir a mesma informação, usar a mesma palavra.<br>  Por exemplo, a palavra number, às vezes, está escrita por completo “number” e, outras vezes, está abreviada para “no” ou “num”. Vou usar sempre como "number", ou seja, o número do departamento que dependendo da tabela estava como "Dno" ou "Dnum" será sempre Dnumber. Para se referir a um atributo de uma tabela que tenha o mesmo nome vamos usar o formato <tabela>.<atributo> para me referir a coluna.<br>
 	Ex.:<br>
  employee.Dnumber = nro do departamento na tabela employee
  department.Dnumber = nro do departamento na tabela department
*	O nome de uma constraint terá o formato <br>

| Constraint            | função   |atributo   | tabela origem  | tabela referencia |
|:----------------------|:--------:|:---------:|:--------------:|:-----------------:|
| chk_salary_employee   | chk      | salary    | employee       |                   |
| pk_employee           | pk       |           | employee       |                   |
| fk_project_department | fk       |           | project        | department        |

3. Integração com o Power BI
   ![image](https://github.com/user-attachments/assets/ced45059-f5bf-475c-bd0d-6a89b206f312)

  selecionar todas as tabelas
   ![image](https://github.com/user-attachments/assets/a85920f5-d90d-46b8-8745-789d89e3afef)

4. Verificação de problemas na base MySQL e respectivas transformações<br>
4.1. Formato dos dados<br>
   atributo **salario** alterado para **decimal fixo (2 casas decimais)<br>
4.2. Na tabela employee, juntar as colunas Fname, Minit e Lname, e criar a coluna Full_name.<br>
4.3. Existencia de nulos e dados inconsistentes<br>
   Só tem um null na tabela employee, mas nesse caso faz sentido, indica que o colaborador não tem superior. O colaborador "James E Borg" não tem superior, pode ser o CEO. Colaboradores como o "Franklin" e a "Jeniffer" estão no escalão intermediário, estão subordinados ao "James" e também colaboradores como "John", "Ramesh" e "Joyce" subordinados a eles.<br>
4.4. Não há departamentos sem gerentes <br>
4.5. Número de horas trabalhados<br>
   Estão ok. Alguns horarios estão quebrados, por exemplo, 3.5, mantive assim, mas dependendo da análise pode ser interessante transformar em números inteiros, arredondando (para cima ou para baixo) ou simplesmente eliminando a parte fracionária.<br>
4.6. Separar colunas complexas<br>
   A coluna **Address** foi quebrada em Address_number, Address_street, Address_city e Address_state.<br>
4.7. Mesclar employee e department criando uma nova tabela employee com o nome do departamento em que o colaborador esta lotado.<br>
4.8. Elimine as colunas desnecessárias<br>
   Ex.: agora a tabela employee tem o nome do departamento, não necessitamos mais da coluna Dnumber (número do departamento em que o colaborador esta lotado), portanto, podemos removê-lo.<br>
4.9. Junção de employee com ele mesmo, agora em vez de ter o número do SSN do superior, vamos criar uma coluna com o nome do superior.<br>
![image](https://github.com/user-attachments/assets/5be45433-f7e6-4418-a9a6-edc109e45d10)
4.10. Mesclar os nomes de departamento e localizaçao. Isso irá auxilizar o modelo estrela em módulo futuro.<br>
Nesse caso, não podemos usar o *atribuir* porque os dados não são similares, são atributos diferentes e precisam ser criadas novas colunas e não novas linhas.<br>
4.11. Agrupe os dados a fim de saber quantos colaboradores existem por gerente<br>
![image](https://github.com/user-attachments/assets/e44dcfc8-9061-4c2f-885e-0682798a2c32)


   
   
