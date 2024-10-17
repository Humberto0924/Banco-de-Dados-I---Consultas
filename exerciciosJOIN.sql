SET search_path TO universidade;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'universidade'
  AND table_type = 'BASE TABLE';

/*1.12 Liste o nome das disciplinas das turmas que não tem alunos cursando. - OUTER JOIN*/

SELECT d.nome
FROM (disciplina d JOIN turma t ON(d.cod_disc = t.cod_disc)) LEFT JOIN cursa c ON(t.id_turma = c.id_turma)
WHERE c.id_turma IS NULL
ORDER BY d.nome

SELECT *
FROM disciplina /*referencia departamento em depto_responsavel e ela mesma em pre_req, e tem seu nome em nome*/

SELECT *
FROM turma /*referencia disciplina em cod_disc*/

SELECT *
FROM estudante /*referencia usuario em cpf*/

SELECT *
FROM cursa /*referencia estudante em mat_estudante e turma em id_turma*/
WHERE nome='COMP0198'
	
/*1.11 Liste o primeiro nome e sobrenome dos professores que não lecionam turmas. -
OUTER JOIN
*/

SELECT u.primeiro_nome, u.sobrenome
FROM (professor pr JOIN usuario u ON(pr.cpf = u.cpf)) LEFT JOIN leciona l ON(pr.mat_professor = l.mat_professor)
WHERE l.mat_professor IS NULL

SELECT *
FROM leciona /*referencia turma e professor em id_turma e mat_professor*/

SELECT *
FROM professor /*referencia usuario em cpf, departamento em departamento e cargo em cargo*/

/*1.10 Liste o primeiro nome e sobrenome de todos alunos e o primeiro nome e sobrenome
dos professores, independente da orientação. - OUTER JOIN
*/

SELECT u.primeiro_nome, u.sobrenome
FROM ((estudante e RIGHT JOIN usuario u ON(e.cpf = u.cpf)) LEFT JOIN professor pr ON(u.cpf = pr.cpf))
ORDER BY u.primeiro_nome, u.sobrenome

SELECT *
FROM professor /*referencia usuario em cpf, departamento em departamento e cargo em cargo*/

SELECT *
FROM estudante /*referencia usuario em cpf*/

SELECT *
FROM plano /*referencia professor em mat_professor, estudante em mat_estudante e projeto em id_projeto*/


/*1.9 Liste o primeiro nome e sobrenome de todos os professores e o primeiro nome e
sobrenome de seus orientandos (alunos que são orientados), inclusive os professores sem
orientandos. - OUTER JOIN*/

SELECT up.primeiro_nome, up.sobrenome, ue.primeiro_nome, ue.sobrenome
FROM (((professor pr JOIN usuario up ON(pr.cpf = up.cpf)) LEFT JOIN plano pl ON(pr.mat_professor = pl.mat_professor))
	LEFT JOIN estudante e ON(pl.mat_estudante = e.mat_estudante)) LEFT JOIN usuario ue ON(e.cpf = ue.cpf)
ORDER BY up.primeiro_nome, up.sobrenome, ue.primeiro_nome, ue.sobrenome

SELECT *
FROM professor /*referencia usuario em cpf, departamento em departamento e cargo em cargo*/

SELECT *
FROM estudante /*referencia usuario em cpf*/

SELECT *
FROM plano /*referencia professor em mat_professor, estudante em mat_estudante e projeto em id_projeto*/

/*1.8 Liste o primeiro nome e sobrenome de todos os alunos e primeiro nome e
sobrenome do orientador, inclusive os alunos sem orientador. - OUTER JOIN*/

SELECT u.primeiro_nome, u.sobrenome, us.primeiro_nome, us.sobrenome
FROM (((estudante e JOIN usuario u ON(e.cpf = u.cpf)) LEFT JOIN plano pl ON(e.mat_estudante = pl.mat_estudante))
		LEFT JOIN professor pr ON(pr.mat_professor = pl.mat_professor)) LEFT JOIN usuario us ON(pr.cpf = us.cpf)
