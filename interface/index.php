      <html lang="ru"><head>
          <meta charset="utf-8">
          <title>Интерфейс управления базой данных "Университет"</title>
          <link href="style.css" rel="stylesheet">
          <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
      </head>
      <body>
          <main>
              <section class="interface" id="interface">
                  <span class="interface__user" v-if="student.seen">{{student.name}}</span>
                  <span class="interface__user" v-if="admin.seen">Администратор</span>
                  <h1 class="title">Вас приветствует сервис управления реальностью - "Университет"</h1>
                  <div id="choose" class="choosen">
                      <button class="btn choosen__manage" v-on:click="onCLickManageBtn">Выбери свою роль</button>
                      <div class="choosen__cont" v-if="manage.seen">
                          <button type="button" class="btn choosen__role" v-on:click="onClickStudentBtn">Студент</button>
                          <input  class="choosen__input" type="text" name="student" v-if="manage.student" v-on:change="onChangeStud" placeholder="Введи ФИО" list="students">
                          <datalist id="students">
                              <?php
                                  $mysqli = new mysqli("localhost", "root", "", "univer");
                                  $student = $mysqli->query("select * from student");
                                  for ($i = 0; $i < $student->num_rows; $i++) {
                                      $student->data_seek($i);
                                      $cur = $student->fetch_assoc();
                                      echo "<option value=\"".$cur['name']."\">\n";
                                  }
                              ?>>
                          </datalist>
                          <button type ="button" class="btn choosen__role" v-on:click="onClickAdminBtn">Администратор</button>
                          <input class="choosen__input" type="password" name="admin" v-if="manage.admin" v-on:change="onChangeAdmin" placeholder="Пароль, пожалуйста">
                      </div>
                  </div>
                  <ul class="list-option">
                      <span class="list-option__title">{{list__option[0]}}</span>
                      <li class="list-option__el" v-on:click="onClickGroupBtn">
                          <button class="btn list-option__btn">{{list__option[1]}}</button>
                      </li>
                      <li class="list-option__el" v-on:click="onClickScheduleBtn">
                          <button class="btn list-option__btn">{{list__option[2]}}</button>
                      </li>
                      <li class="list-option__el" v-on:click="onClickDebtBtn">
                          <button class="btn list-option__btn">{{list__option[3]}}</button>
                      </li>
                      <li class="list-option__el" v-on:click="onClickPerfBtn">
                          <button class="btn list-option__btn">{{list__option[4]}}</button>
                      </li>
                      <li class="list-option__el" v-if="admin.seen">
                          <button class="btn list-option__btn" v-on:click="onClickAddBtn">Добавить</button>
                      </li>
                      <li class="list-option__el" v-if="admin.seen">
                          За кем следим?
                          <input class="list-option__input" type="text" list="students" v-on:change="onChangeStudAdmin"></input>
                          <datalist id="students">
                              <?php
                              $mysqli = new mysqli("localhost", "root", "", "univer");
                              $student = $mysqli->query("select * from student");
                              for ($i = 0; $i < $student->num_rows; $i++) {
                                  $student->data_seek($i);
                                  $cur = $student->fetch_assoc();
                                  echo "<option value=\"".$cur['name']."\">\n";
                              }
                              ?>>
                          </datalist>
                      </li>
                  </ul>
                  <div class="interface__add"  v-if="admin.add">
                      <ul class="ad-list">
                          <li class="ad-list__el" v-on:click="onClickAddStud">
                              <button class="btn ad-list__btn">Студента</button>
                          </li>
                          <li class="ad-list__el" v-on:click="onClickAddGroup">
                              <button class="btn ad-list__btn">Группу</button>
                          </li>
                          <li class="ad-list__el" v-on:click="onClickAddSubject">
                              <button class="btn ad-list__btn">Предмет</button>
                          </li>
                          <li class="ad-list__el" v-on:click="onClickAddSchedule">
                              <button class="btn ad-list__btn">Расписание</button>
                          </li>
                          <li class="ad-list__el" v-on:click="onClickAddTask">
                              <button class="btn ad-list__btn">Задания</button>
                          </li>
                          <li class="ad-list__el" v-on:click="onClickAddMark">
                              <button class="btn ad-list__btn">Оценки</button>
                          </li>
                      </ul>
                  </div>
                  <div class="interface__output output" v-if="result.seen">
                      <h2 class="output__title" v-if="result.seen__info">{{result.title}}{{result.title__add}}</h2>
                      <table class="output__data" v-if="result.seen__info">
                        <tr>
                            <th v-for="(header, index) in result.headers" :key="index">
                                {{header}}
                            </th>
                        </tr>
                        <tr v-for="(row, index) in result.data[0]" :key="index">
                            <td v-for="(cell, index) in row" :key="index">
                                {{cell}}
                            </td>
                        </tr>
                      </table>
                      <form v-if="result.seen__add" action="" method="post" v-on:submit.prevent="onSubmitAdd">
                          <label v-for="(el, index) in result.data" :key="index" class="output__label">
                              {{el.label}}
                              <input class="output__input" type="text" :name="el.name" :required="el.require"
                                     :placeholder="el.placeholder" :pattern="el.pattern">
                          </label>
                          <button type="submit">Магия</button>
                      </form>
                  </div>
                  <div class="msg" v-if="msg.seen" v-on:click="onClickMsg">
                        <span class="msg__text"> {{msg.text}} </span>
                        <span class="msg__instr">Чтобы продолжить, кликните по этому окну</span>
                  </div>

              </section>

          </main>
      </body>
      <script src="main.js"></script>


<?php
//      $mysqli = new mysqli("localhost", "root", "", "univer");
//      if ($mysqli->connect_errno) {
//          echo "Не удалось подключиться к MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
//      } else {
//          echo $mysqli->host_info;
//      }
//      $student = $mysqli->query("select * from student");
//      for ($i = 0; $i < $student->num_rows; $i++) {
//            $student->data_seek($i);
//            $cur = $student->fetch_assoc();
//            echo $cur['name']."\n";
//      }
      ?>
</html>
