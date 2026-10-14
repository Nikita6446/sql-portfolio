"""
Визуализация данных из SQLite через Python.
Строит график количества счетов и суммы по месяцам 2013 года.
"""

import sqlite3
import pandas as pd
import matplotlib.pyplot as plt
import os

# Путь к учебной базе DBeaver Sample Database (SQLite)
DB_PATH = os.path.expanduser(
    "~/AppData/Roaming/DBeaverData/workspace6/.metadata/sample-database-sqlite-1/Chinook.db"
)

# Подключение к базе
conn = sqlite3.connect(DB_PATH)

# SQL-запрос: количество счетов и сумма по месяцам 2013 года
query = """
SELECT 
    STRFTIME('%Y-%m', InvoiceDate) AS month,
    COUNT(*) AS invoice_count,
    SUM(Total) AS total_amount
FROM invoice
WHERE InvoiceDate LIKE '2013%'
GROUP BY month
ORDER BY month;
"""

# Читаем данные в DataFrame
df = pd.read_sql_query(query, conn)
conn.close()

# Вывод данных в консоль
print(df)

# Построение графика
fig, ax1 = plt.subplots(figsize=(12, 6))

# Столбцы — количество счетов
ax1.bar(df['month'], df['invoice_count'], color='steelblue', label='Количество счетов')
ax1.set_xlabel('Месяц')
ax1.set_ylabel('Количество счетов', color='steelblue')
ax1.tick_params(axis='y', labelcolor='steelblue')
ax1.set_xticklabels(df['month'], rotation=45)

# Вторая ось — сумма
ax2 = ax1.twinx()
ax2.plot(df['month'], df['total_amount'], color='darkorange', marker='o', 
         linewidth=2, label='Сумма (USD)')
ax2.set_ylabel('Сумма (USD)', color='darkorange')
ax2.tick_params(axis='y', labelcolor='darkorange')

# Заголовок
plt.title('Счета по месяцам 2013 года: количество и сумма')
fig.tight_layout()

# Сохранение графика
plt.savefig('invoice_by_month.png', dpi=150)
print("График сохранён: invoice_by_month.png")

# Показать график
plt.show()