ORDER BY u.primeiro_nome, u.sobrenome, us.primeiro_nome, us.sobrenome

SELECT *
FROM ((estudante e JOIN usuario u ON(e.cpf = u.cpf)) LEFT JOIN plano pl ON(e.mat_estudante = pl.mat_estudante))
	
SELECT *
FROM professor /*referencia usuario em cpf e departamento em departamento*/

SELECT *
FROM plano /*referencia professor em mat_professor e estudante em mat_estudante*/

SELECT *
FROM estudante /*referencia usuario em cpf*/

/*1.7 Liste o nome da disciplina, turma e primeiro nome e sobrenome do professor, das
disciplinas que não são pré-requisito - OUTER JOIN*/

SELECT pre.cod_disc, pre.nome, t.id_turma, u.primeiro_nome, u.sobrenome
FROM (((((disciplina di RIGHT JOIN disciplina pre ON(pre.cod_disc = di.pre_req)) JOIN departamento de
		ON(pre.depto_responsavel = de.cod_depto)) JOIN turma t ON(t.cod_disc = pre.cod_disc))
		JOIN leciona le ON(le.id_turma = t.id_turma)) JOIN professor p ON(p.mat_professor = le.mat_professor))
		JOIN usuario u ON(u.cpf = p.cpf)
WHERE di.pre_req IS NULL
ORDER BY pre.cod_disc

SELECT *
FROM departamento /*referencia professor em chefe*/

SELECT *
FROM professor /*referencia usuario em cpf e departamento e departamento*/

SELECT *
FROM leciona /*referencia turma em id_turma e professor em mat_professr*/

SELECT *
FROM turma /*referencia disciplina em cod_disc*/

SELECT *
FROM disciplina /*referencia departamento em depto_responsavel*/
ORDER BY cod_disc

/*1.6 Liste o primeiro nome e sobrenome do professor e o primeiro nome e sobrenome do
seu chefe. - INNER JOIN
*/

SELECT u.primeiro_nome, u.sobrenome, us.primeiro_nome, us.sobrenome
FROM ((professor p JOIN usuario u USING(cpf)) JOIN (departamento d JOIN
	(professor ch JOIN usuario us USING(cpf)) ON(d.chefe = ch.mat_professor)) ON(p.departamento = d.cod_depto)) 
ORDER BY us.primeiro_nome, us.sobrenome, u.primeiro_nome, u.sobrenome

SELECT *
FROM professor /*referencia usuario em cpf e departamento em departamento*/

SELECT *
FROM departamento /*referencia professor em chefe*/

/*1.5 Liste o nome da disciplina e o nome do seu pré-requisito. - INNER JOIN
*/

SELECT d.nome, pre.nome
FROM disciplina d JOIN disciplina pre ON(d.pre_req = pre.cod_disc)
ORDER BY d.nome

SELECT *
FROM disciplina d JOIN disciplina pre ON(d.pre_req = pre.cod_disc)
ORDER BY d.nome

SELECT *
FROM disciplina /*referencia disciplina em pre_req*/

/*1.4 Considerando todas as turmas, liste o primeiro nome e sobrenome do professor, o
nome da disciplina que ele está lecionando, além disso liste o primeiro nome e sobrenome
de todos os alunos cursando essas turmas. - INNER JOIN*/

SELECT u.primeiro_nome, u.sobrenome, d.nome, us.primeiro_nome, us.sobrenome
FROM (((((leciona l JOIN professor p USING(mat_professor)) JOIN usuario u USING(cpf)) JOIN turma USING(id_turma))
		JOIN cursa c USING(id_turma)) JOIN disciplina d USING(cod_disc)) JOIN (estudante e JOIN usuario us USING(cpf)) USING(mat_estudante)
ORDER BY u.primeiro_nome, u.sobrenome, d.nome, us.primeiro_nome, us.sobrenome
	
SELECT *
FROM cursa /*referencia estudante em mat_estudante e turma em id_turma*/

SELECT *
FROM estudante /*referencia usuario em cpf*/ 

SELECT *
FROM leciona /*refencia turma em id_turma e professor em mat_professor*/

