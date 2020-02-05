const INTERFACE_STUDENT = ["Твои возможности", "Моя группа", "Что по парам?", "Хвосты", "На кого ровняться"]
const INTERFACE_ADMIN = ["Что прикажете, повелитель?", "Подопытная группа", "Расписание работы не меня", "Список косяков", "Отличники"]


let activateInfo = function (add_title) {
    interface.result.seen = true;
    interface.result.seen__info = true;
    interface.result.seen__add = false;
    interface.result.title__add = add_title
}

let activateAdd = function () {
    interface.result.seen = true;
    interface.result.seen__info = false;
    interface.result.seen__add = true;
}
let setData = function(...arg) {
    interface.result.data = arg
}

let setHeaders = function(title,...arg) {
    interface.result.title = title
    interface.result.headers = arg
}

let getData = function(arg) {
    res = ""
    for (let i=0; i < arg.length; i++) {
        res+=arg[i][0]+"="+
            encodeURIComponent(arg[i][1].split(" ").join("+"));
        ( i != arg.length-1) ? res += "&" : ""
    }
    return res
}

let getAddress = function(url,arg) {
    return url + "?" + getData(arg)
}

let getResQuery = function (url, data) {
    let req = new XMLHttpRequest()
    let res = ""
    req.open("GET", getAddress(url, data), false)
    req.onload = function () {
        res = JSON.parse(req.responseText)
    }
    req.send();
    return res
}

let sendAdd = function (data) {
    let req = new XMLHttpRequest()
    req.open("post", "add.php", true)
    req.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    req.send(getData(data));
}

