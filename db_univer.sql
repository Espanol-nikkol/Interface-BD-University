DROP TABLE IF EXISTS mark;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS curriculum;
DROP TABLE IF EXISTS task CASCADE;
DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS schedule CASCADE;
DROP TABLE IF EXISTS `group` CASCADE;
DROP TABLE IF EXISTS subject CASCADE;
DROP TABLE IF EXISTS lecturer CASCADE;
DROP TABLE IF EXISTS classroom CASCADE;
DROP TRIGGER IF EXISTS onInsStud;
    
CREATE TABLE `group` (
    id serial PRIMARY KEY,
    chair VARCHAR(100) NOT NULL
);

CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    group_id bigint unsigned,
    name VARCHAR(100) NOT NULL,
    birth DATE NOT NULL,
    admission DATE NOT NULL,
    FOREIGN KEY (group_id) REFERENCES `group`(id) ON DELETE CASCADE
);

CREATE TABLE subject (
    id serial  PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

    CREATE TABLE curriculum (
        subject_id bigint unsigned,
        group_id bigint unsigned,
        FOREIGN KEY (group_id) REFERENCES `group`(id) ON DELETE CASCADE,
        FOREIGN KEY (subject_id) REFERENCES subject(id) ON DELETE CASCADE
    );

CREATE TABLE lecturer (
    id serial PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE classroom (
    id SERIAL PRIMARY KEY,
    title VARCHAR(10) UNIQUE NOT NULL
);

CREATE TABLE schedule (
    id SERIAL PRIMARY KEY,
    `date` TIMESTAMP NOT NULL,
    lecturer_id bigint unsigned,
    subject_id bigint unsigned,
    group_id bigint unsigned,
    classroom_id bigint unsigned,
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subject(id) ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES `group`(id) ON DELETE CASCADE,
    FOREIGN KEY (classroom_id) REFERENCES classroom(id) ON DELETE CASCADE
);

CREATE TABLE attendance (
    student_id bigint unsigned,
    schedule_id bigint unsigned,
    absent BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (schedule_id) REFERENCES schedule(id) ON DELETE CASCADE
);

CREATE TABLE task (
    id serial PRIMARY KEY,
    subject_id bigint unsigned,
    FOREIGN KEY (subject_id) REFERENCES subject(id) ON DELETE CASCADE
);

CREATE TABLE mark (
    id SERIAL PRIMARY KEY,
    student_id bigint unsigned,
    task_id bigint unsigned,
    mark SMALLINT DEFAULT 0,
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (task_id) REFERENCES task(id) ON DELETE CASCADE
);

DELIMITER --
CREATE TRIGGER onInsStud BEFORE INSERT
	ON student FOR EACH ROW 
	BEGIN
		IF new.group_id IS NULL THEN
			INSERT INTO `group` (id, chair) VALUE ((SELECT max(group_id) FROM student)+1,'ШЦЭ');
			SET new.group_id = (SELECT MAX(id) FROM `group`);
		END IF;
	END;
--
DELIMITER ;

INSERT INTO `group` (chair) VALUES ('ШЦЭ');
INSERT INTO `group` (chair) VALUES ('ШЦЭ');
INSERT INTO `group` (chair) VALUES ('ШЦЭ');

INSERT INTO student (group_id, name, birth, admission) VALUES (1, 'Тыщенко Андрей Геннадьевич', '1997-07-09', '2019-09-01');
INSERT INTO student (group_id, name, birth, admission) VALUES (1, 'Поликутин Евгений Юрьевич', '1998-01-16', '2019-09-01');
INSERT INTO student (group_id, name, birth, admission) VALUES (2, 'Белоусова Кристина Сергеевна', '1996-03-05', '2019-09-01');
INSERT INTO student (group_id, name, birth, admission) VALUES (2, 'Гоменюк Александр Александрович', '1997-07-20', '2019-09-01');
INSERT INTO student (group_id, name, birth, admission) VALUES (3, 'Донской Илья Андреевич', '1997-07-21', '2019-09-01');
INSERT INTO student (group_id, name, birth, admission) VALUES (3, 'Васильченко Полина Александровна', '1997-04-18', '2020-09-01');

INSERT INTO subject (title) VALUES ('English for Academic Purposes');
INSERT INTO subject (title) VALUES ('Машинное обучение');
INSERT INTO subject (title) VALUES ('Системы управления базами данных');
INSERT INTO subject (title) VALUES ('Языки, алгоритмы и методы программирования');
INSERT INTO subject (title) VALUES ('Математические методы анализа данных');
INSERT INTO subject (title) VALUES ('Научно-исследовательский семинар');
INSERT INTO subject (title) VALUES ('Ознакомительная практика');
INSERT INTO subject (title) VALUES ('Правовые и этические проблемы использования технологий искусственного интеллекта');
INSERT INTO subject (title) VALUES ('Правовые основы кибербезопасности');
INSERT INTO subject (title) VALUES ('СУБД');
INSERT INTO subject (title) VALUES ('VR');

INSERT INTO curriculum (subject_id, group_id) VALUES (1, 1);
INSERT INTO curriculum (subject_id, group_id) VALUES (2, 1);
INSERT INTO curriculum (subject_id, group_id) VALUES (3, 1);
INSERT INTO curriculum (subject_id, group_id) VALUES (4, 1);
INSERT INTO curriculum (subject_id, group_id) VALUES (5, 1);
INSERT INTO curriculum (subject_id, group_id) VALUES (6, 1);
INSERT INTO curriculum (subject_id, group_id) VALUES (7, 1);
INSERT INTO curriculum (subject_id, group_id) VALUES (8, 1);
INSERT INTO curriculum (subject_id, group_id) VALUES (1, 2);
INSERT INTO curriculum (subject_id, group_id) VALUES (2, 2);
INSERT INTO curriculum (subject_id, group_id) VALUES (3, 2);
INSERT INTO curriculum (subject_id, group_id) VALUES (4, 2);
INSERT INTO curriculum (subject_id, group_id) VALUES (5, 2);
INSERT INTO curriculum (subject_id, group_id) VALUES (6, 2);
INSERT INTO curriculum (subject_id, group_id) VALUES (7, 2);
INSERT INTO curriculum (subject_id, group_id) VALUES (8, 2);
INSERT INTO curriculum (subject_id, group_id) VALUES (1, 3);
INSERT INTO curriculum (subject_id, group_id) VALUES (2, 3);
INSERT INTO curriculum (subject_id, group_id) VALUES (3, 3);
INSERT INTO curriculum (subject_id, group_id) VALUES (4, 3);
INSERT INTO curriculum (subject_id, group_id) VALUES (5, 3);
INSERT INTO curriculum (subject_id, group_id) VALUES (6, 3);
INSERT INTO curriculum (subject_id, group_id) VALUES (7, 3);
INSERT INTO curriculum (subject_id, group_id) VALUES (9, 3);
INSERT INTO curriculum (subject_id, group_id) VALUES (10, 1);
INSERT INTO curriculum (subject_id, group_id) VALUES (11, 1);

INSERT INTO classroom (title) VALUES ('G464');
INSERT INTO classroom (title) VALUES ('G467');
INSERT INTO classroom (title) VALUES ('G468');
INSERT INTO classroom (title) VALUES ('G424');
INSERT INTO classroom (title) VALUES ('G407');
INSERT INTO classroom (title) VALUES ('G470');

INSERT INTO lecturer (name) VALUES ('Кленин Александр Сергеевич');
INSERT INTO lecturer (name) VALUES ('Олейников Игорь Сергеевич');
INSERT INTO lecturer (name) VALUES ('Другова Екатерина Анатольевна');
INSERT INTO lecturer (name) VALUES ('Ринчино Андрей Львович');
INSERT INTO lecturer (name) VALUES ('Ерёменко Александр Сергеевич');
INSERT INTO lecturer (name) VALUES ('Ян Т. В.');

INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-20 11:50', 3, 1, 1, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-20 11:50', 3, 1, 2, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-20 11:50', 3, 1, 3, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-20 13:30', 3, 1, 1, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-20 13:30', 3, 1, 2, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-20 13:30', 3, 1, 3, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-20 15:10', 4, 5, 1, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-20 15:10', 4, 5, 2, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-20 15:10', 4, 5, 3, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-20 16:50', 4, 5, 1, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-20 16:50', 4, 5, 2, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-20 16:50', 4, 5, 3, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-21 13:30', 1, 4, 1, 5); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-21 13:30', 1, 4, 2, 5); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-21 13:30', 1, 4, 3, 5); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-21 15:10', 5, 6, 1, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-21 15:10', 5, 6, 2, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-21 15:10', 5, 6, 3, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-23 10:10', 3, 1, 1, 2); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-23 11:50', 3, 1, 1, 2); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-23 11:50', 1, 4, 2, 1); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-23 11:50', 6, 4, 3, 3); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-23 13:30', 1, 4, 1, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-23 13:30', 1, 4, 2, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-23 13:30', 1, 4, 3, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-23 15:10', 2, 3, 1, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-23 15:10', 2, 3, 2, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-23 15:10', 2, 3, 3, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-23 16:50', 2, 3, 1, 2); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-23 16:50', 2, 3, 2, 2); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-23 16:50', 2, 3, 3, 3); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-27 11:50', 3, 1, 3, 2); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-27 13:30', 3, 1, 3, 2); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-27 13:50', 4, 5, 2, 3); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-27 15:10', 4, 5, 3, 3); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-27 15:10', 3, 1, 2, 2); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-27 16:50', 4, 5, 1, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-27 16:50', 4, 5, 2, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-27 16:50', 4, 5, 3, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-27 18:30', 4, 5, 1, 3); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-28 10:10', 1, 4, 1, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-28 10:10', 1, 4, 2, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-28 10:10', 1, 4, 3, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-28 11:50', 1, 4, 1, 3); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-28 11:50', 1, 4, 2, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-28 11:50', 1, 4, 3, 3); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-28 13:30', 1, 4, 1, 5); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-28 13:30', 1, 4, 2, 5); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-28 13:30', 1, 4, 3, 5); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-28 15:10', 5, 6, 1, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-28 15:10', 5, 6, 2, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-28 15:10', 5, 6, 3, 6); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-30 11:50', 3, 1, 1, 2); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-30 15:10', 2, 3, 1, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-30 15:10', 2, 3, 2, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-30 15:10', 2, 3, 3, 4); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-30 16:50', 2, 3, 1, 2); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-30 16:50', 2, 3, 2, 2); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-30 16:50', 2, 3, 3, 3); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-30 16:50', 2, 10, 1, 3); 
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-30 16:50', 2, 10, 1, 3);
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-30 16:50', 2, 10, 1, 3);
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-30 16:50', 2, 10, 1, 3);
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-30 16:50', 2, 10, 1, 3);
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-30 16:50', 2, 10, 1, 3);
INSERT INTO schedule (`date`, lecturer_id, subject_id, group_id, classroom_id) VALUES ('2019-09-30 16:50', 2, 10, 1, 3);

