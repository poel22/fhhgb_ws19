import sqlite3
import pprint

pp = pprint.PrettyPrinter(indent=2)

con = sqlite3.connect('./protein.db')

cur = con.cursor()

result = cur.execute("select * from proteins where pbid like ('%5%')")

for line in result.fetchall():
    pp.pprint(line)

con.commit()
con.close()

