import os
import urllib.request
import re
import pprint

url = "https://www.icd-code.de/icd/code/ICD-10-GM.html"
list_of_ids = [ "H", "J" ]

def build_tree(url, ids):
    fileH = urllib.request.urlopen(url)
    for j in fileH.readlines():
        for i in ids:
            identification = re.search(r"<a href=\"(" + i + "\d\d-" + i + "\d\d.html)\">(\w\d\d-\w\d\d)<\/a><\/td><td>(.+?)<\/td>", str(j))
            if identification = None continue
            pp.pprint(identification.group(1))
            pp.pprint(identification.group(2))


build_tree(url, list_of_ids)
