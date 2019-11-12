import os
import urllib.request
import random
import gzip
import re
import pprint

pp = pprint.PrettyPrinter(indent=2)

filePath = "./ftpSourceView.txt";

fileContent = open(filePath).readlines();

sourceUrl = fileContent[0].split()[1]
print("URL: " + sourceUrl)

unzippedFiles = []


for i in range(100):
    data = {}
    fullUrl = sourceUrl + fileContent[2:][random.randint(0, len(fileContent) - 2)].split('"')[1] # faster than r"(\".*\")"
    content = gzip.GzipFile(fileobj=urllib.request.urlopen(fullUrl)).readlines()
    split = content[0].split()
    data["header"] = split[1].decode()
    data["pdbid"] = split[3].decode()
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
    pp.pprint(data)


