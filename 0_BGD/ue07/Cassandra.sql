/* create keyspace */
create keyspace ue07 WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 3};
use keyspace ue07;
/* create tables */
create table students ( mat_nr text, first_name text, last_name text, date text, prg_id text, primary key(mat_nr));
create table deg_prg ( prg_id text, name text, semesters int, description text, primary key(prg_id));
create table subject ( subject_id text, deg_prg text, semester int, description text, ects int, primary key(subject_id));
create table grades ( mat_nr text, subject_id text, grade int, primary key(mat_nr, subject_id));

/* demo data */
insert into deg_prg (prg_id, name, semesters, description) values ('prg1', 'Program 1', 4, 'Lorem Ipsum');
insert into deg_prg (prg_id, name, semesters, description) values ('prg2', 'Program 2', 6, 'Lorem Ipsum');
insert into students (mat_nr, first_name, last_name, date, prg_id) values ('s1111', 'Max', 'Muster', '01.01.1970', 'prg1');
insert into students (mat_nr, first_name, last_name, date, prg_id) values ('s1112', 'Max', 'Mustermann', '01.01.1970', 'prg1');
insert into students (mat_nr, first_name, last_name, date, prg_id) values ('s1113', 'Maxi', 'Mustermann', '01.01.1970', 'prg2');insert into subject (subject_id, deg_prg, semester, description, ects) values ('sub1', 'prg1', 2, 'Lorem Ipsum sub1', 3);
insert into subject (subject_id, deg_prg, semester, description, ects) values ('sub2', 'prg1', 2, 'Lorem Ipsum sub2', 2);
insert into subject (subject_id, deg_prg, semester, description, ects) values ('sub3', 'prg2', 1, 'Lorem Ipsum sub3', 5);
insert into grades (mat_nr, subject_id, grade) values ('s1111', 'sub1', 3);
insert into grades (mat_nr, subject_id, grade) values ('s1111', 'sub2', 2);
insert into grades (mat_nr, subject_id, grade) values ('s1112', 'sub1', 4);
insert into grades (mat_nr, subject_id, grade) values ('s1113', 'sub3', 2);

/* a) */
create index on students(prg_id);
select * from students where prg_id = 'prg1';

/* b) */
create index on subject(deg_prg);
select * from subject where deg_prg = 'prg1';

/* c) */
select * from grades where mat_nr = 's1111';

/* d) */
select * from subject where subject_id = 'sub1';
