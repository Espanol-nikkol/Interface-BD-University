<?php
    $mysqli = new mysqli("localhost", "root", "", "univer");
    $group = $_REQUEST["group"];
    $student = urldecode($_REQUEST["student"]);
    $type = $_REQUEST["type"];
    switch ($type) {
        case "seenGroup":
            echo $mysqli->query("select group_id 
                                                    from student 
                                                    where name = '$student'")->fetch_all()[0][0];
            break;
        case "seenGroupList":
            $res = $mysqli->query("select name, birth, admission 
                                            from student 
                                            where group_id ='$group'");
            echo json_encode(($res->fetch_all()));
            break;
        case "seenSchedule":
            $res = $mysqli->query("select date, lecturer.name, subject.title, classroom.title
                                            from schedule 
                                                join lecturer on lecturer_id = lecturer.id
                                                join subject on subject_id = subject.id
                                                join classroom on classroom_id = classroom.id
                                            where group_id = '$group'
                                            order by date");
            echo json_encode(($res->fetch_all()));
            break;
        case "seenDebt":
            $res = $mysqli->query("select task.id, title 
                                            from task
                                                join subject on subject.id = task.subject_id
                                            where task.id not in (select task_id
                                                                        from mark
                                                                    where student_id = '$student')");
            echo json_encode(($res->fetch_all()));
            break;
        case "seenPerfect":
            echo json_encode($mysqli->query("select temp1.name, temp1.perfect, student.group_id
                                                        from student
                                                            join (
                                                                select student.name, round(sum(mark)/(count(mark)*5)*100) as perfect
                                                                    from student
                                                                        join mark on student.id = mark.student_id
                                                                        join task on task.id = mark.task_id
                                                                    where student.id not in (
                                                                        select distinct student.id
                                                                            from student
                                                                                join mark on student.id = student_id
                                                                                join task on mark.task_id = task.id
                                                                            where mark like 3) 
                                                                        and student.id not in (
                                                                            select student.id
                                                                                from student
                                                                                    join (
                                                                                        select student_id, count(task_id) as person_task
                                                                                            from mark
                                                                                            group by student_id) as temp on student.id = temp.student_id
                                                                                    join task_on_group on task_on_group.group_id = student.group_id
                                                                                where temp.person_task != task_on_group.count_task)
                                                                    group by student.name
                                                                    having perfect >= 75) as temp1 on student.name = temp1.name
                                                        order by perfect desc")->fetch_all());
            break;
    }