SELECT *
FROM professor /*referencia usuario em cpf e departamento em departamento*/

SELECT *
FROM turma /*referencia disciplina em cod_disc*/

/*1.3 Liste o primeiro nome e sobrenome do aluno e o primeiro nome e sobrenome de seu
orientador. - INNER JOIN*/

SELECT u.primeiro_nome, u.sobrenome, us.primeiro_nome, us.sobrenome
FROM (((estudante e JOIN usuario u USING(cpf)) JOIN plano p USING(mat_estudante))) JOIN 
	(professor pr JOIN usuario us USING(cpf)) USING(mat_professor)

SELECT *
FROM plano; /*referencia professor em mat_professor, e estudante em mat_estudante*/

SELECT *
FROM projeto;

SELECT *
FROM usuario;

SELECT *
FROM estudante; /*referencia usuario em cpf*/

SELECT *
FROM professor; /*referencia usuario em cpf*/

/*1.2 Liste o primeiro nome e sobrenome do estudante e o nome de cada disciplina das
turmas que ele está cursando. - INNER JOIN*/

SELECT u.primeiro_nome, u.sobrenome, d.nome
FROM (((estudante e JOIN usuario u USING(cpf)) JOIN cursa c USING(mat_estudante))
	JOIN turma t USING(id_turma)) JOIN disciplina d USING(cod_disc)
ORDER BY u.primeiro_nome

SELECT *
FROM usuario
	
SELECT *
FROM estudante /*referencia cpf usuario (nome e sobrenome)*/

SELECT *
FROM disciplina

SELECT *
FROM turma /*referencia disciplina em cod_disc*/

SELECT * /*referencia id_turma e mat_estudante*/
FROM cursa

/*1.1 Liste o nome das disciplinas que possuem turmas. - INNER JOIN*/

SELECT DISTINCT d.nome
FROM turma t JOIN disciplina d USING(cod_disc)

SELECT *
FROM turma

SELECT DISTINCT nome
FROM disciplina

/*
1 - Esquema universidade
1.1 Liste o nome das disciplinas que possuem turmas. - INNER JOIN
1.2 Liste o primeiro nome e sobrenome do estudante e o nome de cada disciplina das
turmas que ele está cursando. - INNER JOIN
1.3 Liste o primeiro nome e sobrenome do aluno e o primeiro nome e sobrenome de seu
orientador. - INNER JOIN
1.4 Considerando todas as turmas, liste o primeiro nome e sobrenome do professor, o
nome da disciplina que ele está lecionando, além disso liste o primeiro nome e sobrenome
de todos os alunos cursando essas turmas. - INNER JOIN
1.5 Liste o nome da disciplina e o nome do seu pré-requisito. - INNER JOIN
1.6 Liste o primeiro nome e sobrenome do professor e o primeiro nome e sobrenome do
seu chefe. - INNER JOIN
1.7 Liste o nome da disciplina, turma e primeiro nome e sobrenome do professor, das
disciplinas que não são pré-requisito - OUTER JOIN
1.8 Liste o primeiro nome e sobrenome de todos os alunos e primeiro nome e
sobrenome do orientador, inclusive os alunos sem orientador. - OUTER JOIN
1.9 Liste o primeiro nome e sobrenome de todos os professores e o primeiro nome e
sobrenome de seus orientandos (alunos que são orientados), inclusive os professores sem
orientandos. - OUTER JOIN
1.10 Liste o primeiro nome e sobrenome de todos alunos e o primeiro nome e sobrenome
dos professores, independente da orientação. - OUTER JOIN
1.11 Liste o primeiro nome e sobrenome dos professores que não lecionam turmas. -
OUTER JOIN
1.12 Liste o nome das disciplinas das turmas que não tem alunos cursando. - OUTER
JOIN
1.13 Refaça a consulta 1.7 da atividade 4, usando OUTER JOIN - OUTER JOIN
1.14 Refaça a consulta 1.8 da atividade 4, usando JOIN - INNER JOIN
1.15 Refaça a consulta 1.9 da atividade 4, usando OUTER JOIN - OUTER JOIN
*/
