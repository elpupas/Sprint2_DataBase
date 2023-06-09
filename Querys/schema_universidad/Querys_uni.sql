select apellido1, apellido2, nombre from persona where tipo = 'alumno' order by apellido1 asc, apellido2 asc, nombre asc;
select nombre, apellido1, apellideo2, telefono from persona where tipo = 'alumno' and telefono is null;
select * from persona where year(fecha_nacimiento) = 1999 and tipo = 'alumno' and tipo;
select * from persona where tipo = 'profesor' and nif like '%k' and telefono is null;
select asignatura.nombre from asignatura where cuatrimestre = 1 and  curso = 3 and id_grado = 7;
select persona.apellido1 as 1er_ape, persona.apellido2 as 2do_ape, persona.nombre as nom, departamento.nombre as departamento from persona inner join profesor on persona.id = profesor.id_profesor inner join departamento on profesor.id_departamento = departamento.id where tipo = 'profesor' order by persona.apellido1 asc, persona.apellido2 asc, persona.nombre asc;
select asignatura.nombre, curso_escolar.anyo_fin, curso_escolar.anyo_fin from asignatura  inner join alumno_se_matricula_asignatura on asignatura.id = alumno_se_matricula_asignatura.id_asignatura inner join persona on persona.id = alumno_se_matricula_asignatura.id_alumno inner join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id where  persona.nif ='26902806M' ;
select * from departamento inner join profesor on  profesor.id_departamento = departamento.id inner join asignatura on  asignatura.id_profesor = profesor.id_profesor inner join grado on grado.id = asignatura.id_grado;
select * from  curso_escolar inner join alumno_se_matricula_asignatura on curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar inner join asignatura on alumno_se_matricula_asignatura.id_alumno = asignatura.id inner join persona on persona.id =alumno_se_matricula_asignatura.id_alumno where curso_escolar.anyo_inicio = 2018 and curso_escolar.anyo_fin = 2019;
select departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre, profesor.id_profesor from profesor right join departamento on profesor.id_departamento = departamento.id left join persona on persona.id = profesor.id_profesor order by departamento.nombre asc;
select  persona.apellido1, persona.apellido2, persona.nombre from persona left join profesor on profesor.id_profesor = persona.id left join departamento on departamento.id = profesor.id_departamento where departamento.id is null;
select departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre, profesor.id_profesor from profesor right join departamento on profesor.id_departamento = departamento.id left join persona on persona.id = profesor.id_profesor where profesor.id_profesor is null;
select  persona.nombre, persona.apellido1, persona.apellido2 from asignatura right join profesor on profesor.id_profesor = asignatura.id_profesor inner join persona on persona.id = profesor.id_profesor where asignatura.id_profesor is null ;
select asignatura.nombre from profesor right join asignatura on profesor.id_profesor = asignatura.id_profesor where asignatura.id_profesor is null;

select count(*) as total from persona where tipo = 'alumno';
select count(*) as total from persona where tipo = 'alumno' and year(persona.fecha_nacimiento )= 1999; 
select departamento.nombre, count(profesor.id_departamento) from departamento inner join profesor on profesor.id_departamento = departamento.id group by departamento.id order by count(profesor.id_departamento) desc;
select departamento.nombre, count(profesor.id_departamento) from departamento left join profesor on profesor.id_departamento = departamento.id group by departamento.id order by count(profesor.id_departamento) desc;
select grado.nombre, count(asignatura.id) as count_asig from grado left join asignatura on grado.id = asignatura.id_grado group by grado.id order by count(asignatura.id) desc;
select grado.nombre, count(asignatura.id) as count_asig from grado left join asignatura on grado.id = asignatura.id_grado group by grado.id having count(asignatura.id) > 40  ;
select grado.nombre, asignatura.tipo, count(asignatura.creditos) from grado inner join asignatura on grado.id = asignatura.id_grado group by asignatura.tipo;
select curso_escolar.anyo_inicio, count(alumno_se_matricula_asignatura.id_alumno) from curso_escolar inner join alumno_se_matricula_asignatura on curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar inner join asignatura on alumno_se_matricula_asignatura.id_asignatura = asignatura.id group by asignatura.id;
select profesor.id_profesor, persona.nombre, persona.apellido1, persona.apellido2, count(asignatura.id) as count from persona left join profesor on profesor.id_profesor = persona.id left join asignatura on asignatura.id_profesor = profesor.id_profesor group by profesor.id_profesor order by count(asignatura.id) asc ;
select * from persona inner join alumno_se_matricula_asignatura on persona.id = alumno_se_matricula_asignatura.id_alumno inner join asignatura on asignatura.id = alumno_se_matricula_asignatura.id_asignatura order by persona.fecha_nacimiento desc limit 1;
select concat(persona.nombre, " " , persona.apellido1, " ", persona.apellido2) as Profesores from persona inner join profesor on profesor.id_profesor = persona.id left join departamento on departamento.id = profesor.id_departamento left join asignatura on asignatura.id_profesor = profesor.id_profesor where asignatura.id_profesor is null ;