INSERT INTO attendance (student_id, schedule_id) VALUES (1, 1);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 4);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 7);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 10);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 13);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 16);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 19);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 20);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 23);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 26);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 29);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 37);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 40);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 41);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 44);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 47);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 50);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 53);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 54);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 57);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 1);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 4);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 7);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 10);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 13);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 16);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 19);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 20);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 23);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 26);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 29);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 37);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 40);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (2, 41, TRUE);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 44);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (2, 47, TRUE);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 50);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 53);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (2, 54, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (2, 57, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (3, 5, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (3, 8, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (3, 17, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (3, 21, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (3, 30, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (3, 38, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (3, 42, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (3, 45, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (3, 48, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (3, 51, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (3, 55, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (3, 58, TRUE);
INSERT INTO attendance (student_id, schedule_id) VALUES (4, 5);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (4, 8, TRUE);
INSERT INTO attendance (student_id, schedule_id) VALUES (4, 11);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (4, 14, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (4, 17, TRUE);
INSERT INTO attendance (student_id, schedule_id) VALUES (4, 21);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (4, 24, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (4, 27, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (4, 30, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (4, 34, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (4, 36, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (4, 38, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (4, 42, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (4, 45, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (4, 48, TRUE);
INSERT INTO attendance (student_id, schedule_id) VALUES (4, 51);
INSERT INTO attendance (student_id, schedule_id) VALUES (4, 55);
INSERT INTO attendance (student_id, schedule_id) VALUES (4, 58);
INSERT INTO attendance (student_id, schedule_id) VALUES (5, 18);
INSERT INTO attendance (student_id, schedule_id) VALUES (5, 22);
INSERT INTO attendance (student_id, schedule_id) VALUES (5, 39);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (6, 43, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (6, 46, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (6, 59, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (1, 60, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (1, 61, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (1, 62, TRUE);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 63);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 64);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 65);
INSERT INTO attendance (student_id, schedule_id) VALUES (1, 66);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (2, 60, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (2, 61, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (2, 62, TRUE);
INSERT INTO attendance (student_id, schedule_id, absent) VALUES (2, 63, TRUE);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 64);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 65);
INSERT INTO attendance (student_id, schedule_id) VALUES (2, 66);



INSERT INTO task (subject_id) VALUES (1);
INSERT INTO task (subject_id) VALUES (1);
INSERT INTO task (subject_id) VALUES (1);
INSERT INTO task (subject_id) VALUES (1);
INSERT INTO task (subject_id) VALUES (3);
INSERT INTO task (subject_id) VALUES (3);
INSERT INTO task (subject_id) VALUES (3);
INSERT INTO task (subject_id) VALUES (4);
INSERT INTO task (subject_id) VALUES (4);
INSERT INTO task (subject_id) VALUES (4);
INSERT INTO task (subject_id) VALUES (4);
INSERT INTO task (subject_id) VALUES (4);
INSERT INTO task (subject_id) VALUES (5);
INSERT INTO task (subject_id) VALUES (5);


INSERT INTO mark (student_id, task_id, mark) VALUES (1, 1, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (1, 2, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (1, 3, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (1, 4, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (1, 5, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (1, 6, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (1, 7, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (1, 8, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (1, 9, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (1, 10, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (1, 11, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (1, 12, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (1, 13, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (1, 14, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (2, 1, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (2, 2, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (2, 3, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (2, 4, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (2, 5, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (2, 6, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (2, 7, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (2, 8, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (2, 9, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (2, 10, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (2, 11, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (2, 12, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (2, 13, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (2, 14, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (3, 8, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (3, 9, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (3, 10, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (3, 11, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (3, 12, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (4, 4, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (4, 5, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (4, 6, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (4, 7, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (4, 8, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (4, 9, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (4, 10, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (4, 11, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (4, 12, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (4, 13, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (4, 14, 5);
INSERT INTO mark (student_id, task_id, mark) VALUES (5, 1, 3);
INSERT INTO mark (student_id, task_id, mark) VALUES (5, 2, 3);
INSERT INTO mark (student_id, task_id, mark) VALUES (5, 3, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (5, 4, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (5, 5, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (5, 6, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (5, 7, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (5, 8, 4);
INSERT INTO mark (student_id, task_id, mark) VALUES (5, 9, 5);

