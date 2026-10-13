# SQL-портфолио

## О репозитории

Это учебное портфолио SQL-запросов и PL/SQL-блоков, демонстрирующее навыки работы с реляционными базами данных. Запросы написаны и протестированы в DBeaver на учебной базе (SQLite) и в Oracle.

## Что внутри

| Файл | СУБД | Описание |
|------|------|----------|
| `employee_analysis.sql` | SQLite | 13 SQL-запросов: от базовой агрегации до DML/DDL |
| `oracle_plsql_examples.sql` | Oracle | PL/SQL: курсор, хранимая процедура, обработка исключений |

|### `employee_analysis.sql` — 13 SQL-запросов

| № | Запрос | Навык |
|---|--------|-------|
| 1 | Количество сотрудников по должностям | `GROUP BY` + `COUNT` |
| 2 | Клиенты и их менеджеры | `JOIN` двух таблиц |
| 3 | Клиенты из Канады | `WHERE` + `JOIN` |
| 4 | Счета выше средней суммы | Подзапрос + `AVG` |
| 5 | Рейтинг клиентов по покупкам | Оконная функция + `RANK()` |
| 6 | Счета по месяцам 2013 года | Даты + `STRFTIME` |
| 7 | Категории клиентов | `LEFT JOIN` + `CASE WHEN` + `HAVING` |
| 8 | Эффективность менеджеров | 3 таблицы + `DISTINCT` |
| 9 | Иерархия сотрудников | Self-join + `COALESCE` |
| 10 | Создание тестовой таблицы и вставка данных | `CREATE TABLE` + `INSERT` |
| 11 | Обновление данных клиента | `UPDATE` |
| 12 | Удаление клиента | `DELETE` |
| 13 | Очистка тестовой таблицы | `DROP TABLE` |

### `oracle_plsql_examples.sql` — PL/SQL

| Блок | Навык |
|------|-------|
| Базовый блок | `BEGIN ... END;` |
| Курсор | `DECLARE`, `CURSOR`, `OPEN`, `FETCH`, `LOOP`, `EXIT WHEN`, `CLOSE` |
| Хранимая процедура | `CREATE OR REPLACE PROCEDURE`, параметр `IN`, `%TYPE`, `SELECT INTO` |
| Обработка исключений | `NO_DATA_FOUND`, `TOO_MANY_ROWS`, `VALUE_ERROR`, `OTHERS`, `SQLERRM` |

## Навыки

**Работа с данными (DML):**
- Вставка данных (`INSERT`)
- Обновление данных (`UPDATE`)
- Удаление данных (`DELETE`)

**Работа со структурой (DDL):**
- Создание таблиц (`CREATE TABLE`)
- Удаление таблиц (`DROP TABLE`)
- Использование ограничений (`PRIMARY KEY`, `NOT NULL`, `UNIQUE`, `DEFAULT`)

**Аналитика (SQL):**
- Написание SELECT-запросов любой сложности
- Объединение таблиц (INNER JOIN, LEFT JOIN, self-join)
- Агрегация данных (GROUP BY, COUNT, SUM, AVG)
- Фильтрация (WHERE, HAVING)
- Подзапросы
- Оконные функции (RANK, OVER)
- Работа с датами
- Условная логика (CASE WHEN)
- Работа с NULL (COALESCE)

**Процедурное программирование (PL/SQL):**
- Анонимные блоки (`BEGIN ... END;`)
- Курсоры (`CURSOR`, `OPEN`, `FETCH`, `CLOSE`)
- Хранимые процедуры (`CREATE OR REPLACE PROCEDURE`)
- Входные параметры (`IN`)
- Привязка типов (`%TYPE`)
- Обработка исключений (`EXCEPTION`, `RAISE`, `SQLERRM`)

## Инструменты

- **DBeaver** — среда для работы с базами данных
- **SQLite** — учебная база данных
- **Oracle Database 21c Express Edition** — СУБД для PL/SQL
- **Docker** — запуск Oracle в контейнере
- **GitHub** — хранение и версионирование

## Контакты

- GitHub: [Nikita6446](https://github.com/Nikita6446)
