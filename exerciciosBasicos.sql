SET search_path TO universidade;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'universidade'
  AND table_type = 'BASE TABLE';

/*1.9 Listar a matrícula de todos os professores que orientam algum aluno e que não são
chefes de algum departamento.*/

SELECT mat_professor AS prof
FROM plano
EXCEPT
SELECT chefe AS prof
FROM departamento

/*1.8 Listar a matrícula de todos os professores que orientam algum aluno e que são
chefes de algum departamento.*/

SELECT mat_professor AS prof
FROM plano
INTERSECT
SELECT chefe AS prof
FROM departamento
WHERE chefe IS NOT NULL
ORDER BY prof;

/*1.7 Listar a matrícula de todos os professores que orientam algum aluno ou que são
chefes de algum departamento.*/

SELECT mat_professor AS prof
FROM plano
UNION
SELECT chefe AS prof
FROM departamento
WHERE chefe IS NOT NULL
ORDER BY prof;

SELECT DISTINCT pr.mat_professor /*Tá errada*/
FROM professor pr JOIN plano pl ON(pr.mat_professor = pl.mat_professor) 
						JOIN departamento de ON(pr.mat_professor = de.chefe)
ORDER BY mat_professor
	
SELECT *
FROM departamento;

SELECT *
FROM plano;

SELECT *
FROM professor;

/*1.6 Listar o número de professores que orientam algum aluno*/
/*Fiquei um pouco em dúvida*/

SELECT count(mat_professor) /*professor só pode orientar até 1 aluno por vez*/
FROM plano;
	
SELECT *
FROM plano;

SELECT *
FROM professor;

SELECT *
FROM estudante;

SELECT *
FROM projeto;

/*1.5 Calcule a média de notas de todos os alunos.*/

SELECT avg(mc)
FROM estudante;

/*1.4 Liste o nome e código de todas as disciplinas que tenham pré-requisito e tenham
mais de 2 créditos.*/

SELECT nome, cod_disc
FROM disciplina
WHERE (pre_req IS NOT NULL) AND creditos > 2;

/*1.3 Liste o nome, sobrenome e cpf de todas as pessoas que têm telefone.*/

SELECT primeiro_nome, sobrenome, cpf, telefone
FROM usuario
WHERE telefone IS NOT NULL;

/*1.2 Liste o id de todas as turmas que o aluno de matrícula ‘E101’ está cursando.*/

SELECT id_turma
FROM cursa
WHERE mat_estudante = 'E101';

SELECT mat_estudante, id_turma
FROM cursa
WHERE mat_estudante = 'E101';

SELECT *
FROM cursa;

SELECT *
FROM estudante;

/*1.1 Liste o cpf dos professores do departamento ‘DMA”.*/

SELECT cpf
FROM professor
WHERE departamento = 'DMA'

SELECT cpf, mat_professor
FROM professor
WHERE departamento = 'DMA'

SELECT * 
FROM professor;

SELECT *
FROM departamento;

/*
* Quando a questão não especificar as colunas, use SELECT *
1 - Esquema universidade
1.1 Liste o cpf dos professores do departamento ‘DMA”.
1.2 Liste o id de todas as turmas que o aluno de matrícula ‘E101’ está cursando.
1.3 Liste o nome, sobrenome e cpf de todas as pessoas que têm telefone.
1.4 Liste o nome e código de todas as disciplinas que tenham pré-requisito e tenham
mais de 2 créditos.
1.5 Calcule a média de notas de todos os alunos.
1.6 Listar o número de professores que orientam algum aluno
- Um professor orienta um aluno se ambos estão associados na tabela plano
1.7 Listar a matrícula de todos os professores que orientam algum aluno ou que são
chefes de algum departamento.
1.8 Listar a matrícula de todos os professores que orientam algum aluno e que são
chefes de algum departamento.
1.9 Listar a matrícula de todos os professores que orientam algum aluno e que não são
chefes de algum departamento.
*/