let interface = new Vue({
    el: "#interface",
    data: {
        msg: {
            seen: false,
            text: ""
        },
        admin: {
            seen: false,
            add: false
        },
        student: {
            seen: false,
            name: "",
            group: ""
        },
        manage: {
            seen: false,
            student: false,
            admin: false
        },
        result: {
            title: "",
            title__add: "",
            type: "",
            seen: false,
            seen__info: false,
            seen__add: false,
            headers: [],
            data: [{
                label: "",
                name: "",
            }]
        },
        list__option: INTERFACE_STUDENT
    },
    methods: {
        onClickMsg: function () {
            this.msg.seen = false;
        },
        onCLickManageBtn: function () {
            if (this.manage.seen){
                this.manage.seen = false;
            } else {
                this.manage.seen = true;
            }
            this.admin.add = false;
        },
        onClickStudentBtn: function () {
            this.manage.student = true;
            this.manage.admin = false;
        },
        onClickAdminBtn: function () {
            this.manage.admin = true;
            this.manage.student = false;
        },
        onChangeStud: function (evt) {
            this.student.name = evt.target.value;
            this.student.group = String(getResQuery("seen.php",
                [["student", interface.student.name],
                        ["type", "seenGroup"]]
            ))
            this.list__option = INTERFACE_STUDENT;
            this.student.seen = true;
            this.admin.seen = false;
            this.manage.seen = false;
            this.manage.student = false;
            this.admin.add = false
        },
        onChangeAdmin: function (evt) {
            let cur_pass = evt.target.value;
            let true_pass = "123456";
            if (cur_pass === true_pass) {
                this.admin.seen = true;
                this.student.seen = false;
                this.manage.seen = false;
                this.manage.admin = false;
                this.list__option = INTERFACE_ADMIN;
                this.result.seen = false
                this.student.name = ""
                this.student.group = ""
            }
        },
        onClickAddBtn: function () {
            this.admin.add = true;
            this.result.seen = false
        },
        onClickGroupBtn: function () {
            if (this.student.name === "") {
                this.msg.seen = true;
                this.msg.text = "Так чью группу выводить? Сначала выбери личность студента"
            } else {
                activateInfo(this.student.group)
                if (!this.admin.seen) {
                    setHeaders("Твоя группа за номером ", 'ФИО', 'Дата рождения', 'Поступление')
                } else {
                    setHeaders("Группа подопытных №", 'ФИО', 'Дата рождения', 'Поступление')
                }
                setData(getResQuery("seen.php",
                    [["group", this.student.group],
                        ['type', 'seenGroupList']]))
            }
        },
        onClickScheduleBtn: function () {
            if (this.student.name === "") {
                this.msg.seen = true;
                this.msg.text = "Вселенная пар бесконечна. Сначала выбери личность студента"
            } else {
                activateInfo("")

                setData(getResQuery("seen.php",
                    [["group", interface.student.group],
                        ['type', 'seenSchedule']]))
                if (!this.admin.seen) {
                    setHeaders("Бесконечная вселенная твоих пар", 'Дата', 'Преподаватель', "Предмет", 'Аудитория')
                } else {
                    setHeaders("Бесконечная расширяющаяся вселенная пар", 'Дата', 'Преподаватель', "Предмет", 'Аудитория')
                }
                activateInfo("")
            }
        },
        onClickDebtBtn: function () {
            if (this.student.name === "") {
                this.msg.seen = true;
                this.msg.text = "Здесь слишком много должников. Сначала выбери личность студента"
            } else {
                activateInfo("")
                setData(getResQuery("seen.php",
                    [["student", interface.student.name],
                        ["type", "seenDebt"]]))
                if (this.result.data[0].length === 0) {
                    setHeaders("Однако, хвостов всё ещё нет. Хорошо идёшь!")
                } else {
                    setHeaders("Глубина грехопадения", "Номер задания", "Предмет")
                }
            }
        },
        onClickPerfBtn: function () {
            activateInfo("")
            setData(getResQuery("seen.php", [["type", "seenPerfect"]]));
            if (!this.admin.seen) {
                setHeaders("Шагай вверх за ними", "Кто он", "Процент успешности", "Откуда он")
            } else {
                setHeaders("Пастыри толпы", "Кто он", "Процент успешности", "Откуда он")
            }
            activateInfo("")
        },
        onChangeStudAdmin: function (evt) {
            this.student.name = evt.target.value;
            this.student.group = String(getResQuery("seen.php",
                [["student", interface.student.name],
                        ["type", "seenGroup"]]
            ))
        },
        onClickAddStud: function () {
            activateAdd()
            this.result.type = "addStud"
            setData({
                    label: "ФИО нового подопытного",
                    name: "student", require: true, placeholder: "Без сокращений, пожалуйста"
                },
                {
                    label: "Куда его распределить?",
                    name: "group", require: false, placeholder: "Если не указать, создастся новая группа"
                },
                {
                    label: "Дата рождения",
                    name: "birth", require: true, placeholder: "ГГГГ-ММ-ДД",
                    pattern: "[0-9]{4}-[0-9]{2}-[0-9]{2}"
                },
                {
                    label: "Дата поступления",
                    name: "admission", require: true, placeholder: "ГГГГ-ММ-ДД",
                    pattern: "[0-9]{4}-[0-9]{2}-[0-9]{2}"
                })
        },
        onSubmitAdd: function (evt) {
            let form = evt.target
            let data = [["type", this.result.type]]
            for (let i = 0; i < form.length - 1; i++) {
                data.push([form[i].name, form[i].value])
            }
            sendAdd(data)
            this.result.seen = false
        },
        onClickAddGroup: function () {
            activateAdd()
            this.result.type = "addGroup"
            setData({
                    label: "Новая группа будет иметь № " + getResQuery("nextGroup.php", []),
                    name: "name_new", require: true, placeholder: "Имя группы"
                },
            )
        },
        onClickAddSubject: function () {
            activateAdd()
            this.result.type = "addSubject"
            setData({
                    label: "И как это будет называется?",
                    name: "name_new", require: true, placeholder: "Название предмета"
                },
            )
        },
        onClickAddSchedule: function () {
            activateAdd()
            this.result.type = "addSch"
            setData({
                    label: "День и время встречи",
                    name: "date", require: true, placeholder: "ГГГГ-ММ-ДД ЧЧ-ММ-СС",
                    pattern: "[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}-[0-9]{2}-[0-9]{2}"
                },
                {
                    label: "Объект встречи",
                    name: "lecturer", require: false, placeholder: "Полное ФИО преподавателя"
                },
                {
                    label: "Предмет встречи",
                    name: "subject", require: true, placeholder: "Название предмета"
                },
                {
                    label: "Кто должен явиться",
                    name: "group", require: true, placeholder: "Номер группы"
                },
                {
                    label: "Место встречи",
                    name: "classroom", require: true, placeholder: "Аудитория"
                })
        },
        onClickAddTask: function () {
            activateAdd()
            this.result.type = "addTask"
            setData({
                    label: "Новая задание будет иметь № " + getResQuery("nextTask.php", []),
                    name: "subject", require: true, placeholder: "Название предмета"
                },
            )
        },
        onClickAddMark: function () {
            activateAdd()
            this.result.type = "addMark"
            setData({
                    label: "Кому ставим?",
                    name: "student", require: true, placeholder: "ФИО провинившегося полностью"
                },
                {
                    label: "За что ставим?",
                    name: "task", require: false, placeholder: "Номер задания"
                },
                {
                    label: "Что ставим?",
                    name: "mark", require: true, placeholder: "Наконец, оценка",
                    pattern: "[2-5]"
                })
        }
    }
})