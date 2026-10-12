-- ============================================
-- Oracle PL/SQL: примеры процедурного программирования
-- Автор: Nikita6446
-- ============================================
-- Демонстрирует:
--   1. Курсор — процедурный обход данных
--   2. Хранимую процедуру с параметром
--   3. Обработку исключений (NO_DATA_FOUND, TOO_MANY_ROWS,
--      VALUE_ERROR)
-- ============================================


-- ============================================
-- ПОДГОТОВКА: создание таблицы и данных
-- ============================================

CREATE TABLE employee (
    employee_id NUMBER PRIMARY KEY,
    first_name  VARCHAR2(50),
    last_name   VARCHAR2(50),
    title       VARCHAR2(100)
);

INSERT ALL
  INTO employee (employee_id, first_name, last_name, title) VALUES (1, 'Jane', 'Peacock', 'Sales Support Agent')
  INTO employee (employee_id, first_name, last_name, title) VALUES (2, 'Margaret', 'Park', 'Sales Support Agent')
  INTO employee (employee_id, first_name, last_name, title) VALUES (3, 'Steve', 'Johnson', 'Sales Support Agent')
  INTO employee (employee_id, first_name, last_name, title) VALUES (4, 'Nancy', 'Edwards', 'Sales Manager')
  INTO employee (employee_id, first_name, last_name, title) VALUES (5, 'Andrew', 'Adams', 'General Manager')
  INTO employee (employee_id, first_name, last_name, title) VALUES (6, 'Michael', 'Mitchell', 'IT Manager')
  INTO employee (employee_id, first_name, last_name, title) VALUES (7, 'Robert', 'King', 'IT Staff')
  INTO employee (employee_id, first_name, last_name, title) VALUES (8, 'Laura', 'Callahan', 'IT Staff')
SELECT * FROM dual;

COMMIT;


-- ============================================
-- 1. КУРСОР: количество сотрудников по должностям
-- ============================================
-- Процедурный аналог SQL-запроса:
--   SELECT title, COUNT(*) FROM employee GROUP BY title;
-- ============================================

DECLARE
  v_title VARCHAR2(100);
  v_count NUMBER;
  CURSOR c IS 
    SELECT title, COUNT(*) AS cnt 
    FROM employee 
    GROUP BY title
    ORDER BY cnt DESC;
BEGIN
  OPEN c;
  LOOP
    FETCH c INTO v_title, v_count;
    EXIT WHEN c%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_title || ': ' || v_count);
  END LOOP;
  CLOSE c;
END;


-- ============================================
-- 2. ХРАНИМАЯ ПРОЦЕДУРА: информация о сотруднике
-- ============================================
-- Принимает ID сотрудника, выводит его имя и должность.
-- Обрабатывает исключения:
--   NO_DATA_FOUND — сотрудник не найден
--   TOO_MANY_ROWS — найдено больше одной строки
--   VALUE_ERROR   — ID пустой (NULL)
--   OTHERS        — любые другие ошибки
-- ============================================

CREATE OR REPLACE PROCEDURE get_employee_info(p_id IN NUMBER) IS
  v_first_name employee.first_name%TYPE;
  v_last_name  employee.last_name%TYPE;
  v_title      employee.title%TYPE;
BEGIN
  -- Проверка на NULL: вызываем VALUE_ERROR вручную,
  -- чтобы обработать эту ошибку в общем блоке EXCEPTION
  IF p_id IS NULL THEN
    RAISE VALUE_ERROR;
  END IF;

  SELECT first_name, last_name, title
  INTO v_first_name, v_last_name, v_title
  FROM employee
  WHERE employee_id = p_id;

  DBMS_OUTPUT.PUT_LINE('Сотрудник: ' || v_first_name || ' ' || v_last_name);
  DBMS_OUTPUT.PUT_LINE('Должность: ' || v_title);

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Ошибка: сотрудник с ID ' || p_id || ' не найден');
  
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Ошибка: найдено более одного сотрудника с ID ' || p_id);
  
  WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('Ошибка: ID не может быть пустым (NULL)');
  
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Неизвестная ошибка: ' || SQLERRM);
END;


-- ============================================
-- 3. ПРИМЕРЫ ВЫЗОВА ПРОЦЕДУРЫ
-- ============================================

-- Сценарий 1: успех
BEGIN
  get_employee_info(1);
END;

-- Сценарий 2: сотрудник не найден
BEGIN
  get_employee_info(999);
END;

-- Сценарий 3: NULL
BEGIN
  get_employee_info(NULL);
END;