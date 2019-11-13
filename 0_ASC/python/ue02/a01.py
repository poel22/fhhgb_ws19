import os
import urllib.request
import random
import gzip
import re
import pprint
import sqlite3

pp = pprint.PrettyPrinter(indent=2)

filePath = "./ftpSourceView.txt";

fileContent = open(filePath).readlines();

sourceUrl = fileContent[0].split()[1]
print("URL: " + sourceUrl)

unzippedFiles = []


def get_data(nr_files):
    pp.pprint(">>>>> STARTING DOWNLOAD <<<<<")
    toReturn = []
    dead_files = 0
    for i in range(nr_files):
        data = {}
        fullUrl = sourceUrl + fileContent[2:][random.randint(0, len(fileContent) - 2)].split('"')[1]
        try:
            content = gzip.GzipFile(fileobj=urllib.request.urlopen(fullUrl)).readlines()
            matched_header = re.search(r"HEADER\s*([/\w\s-]*)\d{2}-\w{3}-\d{2}\s*(\d*\w*)", content[0].decode())
            data["header"] = matched_header.group(1).strip()
            data["pdbid"] = matched_header.group(2)
            data["X"] = 0
            data["Y"] = 0
            data["Z"] = 0
            data["title"] = []
            for line_src in content[1:]:
                line = line_src.decode()
                match = re.match(r"TITLE\s\d?\s?(.*)", line)
                if match != None:
                    data["title"].append(match.group(1).strip())
                elif line.startswith("ATOM"):
                    split = line.split();
                    data["X"] += float(split[6])
                    data["Y"] += float(split[7])
                    data["Z"] += float(split[8])
                else:
                    match = re.match(r".*CHAIN:\s(.*);", line)
                    if match != None:
                        data["chain"] = match.group(1)
            data["title"] = " ".join(data["title"])
            pp.pprint(str(((i + 1) / nr_files) * 100) + "% completed")
            toReturn.append(data)
        except:
            pp.pprint("got a faulty file, continuing ...")
            dead_files += 1
    pp.pprint(">>>>> DONE <<<<<")
    pp.pprint("!! Encountered " + str(dead_files) + " files.")
    return toReturn

def insert_data(data, database_file):
    pp.pprint(">>>>> STARTING DB INSERT <<<<<")
    con = sqlite3.connect(database_file)
    cur = con.cursor()
    for i, element in enumerate(data):
        cur.execute('insert into proteins (' +
                    'header, title, pbid, chain, X, Y, Z' +
                    ') VALUES (?,?,?,?,?,?,?)',
                    [element["header"], element["title"], element["pdbid"],
                     element["chain"], element["X"], element["Y"], element["Z"]])
        pp.pprint(str(((i + 1) / len(data)) * 100) + "% completed")
        con.commit()
    con.close()
    pp.pprint(">>>>> DONE WITH DB INSERT <<<<<")

def setup_db(database_file):
    con = sqlite3.connect(database_file)

    cur = con.cursor()

    cur.execute('create table if not exists proteins (' +
                'id integer primary key autoincrement,' +
                'header text,' +
                'title text,' +
                'pbid text,' +
                'chain text,' +
                'X float,' +
                'Y float,' +
                'Z float' +
                ')')
    con.commit()
    con.close()

database_file = "./protein.db"

setup_db(database_file)
insert_data(get_data(100), database_file)
