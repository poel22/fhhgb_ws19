import sqlite3

con = sqlite3.connect('./test.db')

cur = con.cursor()

cur.execute('create table if not exists user (' +
            'id integer primary key autoincrement,' +
            'name text,' +
            'age integer'
            ')');

cur.execute("insert into user values (null, 'mustermann maximilian', 50)")

con.commit()
con.close()
