import os
import urllib.request
import re
import pprint

pp = pprint.PrettyPrinter(indent=2)

base_url = "https://www.icd-code.de/icd/code/"
starting_url = "ICD-10-GM.html"
list_of_ids = [ "H", "J" ]
tree = {}

def build_tree(url, ids, base):
    fileH = urllib.request.urlopen(url)
    for j in fileH.readlines():
        for i in ids:
            identification = re.search(r"<a href=\"(" + i + "\d\d-" + i + "\d\d.html)\">(\w\d\d-\w\d\d)<\/a><\/td><td>(.+?)<a", str(j))
            if identification == None: continue
            pp.pprint(identification.group(1))
            pp.pprint(identification.group(2))
            pp.pprint(identification.group(3))
            key = identification.group(3)
            tree[key] = {
                "link": base + identification.group(1),
                "detail": base + identification.group(3)
            }
            pp.pprint(tree[key]["link"])
            for l in urllib.request.urlopen(tree[key]["link"]).readlines():
                # TODO
                match1 = re.search(r"<a href=\"(\w\d\d-\w\d\d.html)\">(\w\d\d-\w\d\d)<\/a>(.+?)(<br>|<\/td>)", str(l))
                if match1 == None: continue
                pp.pprint(match1.group(1))
                pp.pprint(match1.group(2))
                pp.pprint(match1.group(3))
                for line in urllib.request.urlopen(tree[key]["link"]).readlines():
                    match2 = re.search(r"<a href=\"(" + i + "\d\d.-\*?.html)\">(" + i + "\d\d.-\*?)<\/a>(.+?)(<br>|<\/td>)", str(line))
                    if match2 == None: continue
                    pp.pprint(match2.group(1))
                    pp.pprint(match2.group(2))
                    pp.pprint(match2.group(3))



build_tree(base_url + starting_url, list_of_ids, base_url)
