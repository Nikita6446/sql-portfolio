-- ============================================
-- SQL-портфолио: анализ данных учебной базы
-- Автор: Nikita6446
-- ============================================


-- ============================================
-- БЛОК 1: БАЗОВАЯ ВЫБОРКА И АГРЕГАЦИЯ
-- ============================================


-- 1. Количество сотрудников на каждой должности
SELECT Title, COUNT(*) AS employee_count
FROM employee
GROUP BY Title
ORDER BY employee_count DESC;


-- 2. Список клиентов с их менеджерами поддержки
SELECT 
    e.FirstName || ' ' || e.LastName AS employee_name,
    e.Title AS employee_title,
    c.FirstName || ' ' || c.LastName AS customer_name,
    c.Country AS customer_country
FROM employee e
JOIN customer c ON e.EmployeeId = c.SupportRepId
ORDER BY employee_name, customer_name;


-- 3. Клиенты из Канады и их менеджеры
SELECT 
    c.FirstName || ' ' || c.LastName AS customer_name,
    c.Country,
    e.FirstName || ' ' || e.LastName AS support_rep
FROM customer c
JOIN employee e ON c.SupportRepId = e.EmployeeId
WHERE c.Country = 'Canada'
ORDER BY customer_name;


-- ============================================
-- БЛОК 2: ОБЪЕДИНЕНИЕ ДАННЫХ И ФИЛЬТРАЦИЯ
-- ============================================


-- 4. Подзапрос: счета выше средней суммы
SELECT 
    InvoiceId,
    CustomerId,
    InvoiceDate,
    Total
FROM invoice
WHERE Total > (
    SELECT AVG(Total) 
    FROM invoice
)
ORDER BY Total DESC;


-- 5. Оконная функция: рейтинг клиентов по сумме покупок
SELECT 
    CustomerId,
    SUM(Total) AS total_spent,
    RANK() OVER (ORDER BY SUM(Total) DESC) AS rank
FROM invoice
GROUP BY CustomerId
ORDER BY rank;


-- 6. Работа с датами: количество счетов по месяцам в 2013 году
SELECT 
    STRFTIME('%Y-%m', InvoiceDate) AS month,
    COUNT(*) AS invoice_count,
    SUM(Total) AS total_amount
FROM invoice
WHERE InvoiceDate LIKE '2013%'
GROUP BY month
ORDER BY month;


-- ============================================
-- БЛОК 3: АНАЛИТИЧЕСКИЕ РАСЧЁТЫ
-- ============================================

-- 7. LEFT JOIN + CASE WHEN + HAVING: категории клиентов
SELECT 
    c.CustomerId,
    c.FirstName || ' ' || c.LastName AS customer_name,
    COUNT(i.InvoiceId) AS invoice_count,
    COALESCE(SUM(i.Total), 0) AS total_spent,
CASE 
    WHEN COALESCE(SUM(i.Total), 0) > 40 THEN 'Top Segment'
    WHEN COALESCE(SUM(i.Total), 0) > 20 THEN 'Mid Segment'
    ELSE 'Base Segment'
END AS category
FROM customer c
LEFT JOIN invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName
HAVING COUNT(i.InvoiceId) > 0
ORDER BY total_spent DESC;


-- 8. Эффективность менеджеров по продажам
SELECT 
    e.FirstName || ' ' || e.LastName AS employee_name,
    e.Title AS employee_title,
    COUNT(DISTINCT c.CustomerId) AS customer_count,
    COALESCE(SUM(i.Total), 0) AS total_revenue,
   CASE 
    WHEN COALESCE(SUM(i.Total), 0) > 800 THEN 'Высокий уровень'
    WHEN COALESCE(SUM(i.Total), 0) > 750 THEN 'Средний уровень'
    ELSE 'Низкий уровень'
END AS revenue_level
FROM employee e
LEFT JOIN customer c ON e.EmployeeId = c.SupportRepId
LEFT JOIN invoice i ON c.CustomerId = i.CustomerId
GROUP BY e.EmployeeId, e.FirstName, e.LastName, e.Title
HAVING COUNT(DISTINCT c.CustomerId) > 0
ORDER BY total_revenue DESC;


-- 9. Организационная структура: кто кому подчиняется
SELECT 
    e.FirstName || ' ' || e.LastName AS employee_name,
    e.Title AS employee_title,
    COALESCE(m.FirstName || ' ' || m.LastName, '— (высшее руководство)') AS manager_name,
    COALESCE(m.Title, '—') AS manager_title
FROM employee e
LEFT JOIN employee m ON e.ReportsTo = m.EmployeeId
ORDER BY 
    CASE WHEN e.ReportsTo IS NULL THEN 0 ELSE 1 END,
    e.Title,
    e.LastName;
