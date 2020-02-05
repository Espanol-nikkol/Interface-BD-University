# Interface-BD-University
Данный проект является реализацией интерфейса для работы с MySQL БД "Университет".  
База данных составлена для студентов одного курса и одного направления, но разных групп.  
В интерфейсе реализован доступ для студентов и администраторов.  

## Возможности интерфейса
Студент может:
- Узнать состав своей группы,
- Ознакомиться с расписанием пар,
- Вспомнить, какие у него долги,
- Полюбоваться на лучших из лучших.

Во власти администратора:
- Следить за определённым студентом, 
> также можно увидеть его группу, расписание, долги
- Добавлять:
  - Студентов 
  > если добавить студента и не присвоить ему группу, автоматически создастся новая группа для него
  - Группы,
  - Предметы,
  - Занятия,
  - Задания и оценки по ним.
  
При работе в интерфейсе в первую очередь требуется идентификация (попробуйте воспользоваться функциями интерфейса без этого). Необходимо выбрать либо одного из студентов, либо ввести пароль администратора (123456).
  ***
## Требования к ПО
Интерфейс разработан при помощи системы Denver 3, неофициальной сборки. Инструкцию по запуску читайте в файле install.txt

***

# Interface-BD-University
This project is an implementation of the interface for working with MySQL database "University".
The interface provides access for students and administrators.

## Interface features
A student may:
- Find out a list of your group,
- Read the schedule of couples,
- Remember what debts he has,
- Admire the best of the best.

In the power of the administrator:
- Keep track of a particular student (you can also see his group, schedule, debts),
- Add:
  - students
  > if you add a student and do not assign a group to him, a new group will be automatically created for him
  - Groups
  - Items
  - Classes,
  - Tasks and grades on them.
  
When working in an interface, identification is primarily required (try using the interface functions without this). You must either select one of the students or enter the administrator password (123456).
***
## Software Requirements
The interface is designed using Denver 3, an unofficial build. Read the startup instructions in the install.txt file
