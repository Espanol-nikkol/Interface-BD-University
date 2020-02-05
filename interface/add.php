<?php
    $mysqli = new mysqli("localhost", "root", "", "univer");
    $group = $_REQUEST["group"];
    $student = urldecode($_REQUEST["student"]);
    $birth = $_REQUEST["birth"];
    $adm = $_REQUEST["admission"];
    $type = $_REQUEST["type"];
    $name_new = $_REQUEST["name_new"];
    $lecturer_name = urldecode($_REQUEST["lecturer"]);
    $subject_name = urldecode($_REQUEST["subject"]);
    $classroom_name = $_REQUEST["classroom"];
    $date = $_REQUEST["date"];
    $mark = $_REQUEST["mark"];
    $task = $_REQUEST["task"];

switch ($type) {
    case "addStud":
        if ($group == "") {
            $mysqli->query("insert into student (name, birth, admission) values
                                ('$student', '$birth', '$adm')");
        } else {
            $mysqli->query("insert into student (group_id, name, birth, admission) values
                                ('$group', '$student', '$birth', '$adm')");
        }
        break;
    case "addGroup":
        $mysqli->query("insert into `group` (chair) values ('$name_new')");
        break;
    case "addSubject":
        $mysqli->query("insert into `subject` (title) values ('$name_new')");
        break;
    case "addSch":
        $lecturer_id = $mysqli->query("select id from lecturer where name = '$lecturer_name'")->fetch_all()[0][0];
        $subject_id = $mysqli->query("select id from subject where title = '$subject_name'")->fetch_all()[0][0];
        $classroom_id = $mysqli->query("select id from classroom where title = '$classroom_name'")->fetch_all()[0][0];
        $mysqli->query("insert into schedule (date, lecturer_id, subject_id, group_id, classroom_id) 
                                values('$date','$lecturer_id','$subject_id','$group','$classroom_id')");
    case "addTask":
        $subject_id = $mysqli->query("select id from subject where title = '$subject_name'")->fetch_all()[0][0];
        $mysqli->query("insert into `task` (subject_id) values ('$subject_id')");
    case "addMark":
        $student_id = $mysqli->query("select id from student where name = '$student'")->fetch_all()[0][0];
        $mysqli->query("insert into mark (student_id, task_id, mark) 
                                values('$student_id','$task','$mark')");
};
