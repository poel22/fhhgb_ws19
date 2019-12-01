# version 3.8.0
import urllib.request
import re
import pprint

PP = pprint.PrettyPrinter(indent=1)

BASE_URL = "https://www.icd-code.de/icd/code/"
STARTING_URL = "ICD-10-GM.html"
LIST_OF_IDS = ["H", "J"]


def build_tree(url, ids, base):
    tree = {}
    file = urllib.request.urlopen(url)
    for j in file.readlines():
        for i in ids:
            identification = re.search(r"<a href=\"(" + i + r"\d\d-" + i +
                                       r"\d\d.html)\">(\w\d\d-\w\d\d)<\/a><\/td><td>(.+?)<a",
                                       str(j))
            if identification is None:
                continue
            key = identification.group(2)
            tree[key] = {
                "link": base + identification.group(1),
                "detail": base + identification.group(3),
                "more": parse_second_level(i, base, base + identification.group(1))
            }
    PP.pprint(tree)

# def parse_first_level(url, ids, base, tree):


def parse_second_level(cur_id, base, link):
    tree = {}
    for line in urllib.request.urlopen(link).readlines():
        matches = re.findall(r"<a href=\"(" + cur_id +
                             r"\d\d-\w\d\d.html)\">(\w\d\d-\w\d\d)<\/a>(.+?)(<br\/>|<\/td>)",
                             str(line))
        if matches is None:
            continue
        for match in matches:
            key = match[1]
            sublink = base + match[0]
            tree[key] = {
                "link": sublink,
                "detail": match[2].strip(),
                "more": parse_third_level(cur_id, base, sublink)
            }
    return tree


def parse_third_level(cur_id, base, link):
    tree = {}
    for line in urllib.request.urlopen(link).readlines():
        matches = re.findall(r"<a href=\"(" + cur_id +
                             r"\d\d(?:.-\*?)?.html)\">(" + cur_id +
                             r"\d\d(?:.-\*?)?)<\/a>(.+?)(<br\/>|<\/td>)", str(line))
        if matches is None:
            continue
        for match in matches:
            key = match[1]
            sublink = base + match[0]
            tree[key] = {
                "link": sublink,
                "detail": match[2].strip(),
                "more": parse_fourth_level(cur_id, base, sublink)
            }
    return tree


def parse_fourth_level(cur_id, base, link):
    tree = {}
    for line in urllib.request.urlopen(link).readlines():
        matches = re.findall(r"<tr><td valign=\"top\"><div class=\"code_bottom\">(" + cur_id +
                             r"\d\d\.\d\d?(?:-?\*?)?)<\/div><\/td><td colspan=\"2\">(.+?)<\/td><\/tr>",
                             str(line))
        if matches is None:
            continue
        for match in matches:
            key = match[0]
            tree[key] = match[1].strip()
    return tree


build_tree(BASE_URL + STARTING_URL, LIST_OF_IDS, BASE_URL)
